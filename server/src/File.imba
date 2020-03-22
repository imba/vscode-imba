import {Component} from './Component'
import {CompletionItemKind,DiagnosticSeverity,SymbolKind} from 'vscode-languageserver-types'
import {Location} from 'vscode-languageserver'
import {ScriptElementKind} from 'typescript'
import * as util from './utils'
import { StyleDocument } from './StyleDocument'
var ts = require 'typescript'

var imbac = require 'imba/dist/compiler.js'
var sm = require "source-map"

var imbaOptions = {
	target: 'tsc'
	imbaPath: null
	silent: yes
	sourceMap: {}
}

export class File < Component
	prop symbols = []
	prop program

	/**
	@param {import("./LanguageServer").LanguageServer} program
	*/
	def constructor program, path
		super
		self.program = program
		jsPath   = path.replace(/\.(imba|js|ts)$/,'.js')
		imbaPath = path.replace(/\.(imba|js|ts)$/,'.imba')
		cssPath  = path.replace(/\.(imba|js|ts)$/,'.css')
		lsPath   = jsPath

		program.files[lsPath] = self
		program.files[imbaPath] = self
		program.files.push(self)

		if program && !program.rootFiles.includes(lsPath)
			program.rootFiles.push(lsPath)
		
		version = 1
		diagnostics = []
		syntaxDiagnostics = []
		emitted = {}
		invalidate!

		self


	get document
		let uri = 'file://' + imbaPath
		program.documents.get(uri)
	
	get styleDocument
		$styleDocument ||= StyleDocument.new(program,cssPath,self)

	get tls
		program.tls
	
	get ils
		program

	get uri
		'file://' + imbaPath

	def didOpen doc
		self.doc = doc
		content = doc.getText!
		# @emitFile()
		if semanticTokens
			sendSemanticTokens(semanticTokens)

	def didChange doc, event = null
		self.doc = doc

		# console.log 'did change!',version,doc.version
		version = doc.version
		content = doc.getText!
		$delay('emitFile',500)
		$clearSyntacticErrors!

	def didSave doc
		content = doc.getText!
		savedContent = content
		emitFile!

	def dispose
		delete program.files[jsPath]
		delete program.files[imbaPath]
		let idx = program.files.indexOf(self)
		program.files.splice(idx,1) if idx >= 0

		idx = program.rootFiles.indexOf(lsPath)
		program.rootFiles.splice(idx,1) if idx >= 0
		program.invalidate!
		self

	def emitFile
		$cancel('emitFile')
		# console.log 'emitFile',imbaPath
		let content = getSourceContent!
		# see if there are changes
		# this is usually where we should do the compilation?
		if content != lastEmitContent
			self.content = content
			lastEmitContent = content
			invalidate!
			version++
			program.invalidate!
		
		tls.getEmitOutput(lsPath) if tls


	def updateDiagnostics items = []
		
		# need to check if they are the same
		let out = for entry in items
			let lstart = originalLocFor(entry.start)
			let msg = entry.messageText
			let start = positionAt(lstart)
			let end = positionAt(originalLocFor(entry.start + entry.length) or (lstart + entry.length))
			let sev = [DiagnosticSeverity.Warning,DiagnosticSeverity.Error,DiagnosticSeverity.Information][entry.category]
			# console.log 'converting diagnostic',entry.category,entry.messageText
			{
				severity: sev
				message: msg.messageText or msg
				range: {start: start, end: end }
			}

		if JSON.stringify(out) != JSON.stringify(diagnostics)
			diagnostics = out
			sendDiagnostics!
		self

	def updateSyntaxDiagnostics items
		if JSON.stringify(items) != JSON.stringify(syntaxDiagnostics)
			syntaxDiagnostics = items
			sendDiagnostics!

	def sendDiagnostics
		let items = diagnostics.concat(syntaxDiagnostics)
		program.connection.sendDiagnostics(uri: uri, diagnostics: items)

	def $clearSyntacticErrors
		updateSyntaxDiagnostics([])
		
	def sendSemanticTokens tokens
		# return self
		semanticTokens = tokens

		try
			let doc = doc
			let items = []
			for token in tokens
				let item = [token._value,token._scope,token._kind,token._loc,token._len]
				continue if token._kind == 'accessor'

				if doc
					item.push(doc.positionAt(token._loc))
					item.push(doc.positionAt(token._loc + token._len))
					
				items.push(item)
			$decorations = items

			if doc
				sentTokens = items
				program.connection.sendNotification('entities',{uri: doc.uri,version: doc.version,markers: items})
		self

	# how is this converting?
	def positionAt offset
		if doc
			return doc.positionAt(offset)

		let loc = locs and locs.map[offset]
		return loc && {line: loc[0], character: loc[1]}

	def getSourceContent
		content ||= ts.sys.readFile(imbaPath)


	def offsetAt position
		return doc.offsetAt(position) if doc
		self.document && self.document.offsetAt(position)

	# remove compiled output etc
	def invalidate
		result = null
		cache = {
			srclocs: {}
			genlocs: {}
			contexts: {}
			symbols: null
		}
		self

	def compile
		unless result
			getSourceContent!
			var body = content
			
			var opts = Object.assign({},imbaOptions,{
				filename: imbaPath
				sourcePath: imbaPath
				# selfless: yes
				onTraversed: do |root,stack|
					let tokens = stack.semanticTokens()
					if tokens and tokens.length
						sendSemanticTokens(tokens)
			})

			try
				var res = imbac.compile(body,opts)
			catch e
				let loc = e.loc && e.loc()
				let range = loc && {
					start: positionAt(loc[0])
					end: positionAt(loc[1])
				}

				let err = {
					severity: DiagnosticSeverity.Error
					message: e.message
					range: range
				}
				# console.log 'compile error',err
				updateSyntaxDiagnostics([err])
				result = {error: err}
				js ||= "// empty"
				jsSnapshot ||= ts.ScriptSnapshot.fromString(js)
				return self

			# clear compile errors if there were any?
			updateSyntaxDiagnostics([])
			result = res
			locs = res.locs
			js = res.js.replace('$CARET$','valueOf')
			jsSnapshot = ts.ScriptSnapshot.fromString(js)
			$indexWorkspaceSymbols()

		return self
		
	def $indexWorkspaceSymbols
		cache.symbols ||= util.fastExtractSymbols(getSourceContent!)
		cache.workspaceSymbols ||= cache.symbols.map do |sym|
			{
				kind: sym.kind
				location: Location.create(uri,sym.span)
				name: sym.name
				containerName: sym.containerName
				type: sym.type
				ownName: sym.ownName
			}
		return self
	
	get workspaceSymbols
		$indexWorkspaceSymbols!
		return cache.workspaceSymbols

	def originalRangesFor jsloc
		locs.spans.filter do |pair|
			jsloc >= pair[0] and pair[1] >= jsloc

	def originalRangeFor {start,length}
		let spans = originalRangesFor(start)
		let hits = spans.length
		if hits > 0
			for span,i in spans
				let loff = start - span[0]
				let roff = (start + length) - span[1]
				if loff == 0 and roff == 0
					return {start: span[2],length: span[3] - span[2], end: span[3]}
				
		return null

	# need a better converter
	def originalLocFor jsloc
		let val = cache.srclocs[jsloc]
		if val != undefined
			return val

		let spans = originalRangesFor(jsloc)

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

		return cache.srclocs[jsloc] = val

	def generatedRangesFor loc
		return [] unless locs and locs.spans

		locs.spans.filter do |pair|
			loc >= pair[2] and pair[3] >= loc

	def generatedLocFor loc
		let spans = generatedRangesFor(loc)
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
		if span.length == 0
			let pos = positionAt(originalLocFor(span.start))
			return {start: pos,end: pos}
		let range = originalRangeFor(span)
		if range
			# let start = @originalLocFor(span.start)
			# let end = @originalLocFor(span.start + span.length)
			# console.log 'textSpanToRange',span,start,end,@locs and @locs.generated
			{start: positionAt(range.start), end: positionAt(range.end)}

	def textSpanToText span
		let start = originalLocFor(span.start)
		let end = originalLocFor(span.start + span.length)
		let content = getSourceContent!
		return content.slice(start,end)
	
	
	def tspGetCompletionsAtPosition toffset, ctx, options
		# $flush('emitFile')
		# let tsploc = generatedLocFor(loc)
		# console.log 'get tsp completions',loc,tsploc
		if let result = tls.getCompletionsAtPosition(lsPath,toffset,options)
			return util.tsp2lspCompletions(result.entries,file: self, jsLoc: toffset)
		return []

	def getCompletionsAtPosition loc, options = {}
		let ctx = getContextAtLoc(loc)
		let items = []
		let tloc = ctx.scope.tloc && ctx.scope.tloc.offset
		let snippets = ils.entities.getSnippetsForContext(ctx)
		inspect ctx

		let tls-options = {
			triggerCharacter: options.triggerCharacter
			includeCompletionsForModuleExports: true,
			includeCompletionsWithInsertText: true
		}

		if options.triggerCharacter == '\\'
			delete options.triggerCharacter

		if ctx.context == 'params' or ctx.context == 'naming' or ctx.context == 'tag'
			return []

		if ctx.context == 'supertag' or ctx.context == 'tagname'
			return ils.entities.getTagNameCompletions(options)
		
		if ctx.context == 'superclass'
			tloc = 0

		elif ctx.context == 'type'
			delete tls-options.triggerCharacter
			tloc = 0

		elif ctx.scope.tag or ctx.scope.class
			return snippets

		# direct acceess on an object -- we need to make sure file is compiled?
		if ctx.textBefore.match(/\.[\w\$\-]*$/) or ctx.context == 'object'
			# console.log 'get completions directly',loc,options
			$flush('emitFile')
			tloc = generatedLocFor(loc)
			# let tspitems = tspGetCompletionsAtPosition(loc,ctx,options)

		if typeof tloc == 'number'
			if let found = tls.getCompletionsAtPosition(lsPath,tloc,options)
				items = util.tsp2lspCompletions(found.entries,file: self, jsLoc: tloc)

		# returning these
		return items.filter do(item)
			if ctx.context == 'superclass' and item.label.match(/^[a-z]/)
				return no
			if ctx.context == 'type' and item.label.match(/^[a-z]/)
				return no if item.data.origKind == 'let'
				return no if item.data.origKind == 'keyword'
				return no if item.data.origKind == 'local var'
				return no if item.data.origKind == 'function'
				return no if item.data.origKind == 'property'

			return yes


	def getSymbols
		let tree = tls.getNavigationTree(lsPath)
		let conv = do |item|
			return if item.kind == 'alias' or item.text == 'meta$'
			
			let span = item.nameSpan
			// console.log 'converting symbol',item
			if item.kind == 'constructor'
				span = {start: item.spans[0].start, length: 11}
			
			return unless span
			
			let name = util.tsp2lspSymbolName(item.text)
			let range = textSpanToRange(span)
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
		try
			
			let symbols = tree.childItems.map(conv).filter(do !!$1)
			// console.log 'tree returned from typescript',symbols
			return symbols
		catch e
			log 'getSymbols error',e
			return []

	def getContextAtLoc loc
		return cache.contexts[loc] ||= util.fastExtractContext(getSourceContent!,loc,js)
