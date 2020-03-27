import {Component} from './Component'
import {CompletionItemKind,DiagnosticSeverity,SymbolKind} from 'vscode-languageserver-types'
import {Location} from 'vscode-languageserver'
import {ScriptElementKind} from 'typescript'
import * as util from './utils'
import { StyleDocument } from './StyleDocument'
import { FullTextDocument } from './FullTextDocument'
import { items } from '../../test/data'
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
	
	get doc
		$doc ||= FullTextDocument.create(uri,'imba',0,ts.sys.readFile(imbaPath))

	def didOpen doc
		$doc = doc
		if semanticTokens
			sendSemanticTokens(semanticTokens)

	def didChange doc, event = null
		$doc = doc
		version = doc.version
		cache.contexts = {}
		$delay('emitFile',500)
		$clearSyntacticErrors!

	def didSave doc
		savedContent = doc.getText!
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
		let content = doc.getText!
		if content != lastEmitContent
			lastEmitContent = content
			invalidate!
			version++
			log 'emitFile',uri,version
			program.invalidate!
		
		tls.getEmitOutput(lsPath) if tls


	def updateDiagnostics items = []
		
		# need to check if they are the same
		let out = for entry in items
			let lstart = originalLocFor(entry.start)
			let msg = entry.messageText
			let start = doc.positionAt(lstart)
			let end = doc.positionAt(originalLocFor(entry.start + entry.length) or (lstart + entry.length))
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
		doc.positionAt(offset)

	def offsetAt position
		doc.offsetAt(position)

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
			var body = doc.getText!
			
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
					start: doc.positionAt(loc[0])
					end: doc.positionAt(loc[1])
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
		cache.symbols ||= util.fastExtractSymbols(doc.getText!)
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

	# need to specify that this converts from typescript
	def textSpanToRange span
		if span.length == 0
			let pos = doc.positionAt(originalLocFor(span.start))
			return {start: pos,end: pos}
		let range = originalRangeFor(span)
		if range
			# let start = @originalLocFor(span.start)
			# let end = @originalLocFor(span.start + span.length)
			# console.log 'textSpanToRange',span,start,end,@locs and @locs.generated
			{start: doc.positionAt(range.start), end: doc.positionAt(range.end)}

	def textSpanToText span
		let start = originalLocFor(span.start)
		let end = originalLocFor(span.start + span.length)
		return doc.getText!.slice(start,end)

	def getCompletionsAtOffset offset, options = {}
		let ctx = getContextAtOffset(offset)
		# inspect ctx
		let context = doc.getContextAtOffset(offset)
		let items = []
		inspect context

		let {mode,scope,token} = context

		let include = {
			vars: 1
		}

		// first some tag completions
		if token.match('tag.event')
			log 'complete tag events!!'
			return ils.entities.getTagEventCompletions(context)
			return []
		
		if token.match('tag.modifier')
			return ils.entities.getTagEventModifierCompletions(context)
		
		if token.match('tag.flag')
			return ils.entities.getTagFlagCompletions(context)

		if js
			util.findCompiledOffsetForScope(scope,js)

		if mode.match(/regexp|string|comment|varname|naming|params/)
			log 'skip completions in context',mode
			return []

		if mode == 'supertag' or mode == 'tagname'
			return ils.entities.getTagNameCompletions(options)

		if mode == 'filepath'
			return ils.getPathCompletions(imbaPath,'')

		let snippets = ils.entities.getSnippetsForContext(ctx)

		let tloc = scope.closure.compiled-offset

		if mode == 'superclass' or mode == 'type'
			tloc = 0

		elif scope.type == 'tag' or scope.type == 'class'
			return snippets

		if options.triggerCharacter == '\\'
			delete options.triggerCharacter
		
		if context.textBefore.match(/\.[\w\$\-]*$/)
			include = {}

		# direct acceess on an object -- we need to make sure file is compiled?
		if context.textBefore.match(/\.[\w\$\-]*$/) or mode == 'object' or mode == 'object_value'
			# maybe we should still wait in many cases? And if compilation fails
			# we want to revert to broader completion
			$flush('emitFile')
			tloc = generatedLocFor(offset)
			log 'got generated loc',tloc

		if typeof tloc == 'number'
			
			if let found = tls.getCompletionsAtPosition(lsPath,tloc,options)
				items = util.tsp2lspCompletions(found.entries,file: self, jsLoc: tloc)

			log 'get items from tsp',items.length
			# for item in items
			# should we always show variables, no?
		
		if include.vars
			for item in context.vars
				items.push(
					label: item.value,
					kind: util.convertCompletionKind('local var')
					detail: "var {item.value}"
					sortText: '0'
					data: {resolved: yes, origKind: 'local var'}
				)

		# returning these
		return items.filter do(item)
			let kind = item.data.origKind
			
			if mode == 'superclass' and item.label.match(/^[a-z]/)
				return no
			
			if item.label.match(/\$/) and (kind == 'local var' or kind == 'let')
				return no

			if mode == 'type' and item.label.match(/^[a-z]/)
				return no if kind == 'let'
				return no if kind == 'keyword'
				return no if kind == 'local var'
				return no if kind == 'function'
				return no if kind == 'property'

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

	def getContextAtOffset loc
		return cache.contexts[loc] ||= util.fastExtractContext(doc.getText!,loc,doc.tokens,js)
