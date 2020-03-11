import {Component} from './Component'
import {CompletionItemKind,DiagnosticSeverity,SymbolKind} from 'vscode-languageserver-types'
import {Location} from 'vscode-languageserver'
import {ScriptElementKind} from 'typescript'
import * as util from './utils'
var ts = require 'typescript'

var imbac = require 'imba/dist/compiler.js'
var sm = require "source-map"

var imbaOptions = {
	target: 'tsc'
	imbaPath: null
	sourceMap: {}
}

export class File < Component
	prop symbols = []
	prop program

	/**
	@param {import("./LanguageServer").LanguageServer} program
	@param {ts.LanguageService} service
	*/
	def constructor program, path, service
		super
		@program = program
		@ls = program.service
		@jsPath   = path.replace(/\.(imba|js|ts)$/,'.js')
		@imbaPath = path.replace(/\.(imba|js|ts)$/,'.imba')
		@lsPath   = @jsPath
		
		@version = 1
		@diagnostics = []
		@emitted = {}
		@invalidate()

		console.log "created file {path}"

		program.files[@lsPath] = self
		program.files[@imbaPath] = self
		program.files.push(self)

		if program && !program.rootFiles.includes(@lsPath)
			program.rootFiles.push(@lsPath)
		self


	get document
		let uri = 'file://' + @imbaPath
		@program.documents.get(uri)

	get $tsp
		@program.service
	
	get $lsp
		@program

	get uri
		'file://' + @imbaPath

	def didOpen doc
		@doc = doc
		@content = doc.getText()
		# @emitFile()
		if @semanticTokens
			console.log 'resending semantic tokens'
			@sendSemanticTokens(@semanticTokens)

	def didChange doc, event = null
		@doc = doc

		console.log 'did change!',@version,doc.version
		@version = doc.version
		@content = doc.getText()
		$delay('emitFile',500)

		# when we introduce partial updates we only want
		# to hide errors that are close to this
		$clearSyntacticErrors!
		# if test
		# @emitFile()

	def didSave doc
		@content = doc.getText!
		@savedContent = @content
		@emitFile!
		# resave semantic tokens etc?

	def dispose
		delete @program.files[@jsPath]
		delete @program.files[@imbaPath]
		let idx = @program.files.indexOf(self)
		@program.files.splice(idx,1) if idx >= 0

		idx = @program.rootFiles.indexOf(@lsPath)
		@program.rootFiles.splice(idx,1) if idx >= 0
		@program.version++
		self

	def emitFile
		$cancel('emitFile')
		console.log 'emitFile',@imbaPath
		let content = @getSourceContent!
		# see if there are changes
		# this is usually where we should do the compilation?
		if content != @lastEmitContent
			@content = content
			@lastEmitContent = @content
			@invalidate!
			@version++
			@program.version++

		let result = @ls.getEmitOutput(@lsPath)

	def updateDiagnostics items = []
		
		# need to check if they are the same
		let out = for entry in items
			let lstart = @originalLocFor(entry.start)
			let msg = entry.messageText
			let start = @positionAt(lstart)
			let end = @positionAt(@originalLocFor(entry.start + entry.length) or (lstart + entry.length))
			let sev = [DiagnosticSeverity.Warning,DiagnosticSeverity.Error,DiagnosticSeverity.Information][entry.category]
			console.log 'converting diagnostic',entry.category,entry.messageText
			{
				severity: sev
				message: msg.messageText or msg
				range: {start: start, end: end }
			}

		if JSON.stringify(out) != JSON.stringify(@diagnostics)
			console.log 'update diagnostics',@jsPath,out
			@diagnostics = out
			@program.connection.sendDiagnostics(uri: @uri, diagnostics: @diagnostics)
		self

	

	def sendDiagnostics
		@program.connection.sendDiagnostics(uri: @uri, diagnostics: @diagnostics)

	def $clearSyntacticErrors
		@updateDiagnostics([])
		
	def sendSemanticTokens tokens
		# return self
		@semanticTokens = tokens

		try
			# let doc = @document
			let items = []
			for token in tokens
				let item = [token._value,token._scope,token._kind,token._loc,token._len]
				continue if token._kind == 'accessor'
				# if token._level != undefined
				#	item[1] = `var{token._level}`

				if @doc
					item.push(@doc.positionAt(token._loc))
					item.push(@doc.positionAt(token._loc + token._len))
					
				items.push(item)
				# {start: doc.positionAt(loc[0]), end: doc.positionAt(loc[1])}
			$decorations = items

			if @doc
				# console.log 'sending tokens',@uri,items
				@sentTokens = items
				@program.connection.sendNotification('entities',{uri: @doc.uri,version: @doc.version,markers: items})
		self

	# how is this converting?
	def positionAt offset
		if @doc
			return @doc.positionAt(offset)

		let loc = @locs and @locs.map[offset]
		return loc && {line: loc[0], character: loc[1]}

	def getSourceContent
		@content ||= ts.sys.readFile(@imbaPath)


	def offsetAt position
		@document && @document.offsetAt(position)

	# remove compiled output etc
	def invalidate
		@result = null
		@cache = {
			srclocs: {}
			genlocs: {}

		}
		self

	def compile
		unless @result
			@getSourceContent()
			var body = @content
			
			var opts = Object.assign({},imbaOptions,{
				filename: @imbaPath
				sourcePath: @imbaPath
				# selfless: yes
				onTraversed: do |root,stack|
					let tokens = stack.semanticTokens()
					if tokens and tokens.length
						@sendSemanticTokens(tokens)
						# setTimeout(&,10) do @sendSemanticTokens(tokens)
			})

			try
				var res = imbac.compile(body,opts)
			catch e
				let loc = e.loc && e.loc()
				let range = loc && {
					start: @positionAt(loc[0])
					end: @positionAt(loc[1])
				}

				let err = {
					severity: DiagnosticSeverity.Error
					message: e.message
					range: range
				}
				# console.log 'compile error',err
				@diagnostics = [err]
				@sendDiagnostics()
				@result = {error: err}
				@compileErrors = [err]
				@js ||= "// empty"
				@jsSnapshot ||= ts.ScriptSnapshot.fromString(@js)
				return self

			# clear compile errors if there were any?
			if @compileErrors
				@compileErrors = null
				@diagnostics = []
				@sendDiagnostics()

			@result = res
			@locs = res.locs
			@js = res.js.replace('$CARET$','valueOf')
			@jsSnapshot = ts.ScriptSnapshot.fromString(@js)
			$indexWorkspaceSymbols()

		return self
		
	def $indexWorkspaceSymbols
		@symbols = util.fastExtractSymbols(@content).map do |sym|
			{
				kind: sym.kind
				location: Location.create(@uri,sym.span)
				name: sym.name
				containerName: sym.containerName
			}
	
		return self

	def originalRangesFor jsloc
		@locs.spans.filter do |pair|
			jsloc >= pair[0] and pair[1] >= jsloc

	def originalRangeFor {start,length}
		let spans = @originalRangesFor(start)
		if spans.length > 0
			for span in spans
				let loff = start - span[0]
				let roff = (start + length) - span[1]
				if loff == 0 and roff == 0
					return {start: span[2],length: span[3] - span[2], end: span[3]}
		return null

	# need a better converter
	def originalLocFor jsloc
		let val = @cache.srclocs[jsloc]
		if val != undefined
			return val

		let spans = @originalRangesFor(jsloc)

		if let span = spans[0]
			let into = (jsloc - span[0]) / (span[1] - span[0])
			let offset = Math.floor(into * (span[3] - span[2]))
			# console.log 'found originalLocFor',jsloc,spans
			if span[0] == jsloc
				val = span[2]
			elif span[1] == jsloc
				val = span[3]
			else
				val = span[2] + offset

		return @cache.srclocs[jsloc] = val

	def generatedRangesFor loc
		@locs.spans.filter do |pair|
			loc >= pair[2] and pair[3] >= loc

	def generatedLocFor loc
		let spans = @generatedRangesFor(loc)
		if let span = spans[0]
			let into = (loc - span[2]) / (span[3] - span[2])
			let offset = Math.floor(into * (span[1] - span[0]))
			# console.log 'found generatedLocFor',loc,spans
			if loc == span[2]
				return span[0]
			elif loc == span[3]
				return span[1]
			else
				return span[0] + offset
		return null

	def textSpanToRange span
		let range = @originalRangeFor(span)
		if range
			# let start = @originalLocFor(span.start)
			# let end = @originalLocFor(span.start + span.length)
			# console.log 'textSpanToRange',span,start,end,@locs and @locs.generated
			{start: @positionAt(range.start), end: @positionAt(range.end)}

	def textSpanToText span
		let start = @originalLocFor(span.start)
		let end = @originalLocFor(span.start + span.length)
		let content = @getSourceContent()
		return content.slice(start,end)
	
	
	def tspGetCompletionsAtPosition loc, ctx, options
		$flush('emitFile')
		let tsploc = @generatedLocFor(loc)
		# console.log 'get tsp completions',loc,tsploc
		if let result = @ls.getCompletionsAtPosition(@lsPath,tsploc,options)
			return util.tsp2lspCompletions(result.entries,file: self, jsLoc: tsploc)
		return []
	
	def getMemberCompletionsForPath ref, context
		# ref could be like ClassName.prototype
		
		# remove the last part
		ref = ref.replace(/[\w\-]+$/,'')
		
		if @js
			let typ = ref.slice(-1)
			let cls = ref.slice(0,-1)
			let comment = "/*¡{cls}*/"
			let loc = @js.indexOf(comment)
			
			if loc and loc > 0
				if typ == '#'
					loc = loc + (comment + 'prototype.').length

				if let result = @ls.getCompletionsAtPosition(@lsPath,loc,{})
					return util.tsp2lspCompletions(result.entries,file: self, jsLoc: loc, meta: {member: yes})

		return []


	def getSymbols
		let tree = $tsp.getNavigationTree(@lsPath)

		let conv = do |item|
			return if item.kind == 'alias' or item.text == 'meta$'
			
			let span = item.nameSpan

			if item.kind == 'constructor'
				span = {start: item.spans[0].start, length: 11}

			let name = util.tsp2lspSymbolName(item.text)
			let range = @textSpanToRange(span)
			let kind = util.convertSymbolKind(item.kind)

			return unless range and range.start

			let children = item.childItems or []

			if item.kind == 'method' or item.kind == 'function'
				children = []

			return {
				kind: kind
				name: name
				range: range
				selectionRange: range
				children: children.map(conv).filter(do !!$1)
			}

		return tree.childItems.map(conv).filter(do !!$1)


	def getContextAtLoc loc
		let lft = loc
		let rgt = loc
		let code = @getSourceContent()
		let len = code.length
		let chr
		let res = {
			loc: loc
		}
		
		# first find the line and indentation 

		while lft and (loc - lft) < 300
			chr = code[--lft]
			if chr == '>'
				break

			if chr == '<'
				break

		while rgt < (loc + 300)
			chr = code[rgt++]
			if chr == '>' or chr == ''
				break
				
		let textBefore = code.slice(0,loc)
		let textAfter = code.slice(loc)
		
		let lnstart = textBefore.lastIndexOf('\n')
		let lnend = textAfter.indexOf('\n')
		let linesBefore = textBefore.split('\n')
		# find the indentation of the current line
		# console.log loc,lft,rgt
		res.start = lft
		res.length = rgt - lft
		# res.string = code.slice(lft,rgt)
		res.textBefore = linesBefore[linesBefore.length - 1]
		res.textAfter = textAfter.split('\n')[0]
		
		
		let currIndent = res.textBefore.match(/^\t*/)[0].length
		let indents = [res.textBefore.slice(currIndent)]
		res.indent = currIndent
		let ln = linesBefore.length
		while ln > 0
			let line = linesBefore[--ln]
			continue if line.match(/^[\t\s]*$/)
			let ind = line.match(/^\t*/)[0].length
			if ind < currIndent
				currIndent = ind
				indents.unshift(line.slice(ind))
		
		res.indents = indents
		@compile()
		res.scope = {type: 'root',root: yes,body: yes}
		res.tagtree = []
		res.tokens = @result && !!@result.tokens
		res.path = ""
		
		# find variables before this position?
		for line in indents
			let scope
			if let m = line.match(/^(export )?(tag|class) ([\w\-]+)/)
				scope = {type: m[2], name: m[3],parent: res.scope}
				scope[m[2]] = m[3]
				res.className = m[3]
				res.path += res.className
				
			elif let m = line.match(/^(static )?(def|get|set) ([\w\-]+)/)
				scope = {type: m[2], name: m[3],body: yes,parent: res.scope}
				scope[m[2]] = m[3]
				res.methodName = m[3]
				res.static = !!m[1]
				res.path += (m[1] ? '.' : '#') + m[3]

			elif let m = line.match(/^\<([\w\-]+)/)
				res.tagtree.push(m[1])
				res.scope.html = yes
				# scope = {type: m[2], name: m[3]}
				
			if scope
				res.scope = scope
			
		
		# could use the actual lexer to get better info about this?
		
		if code[lft] == '<' && code[rgt - 1] == '>' and code.substr(lft,4).match(/^\<[\w\{\[\.\#\>]/)
			res.context = 'tag'
			res.string = code.slice(lft,rgt)
			res.tagName = (res.string.match(/\<([\w\-\:]+)/) or [])[1]
			res.before = code.slice(lft,loc)
			res.after = code.slice(loc,rgt)
			res.pattern = res.before + '˘' + res.after
			res.prefix = res.before[res.before.length - 1]
			# should move forward 
			let i = lft
			let stack = []
			let pairs = []
			while i < loc
				chr = code[i++]

				if stack[0] == '('
					if chr == ')'
						stack.shift()
						continue

				if stack[0] == '{'
					if chr == '}'
						stack.shift()
						continue 

				if chr == '(' or chr == '{' or chr == '['
					stack.unshift(chr)

				elif chr == '<'
					stack.unshift('tag')
				elif chr == ' '
					# if stack[0] == 'event'
					# need to deal with 
					stack.unshift('attr')
				elif chr == '='
					stack.unshift('value')
				elif chr == ':'
					stack.unshift('event')
					# include the name of the event?
				elif chr == '.'
					if stack[0] == 'event' or stack[0] == 'modifier'
						stack[0] = 'modifier'
					else
						stack.unshift('flag')

			res.stack = stack
		return res
