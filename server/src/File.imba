import {Component} from './Component'
import {CompletionItemKind,DiagnosticSeverity,SymbolKind,Location} from 'vscode-languageserver-types'
# import {Location} from 'vscode-languageserver'

import * as util from './utils'
import { FullTextDocument } from './FullTextDocument'
import { items } from '../../test/data'
import {Keywords,KeywordTypes,CompletionTypes,Sym,SymbolFlags} from 'imba/program'
import {Diagnostics, DiagnosticKind} from './Diagnostics'
import * as ts from 'typescript'
import type {Diagnostic} from 'typescript'
import type {LanguageServer} from './LanguageServer'
import system from './system'

const imbac = require 'imba/compiler'
const imba1c = require '../imba1.compiler.js'

let imbaOptions = {
	target: 'tsc'
	platform: 'tsc'
	imbaPath: null
	silent: yes
	sourcemap: 'hidden'
}

###
Represents the combination of an imba-file and its compiled ts/js
with functionality to map locations back and forth between the two
###
export class File < Component
	prop symbols = []
	removed = no

	static def build ils,src
		let ext = util.t2iPath(src.slice(src.lastIndexOf('.')))

		let types = {
			'.json': JSONFile
			'.imba': ImbaFile
			'.imba1': Imba1File
			'.svg': SVGFile
			'.png': ImageFile
			'.jpg': ImageFile
			'.jpeg': ImageFile
			'.gif': ImageFile
			'.html': HTMLFile
		}

		let cls = types[ext] or File
		return new cls(ils,src)

	def constructor program\LanguageServer, path
		super
		version = 1
		self.program = program
		fileName = util.t2iPath(path)
		program.files[fileName] = self
		program.files[tfileName] = self
		program.files.push(self)

	get shouldEmitDiagnostics
		no
	
	get ils
		program

	get tls
		isLegacy ? null : program.tls

	get uri
		util.pathToUri(fileName)

	get document
		program.documents.get(uri)

	get tfileName
		util.i2tPath(fileName)

	get tsPath
		tfileName
		
	get tlsfile
		ils.getProgram!.getSourceFile(tfileName)

	get tscriptKind
		ts.ScriptKind.JS

	get imbaPath
		fileName

	get workspaceSymbols
		[]

	def getCompiledBody
		""
		# String(system.readFile(fileName))

	def getSourceBody
		doc.getText!

	def getScriptSnapshot
		#snapshot ||= ts.ScriptSnapshot.fromString(getCompiledBody!)


	def textSpanToRange
		return {start: {line:0,character:0},end: {line:0,character:0}}

	def textSpanToText
		return ""

	def dispose
		self

	def onDidChangeTextEditorSelection params
		yes



		

export class ImbaFile < File

	def constructor program\LanguageServer, path
		super
		isLegacy = fileName.indexOf('.imba1') > 0 or program.isLegacy

		if program && !program.rootFiles.includes(tfileName) and !isLegacy
			program.rootFiles.push(tfileName)

		logLevel = fileName.indexOf('Diagnostics') >= 0 ? 3 : 0
		diagnostics = new Diagnostics(self)
		emitted = {}
		times = {}
		_isTyping = no
		invalidate!
		self
	
	get shouldEmitDiagnostics
		yes

	get doc
		$doc ||= FullTextDocument.create(uri,'imba',0,system.readFile(fileName))
	
	get idoc
		doc.tokens

	get tsfile
		ils.getProgram!.getSourceFile(tsPath)

	get isTyping
		_isTyping

	set isTyping value
		if _isTyping =? value
			yes

	def getCompiledBody
		compile!
		js

	def getScriptSnapshot
		getCompiledBody!
		return jsSnapshot

	def didOpen doc
		$doc = doc
		if doc.tokens
			isLegacy = doc.tokens.isLegacy
		times.opened = Date.now!
		getDiagnostics!

	def didChange doc, event = null
		$doc = doc
		version = doc.version
		cache.contexts = {}
		
		diagnostics.sync!
		times.edited = Date.now!
		if version > 1
			isTyping = yes
			$delay('emitFile',5000)
		else
			$delay('emitFile',10)

		# console.log 'didChange'
		# $clearSyntacticErrors! # only if our regions have changed?!?

	def didSave doc
		savedContent = doc.getText!
		emitFile(true)
		diagnostics.sync!
		times.saved = Date.now!
		isTyping = no

	def dispose
		delete program.files[fileName]
		let idx = program.files.indexOf(self)
		program.files.splice(idx,1) if idx >= 0

		idx = program.rootFiles.indexOf(fileName)
		program.rootFiles.splice(idx,1) if idx >= 0
		program.invalidate!
		self

	def emitFile refresh = yes
		$cancel('emitFile')
		
		let content = doc.getText!
		if content != lastEmitContent
			lastEmitContent = content
			invalidate!
			version++
			log 'emitFile',uri,version,isLegacy
			program.invalidate! unless isLegacy
		
		if tls
			tls.getEmitOutput(fileName)
			getDiagnostics! if refresh
		else
			compile!
		return self

	def updateDiagnostics items\Diagnostic[] = [], versions
		let kind = DiagnosticKind.TypeScript | DiagnosticKind.Semantic
		unless result and result.error
			diagnostics.update(kind,items,versions)
		return self

	# how is this converting?
	def positionAt offset
		doc.positionAt(offset)

	def offsetAt position
		doc.offsetAt(position)

	def rangeAt start, end
		idoc.rangeAt(start,end)

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
		return if isLegacy

		unless result
			let body = doc.getText!
			let iversion = idoc.version
			let opts = Object.assign({},imbaOptions,{
				filename: fileName
				sourcePath: fileName
			})
			let res = null

			try
				let compiler = isLegacy ? imba1c : imbac
				res = util.time(&,'compilation took') do
					compiler.compile(body,opts)
			catch e
				let loc = e.loc && e.loc()
				let range = loc && {
					offset: loc[0]
					length: loc[1] - loc[0]
				}

				let err = {
					severity: DiagnosticSeverity.Error
					message: e.message
					range: range
				}
				diagnostics.update(DiagnosticKind.Compiler,[err])
				result = {error: err}
				js ||= "// empty"
				jsSnapshot ||= ts.ScriptSnapshot.fromString(js)
				return self

			diagnostics.update(DiagnosticKind.Compiler,res.diagnostics or [])

			if res.errors && res.errors.length
				# Should rather keep the last successfully compiled version?
				js ||= "// empty"
				jsSnapshot ||= ts.ScriptSnapshot.fromString(js)
				result = {error: res.errors[0]}
				return
			# diagnostics.update(DiagnosticKind.Compiler,[])

			# potential memory leak?
			result = res
			locs = res.locs

			if locs
				locs.version = iversion
	
			js = res.js.replace(/\$CARET\$/g,'valueOf')
			tsVersion = iversion
			jsSnapshot = ts.ScriptSnapshot.fromString(js)
			$indexWorkspaceSymbols()

		return self
		
	def $indexWorkspaceSymbols
		cache.symbols ||= util.fastExtractSymbols(doc.getText!,imbaPath)
		cache.workspaceSymbols ||= cache.symbols.map do |sym|
			sym.location = Location.create(uri,sym.span)
			sym
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

	def sourceRangeAt start, end
		for [ts0,ts1,imba0,imba1] in locs.spans
			if start == ts0 and end == ts1
				return idoc.rangeAt(imba0,imba1)
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

	def getDiagnostics
		return unless tls and result and !result.error

		let entries = tls.getSemanticDiagnostics(tsPath)
		let kind = DiagnosticKind.TypeScript | DiagnosticKind.Semantic
		diagnostics.update(kind,entries)
		self
	
	def getDefinitionAtPosition pos
		return if isLegacy
		let offset = offsetAt(pos)
		let ctx = idoc.getContextAtOffset(offset)

		if ctx.mode == 'tag.name'
			let info = ils.entities.getTagTypeInfo(ctx.tag.name)
			return info.map(do $1.location).filter(do $1)
		elif ctx.mode == 'tag.attr'
			# let info = ils.entities.getTagAttrInfo(ctx.token.value,ctx.tag.name)
			let matches = ils.entities.getTagQuery(ctx.tag.name).filter do
				!$1.static and $1.ownName == ctx.token.value and ($1.type == 'prop' or $1.type == 'set')
			return matches.map do $1.location
			# log 'tag attr info',info
			# return info ? [info.location] : null
		elif ctx.mode == 'tag.modifier' or ctx.mode == 'tag.event-modifier'
			let items = ils.entities.getTagEventModifierCompletions(ctx)
			let item = items.find do $1.label == ctx.token.value
			if item and item.data.location
				return [item.data.location]
		return
	
	def getAdjustmentEdits pos, amount = 1
		let loc =  offsetAt(pos)
		let edit = idoc.adjustmentAtOffset(loc,amount)
		return edit

	def getQuickInfoAtPosition pos
		return if isLegacy

		let offset = offsetAt(pos)

		let ctx = idoc.getContextAtOffset(offset)

		# see if we should move one step ahead
		if ctx.after.token == '' and !ctx.before.character.match(/\w/)
			if ctx.after.character.match(/[\w\$]/)
				ctx = idoc.getContextAtOffset(offset + 1)

		let grp = ctx.group
		let tok = ctx.token or {match: (do no)}

		if ctx.token and !ctx.token.value
			log 'token without value',ctx.token

		let range = idoc.getTokenRange(ctx.token)

		# console.log 'the context we got here',ctx.mode,range
		try
			let info = null
			let csspropkey = grp.closest('stylepropkey')
			let cssprop = grp.closest('styleprop')

			if csspropkey
				info = ils.entities.getCSSInfo(ctx)

			if tok.match('style.value')
				info = ils.entities.getCSSValueInfo(tok.value,cssprop.propertyName,ctx)
		
			if info and info.markdown
				return {range: range, contents: {kind: 'markdown', value: info.markdown}}

		
		# log 'getting context',offset,range,ctx.token,ctx.mode
	
		let element = ctx.tag
		let elinfo = ctx.tag and ctx.tag.name and ils.entities.getTagTypeInfo(ctx.tag.name)

		if ctx.mode == 'tag.attr'
			let info = ils.entities.getTagAttrInfo(ctx.token.value,ctx.tag.name)
			log 'tag attribute',ctx.token.value,info
			if info
				return {range: range, contents: info.description or info.name}

		elif ctx.mode == 'tag.event'
			let info = ils.entities.getTagEventInfo(ctx.token.value,ctx.tag.name)
			return {range: range, contents: info.description} if info

		elif ctx.mode == 'tag.modifier' or ctx.mode == 'tag.event-modifier'
			let items = ils.entities.getTagEventModifierCompletions(ctx)
			let item = items.find do $1.label == ctx.token.value
			if item
				return {range: range, contents: (item.detail or item.label)}
		
		elif ctx.mode == 'tag.name'
			let tagName = element.name or ctx.tagName..value
			log 'tagName',element.name
			let types = ils.entities.getTagTypesForNamePattern(ctx.tag.name)
			log 'potential types',types.map do $1.name

			range = doc.tokens.getTokenRange(ctx.tagName)

			if let info = ils.entities.getTagTypeInfo(tagName)
				let markdown = ''
				for item,k in info
					markdown += '\n\n' if k > 0
					markdown += "```html\n<{item.name}>\n```\n" + item.description.value + '\n\n'
					for ref,i in item.references
						markdown += ' | ' if i > 0
						markdown += "[{ref.name}]({ref.url})"

				return {range: range, contents: {kind: 'markdown',value: markdown}}

			return
		
		elif ctx.mode.match(/tag\./)
			return

		if let gen-offset = generatedLocFor(offset)
			if let info = tls.getQuickInfoAtPosition(tsPath, gen-offset)
				let contents = [{
					value: ts.displayPartsToString(info.displayParts)
					language: 'typescript'
				}]

				if info.documentation
					contents.push(value: ts.displayPartsToString(info.documentation), language: 'text')
				return {
					range: range
					contents: contents
				}

		return null

	def getTypeContext
		let prog = ils.getProgram!
		return {file: prog.getSourceFile(tsPath), checker: prog.getTypeChecker!, program: prog}

	def getSelfAtOffset offset
		let context = idoc.getContextAtOffset(offset)
		let scope = context.scope.selfScope
		let base = scope.closest do $1.class?

		let {file,checker,program} = getTypeContext!
		let type = null

		if base
			if let sym = file.locals.get(base.path)
				type = checker.getTypeOfSymbolAtLocation(sym,file)
				type.#path = "{base.path}"
		
		if type and scope.member? and !scope.static?
			let sym = type.getProperty('prototype')
			type = checker.getTypeOfSymbolAtLocation(sym,file)
			type.#checker = checker
			type.#symbol = sym
			type.#file = file
			type.#path = "{base.path}.prototype"

		return type

	def getGlobalType
		# could be cached?
		let {file,checker,program} = getTypeContext!
		let sym = checker.resolveName('globalThis',undefined,ts.SymbolFlags.Value,false)
		checker.getTypeOfSymbolAtLocation(sym,file)

	def getCompletionDetailsForPath path
		let {file,checker,program} = getTypeContext!
		let type = null
		let target = null
		let parts = path.split('.')
		
		while let part = parts.shift!
			let sym = target ? target.#type.getProperty(part) : file.locals.get(part)
			let type = sym.#type = checker.getTypeOfSymbolAtLocation(sym,file)
			if !parts.length
				sym.#details = ts.Completions.createCompletionDetailsForSymbol(sym,checker,file,file)
			target = sym
		
		if target and target.#details
			return target.#details
		
		return


	def getTypeOfSymbolAtOffset offset
		let {file,checker,program} = getTypeContext!
		let tsloc = generatedLocFor(offset)
		let tok = ts.findPrecedingToken(tsloc,file)
		let origTok = tok
		if $web$
			global.T = tok
			global.checker = checker
			global.checkerNode = origTok
		devlog 'getTypeOfSymbolAtOffset',tsloc,offset,tok

		let type = null

		let logtok = do(tok)
			devlog "tok {tok.kind}",tok,checker.getTypeAtLocation(tok)

		if tok and (tok.kind == 24 or tok.kind == 28)
			tok = tok.parent

			if tok.kind == 201
				logtok tok._children[0]
				type = checker.getTypeAtLocation(tok._children[0])
			else
				tok = tok.expression
		
		unless type
			try
				let sym = checker.getSymbolAtLocation(tok)
				type = checker.getTypeOfSymbolAtLocation(sym,file)

		if type
			type.#node = origTok
			type.#file = file
			type.#checker = checker
		return type

	def getCompletionsAtOffset offset, options = {}
		let items = []
		let names = new Map

		return if isLegacy	

		let ctx = idoc.getContextAtOffset(offset)
		let tok = ctx.token
		let that = getSelfAtOffset(offset)
		let vars = idoc.varsAtOffset(offset,yes)
		let target = that
		let suggest = ctx.suggest
		let flags = suggest.flags
		let filters = {kinds: []}
		let tsoffset = null
		let keywordFilter = 0

		let add = do(item)
			names.set(item.label,item)
			items.push(item)
	
		# $delay('emitFile',5000)

		# console.log 'getCompletions',imbaPath,options,tok.type,ctx.before,suggest,!!that
		# console.log ils.config.config
		let t = CompletionTypes
		let opts = Object.assign({},ils.config.config.suggest,suggest)

		if flags == 0
			return []

		if flags & t.TagName
			return ils.entities.getTagNameCompletions(ctx.group,opts)

		if flags & t.TagProp
			return ils.entities.getTagAttrCompletions(ctx.group,opts)
		
		if flags & t.TagEvent
			return ils.entities.getTagEventCompletions(ctx.group,opts)
		
		if flags & t.TagEventModifier
			return ils.entities.getTagEventModifierCompletions(ctx.group,opts)

		if flags & t.StyleValue
			items = ils.entities.getCSSValueCompletions(ctx,opts)

			if flags & t.StyleProp
				items.push(...ils.entities.getCSSPropertyCompletions(ctx.group,opts))

			return items

		if flags & t.StyleProp
			return ils.entities.getCSSPropertyCompletions(ctx.group,opts)

		


		# find the access chain
		if tok.match('operator.access')
			tsoffset = generatedLocFor(offset)
			util.time do $flush('emitFile',false)
			let tscompletions = tls.getCompletionsAtPosition(fileName,tsoffset,{})
			let completions = util.tsp2lspCompletions(tscompletions.entries,{file:self,jsLoc:tsoffset})
			return completions

			if let type = getTypeOfSymbolAtOffset(offset)
				target = type

		if tok.match('identifier')
			filters.startsWith = ctx.before.token
		
		if tok.match('keyword')
			# could include snippets
			return []

		if target && !ctx.scope.class?
			# console.dir target, depth: 0
			devlog 'completions for target',target

			let props = target.getApparentProperties!

			if $web$
				global.props = props

			for item in props
				devlog 'get property',item
				let name = item.escapedName
				continue if name.match(/^(__@|")/)
				continue unless item.flags & ts.SymbolFlags.Value
				let kind = util.tsSymbolFlagsToKindString(item.flags)
				let data = {resolved: yes, symbolFlags: item.flags, path: fileName}

				if target.#path
					data.symbolPath = "{target.#path}.{name}"
					data.resolved = no

				add(
					label: name
					kind: kind
					sortText: '0'
					symbol: item
					data: data
				)
		
		# if target is implicit value
		if target == that
			for keyword in suggest.keywords
				add(
					label: keyword
					kind: CompletionItemKind.Keyword
					detail: 'keyword'
				)
		
		if target == that and !ctx.scope.class?
			# also show for target?
			let glob = getGlobalType!
			for item in glob.getProperties!
				let name = item.escapedName
				continue unless name.match(/^[A-Z]/)
				# rather continue unless we're dealing with the node-global?
				# continue unless item.flags & ts.SymbolFlags.Type
				
				add(
					label: name
					kind: CompletionItemKind.Variable
					sortText: '0'
					symbol: item
				)

			for variable in vars
				let sym = variable
				let name = variable.name
				if variable.type == 'global'
					sym = glob.getProperty(name)

				let other = names.get(name)

				if other and other.kind == 'property'
					other.insertText = other.label = "self.{other.label}"

				add(
					label: variable.name
					sortText: '0'
					symbol: sym
				)

		# convert to actual completions
		let results = for item in items
			let sym = item.symbol
			if sym isa Sym
				item.kind ||= sym.semanticKind
				item.label = sym.name
				item.detail = "{sym.semanticKind} {sym.name}"

			if filters.startsWith
				let idx = item.label.indexOf(filters.startsWith)
				if idx != 0 and item.label[idx - 1] != '.'
					continue

			if filters.kinds.length
				continue unless filters.kinds.indexOf(item.kind) >= 0

			item.kind ||= 'variable'
			if typeof item.kind == 'string'
				item.kind = util.convertCompletionKind(item.kind)

			delete item.symbol	
			item.data ||= {resolved: yes}
			item

		return results


	def getSymbols
		let outline = idoc.getOutline do(item)
			# item.kind = util.convertSymbolKind(item.kind)
			item.range = item.span
			item.selectionRange = item.range
			if typeof item.kind == 'string'
				item.kind = util.convertSymbolKind(item.kind)

		return outline.children

	def onDidChangeTextEditorSelection event
		const now = times.selection = Date.now!
		# console.log 'file selection change',now - times.edited
		if isTyping and (now - times.edited) > 3
			isTyping = no
			$flush('emitFile')
			diagnostics.sync!

export class Imba1File < ImbaFile

export class JSONFile < File

export class AssetFile < File

export class HTMLFile < AssetFile

export class ImageFile < AssetFile

export class SVGFile < AssetFile

	def getCompiledBody
		return 'export default /** @type {ImbaAsset} */({})'
		# super