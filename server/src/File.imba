import {Component} from './Component'
import {CompletionItemKind,DiagnosticSeverity,SymbolKind,Location,LocationLink} from 'vscode-languageserver-types'


import * as util from './utils'
import { FullTextDocument } from './FullTextDocument'
import {Keywords,KeywordTypes,CompletionTypes,Sym,SymbolFlags} from 'imba/program'
import {Diagnostics, Diagnostic, FileDiagnostic, DiagnosticKind} from './Diagnostics'
import * as ts from 'typescript'
import type {TypeNode,TypeFlags} from 'typescript'
import type {LanguageServer} from './LanguageServer'

import system from './system'
import { CompletionsContext } from './Completions'
import { ProgramSnapshot } from './Checker'
import Compilation from './Compilation'

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
		isLegacy = no
		version = 1
		id = program.nextId++
		self.program = program
		fileName = util.t2iPath(path)
		program.files[fileName] = self
		program.files[tfileName] = self
		program.files.push(self)
		#completions = null
		#compilations = []
		#compilationMap = {}
		
	def lookupKey key
		console.log 'lookupKey',key
		if #completions and #completions.id == key
			return #completions

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

	def getSourceBody
		doc.getText!

	def getScriptSnapshot
		#snapshot ||= ts.ScriptSnapshot.fromString(getCompiledBody!)

	def dispose
		self

	def onDidChangeTextEditorSelection params
		return
		
	def didLoad
		log 'didLoad',fileName
		yes
		
	def didOpen
		yes
		
	def didChange
		yes
	
	def didSave
		yes
		

export class ImbaFile < File

	def constructor program\LanguageServer, path
		super
		isLegacy = fileName.indexOf('.imba1') > 0 or program.isLegacy

		if program && !program.rootFiles.includes(tfileName) and !isLegacy
			program.rootFiles.push(tfileName)

		logLevel = fileName.indexOf('Diagnostics') >= 0 ? 3 : 0
		diagnostics = new Diagnostics(self)
		#emptySnapshot = ts.ScriptSnapshot.fromString('export {};\n\n')
		#emptySnapshot.iversion = -1
		relName = util.normalizeImportPath(program.rootPath,fileName) + '.imba'

		emitted = {}
		times = {}
		_isTyping = no
		invalidate!
		self
	
	get shouldEmitDiagnostics
		fileName.indexOf('node_modules') == -1

	get doc
		$doc ||= FullTextDocument.create(uri,'imba',0,system.readFile(fileName))
	
	get idoc
		doc.tokens

	get isTyping
		_isTyping

	set isTyping value
		if _isTyping =? value
			yes

	def getScriptSnapshot
		let item = currentCompilation
		return item.js or #emptySnapshot
		
	def getCompiledBody
		getScriptSnapshot!.text
		# include potential diagnostics from imba compiler in last compilation
		# include ts diagnostics from last emitted compilation

	def didOpen doc
		$doc = doc
		if doc.tokens
			isLegacy = doc.tokens.isLegacy
		times.opened = Date.now!
		emitFile(true)
		log 'didOpen',uri,!!tls
		emitDiagnostics! if tls
		self

	def didChange doc, event = null
		$doc = doc
		version = doc.version
		cache.contexts = {}
		
		# diagnostics.sync!
		# sendDiagnostics!
		syncDiagnostics!
		times.edited = Date.now!
		console.log 'didChange',relName,"v{doc.version}"
		# this should definitely only send the diagnostics
		# that are currently part of the document?
		# should definitely not trigger an update
		

		if version > 1
			isTyping = yes
			$delay('emitFile',5000)
		else
			$delay('emitFile',10)
		# console.log 'didChange'
		# $clearSyntacticErrors! # only if our regions have changed?!?

	def didSave doc
		# savedContent = doc.getText!
		emitFile(true)
		# diagnostics.sync!
		times.saved = Date.now!
		isTyping = no
	
	def didLoad
		if times.opened
			syncDiagnostics!
		self

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
		
		let emit = scheduleCompilation!
		emit.compile!
		
		if emit.js
			# this may already be emitted bu the program?
			if emit.#emitted =? yes
				# shouldnt all files re-emit diagnostics?
				#checker = null
				log 'emit',relName
				# program.$delay('emitChanges',100)
				program.invalidate!
				$indexWorkspaceSymbols!
				$delay('emitDiagnostics',20)
		else
			$delay('emitDiagnostics',20)

		return self
		
	def trySyntacticDiagnostics
		
		if idoc.content.indexOf('\r') >= 0
			#crlfWarning ||= new FileDiagnostic(
				severity: 1,
				message: "Document contains CRLF (\\r\\n) line endings. Switch files.eol to LF(\\n)",
				range: idoc.rangeAt(0,0),
				data: {}
			)
			return [#crlfWarning]

		return []

	def trySemanticDiagnostics
		return [] unless tls
		let kind = DiagnosticKind.TypeScript | DiagnosticKind.Semantic
		# let entries = util.time(&,'diag') do tls.getSemanticDiagnostics(fileName)
		let entries = ils.getSemanticDiagnosticsForFile(self)
		devlog 'diagnostics',relName,entries
		# return entries
		let items = entries.map do Diagnostic.fromTypeScript(kind,$1,self)
		return items.filter do !!$1
		
	def getCompilerDiagnostics
		let last = lastCompilation
		last.diagnostics

	def getAllDiagnostics
		let items = []
		util.time(&,"calc diagnostics {relName}") do
			items.push(...trySyntacticDiagnostics!)
			items.push(...trySemanticDiagnostics!)
			items.push(...getCompilerDiagnostics!)
		return items
		
	def syncDiagnostics force = no
		sendDiagnostics!
	
	def updateDiagnostics
		let all = getAllDiagnostics!
		return #diagnostics = all
		
	def emitDiagnostics force = no
		updateDiagnostics!
		sendDiagnostics!
		return self
		
	def sendDiagnostics force = no
		return self unless #diagnostics
		
		let send = #diagnostics.filter(do !$1.hidden? )
		let payload = JSON.stringify(send)
		#sentDiagnostics = '' if force

		if #sentDiagnostics =? payload
			devlog 'send the diagnostics!!!',uri,payload
			# console.log 'sending diagnostics',relName
			ils.connection.sendDiagnostics(uri: uri, diagnostics: JSON.parse(payload))
		return self
		

	# how is this converting?
	def positionAt offset
		idoc.positionAt(offset)

	def offsetAt position
		return position if typeof position == 'number'
		idoc.offsetAt(position)

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
		
	def scheduleCompilation
		let item = #compilationMap[idoc.version] ||= new Compilation(self)
		#compilations.unshift(item) unless #compilations.indexOf(item) >= 0
		return item
		
	get currentCompilation
		let curr = #compilations.find(do $1.js)
		curr ||= scheduleCompilation!.compile!
		return curr
	
	get emittedCompilation
		#compilations.find(do $1.js)
		
	get lastCompilation
		#compilations.find(do $1.done)
		
	set compilation value
		yes
	
	get compilations
		#compilations

	def compile
		return self
		
	def $indexWorkspaceSymbols
		cache.symbols ||= util.fastExtractSymbols(doc.getText!,fileName)
		cache.workspaceSymbols ||= cache.symbols.map do(sym)
			sym.location = Location.create(uri,sym.span)
			sym.#file = self
			sym

		return self
	
	get workspaceSymbols
		$indexWorkspaceSymbols!
		return cache.workspaceSymbols

	def originalRangesFor jsloc
		locs.spans.filter do |pair|
			jsloc >= pair[0] and pair[1] >= jsloc
			
	def o2d o, fuzzy = yes
		currentCompilation.o2d(o,fuzzy)

	def originalRangeFor {start,length,end = null}
		if end == null
			end = start + length
			
		let snap = currentCompilation
		return snap.o2dRange(start,end)


		let starts = []
		let ends = []
		let hit = null

		for span in locs.spans
			if start == span[0]
				starts.push(span)
			if end == span[1]
				ends.push(span)

			if start == span[0] and end == span[1]
				break hit = span
		
		if !hit and starts.length and ends.length
			hit = [0,0,starts[0][2],ends[0][3]]

		if hit
			return idoc.rangeAt(hit[2],hit[3])
		return null

	# need a better converter
	def originalLocFor jsloc
		return emittedCompilation..o2d(jsloc)

	def generatedRangesFor loc
		return [] unless locs and locs.spans

		locs.spans.filter do(pair)
			loc >= pair[2] and pair[3] >= loc

	def generatedLocFor loc
		return emittedCompilation.d2o(loc)
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

	def getDefinitionAtPosition pos
		return if isLegacy
		let offset = offsetAt(pos)

		let snap = currentCompilation
		let oloc = snap.d2o(offset)
		let ctx = idoc.getContextAtOffset(offset)
		
		log 'getDefinitionAtPosition',offset,oloc

		let info = tls.getDefinitionAndBoundSpan(fileName,oloc) or {definitions:[]}
		
		return unless info.textSpan
		
		let sourceSpan = snap.o2d(info.textSpan)
		let sourceText = sourceSpan.getText(idoc.content)
		# console.log 'sourceSpan',sourceSpan
		log 'definitions',info.definitions,sourceSpan,sourceText
		# let sourceSpan = originalRangeFor(info.textSpan)
		# let sourceText = doc.getText!.slice(sourceSpan.start,sourceSpan.end)
		let isLink = sourceText and sourceText.indexOf('-') >= 0

		devlog 'get definition',uri,pos,offset,oloc,info,sourceSpan,sourceText,isLink
		let defs = for item in info.definitions
			let ifile = ils.files[item.fileName]

			if item.kind == 'module' or item.kind == 'script'
				let textSpan = {start: {line:0,character:0},end: {line:0,character:0}}
				let uri = util.pathToUri(item.fileName)
				# console.log 'LocationLink',uri,textSpan,sourceSpan
				continue LocationLink.create(uri,textSpan,textSpan,sourceSpan)
				
			elif ifile
				# console.log 'get definition',item.fileName,item.textSpan
				let textSpan = ifile.originalRangeFor(item.textSpan)
				let span = try
					item.contextSpan ? ifile.originalRangeFor(item.contextSpan) : textSpan
				span ||= textSpan


				if item.containerName == 'globalThis' and item.name.indexOf('$$TAG$$') >= 0
					span = {
						start: {line: textSpan.start.line, character: 0}
						end: {line: textSpan.start.line + 1, character: 0}
					}
				
				# log 'definition',item,textSpan,span,item.kind
				if item.kind == 'module'
					textSpan = {start: {line:0,character:0},end: {line:0,character:0}}
					console.log 'LocationLink',ifile.uri,textSpan,sourceSpan
					continue LocationLink.create(ifile.uri,textSpan,textSpan,sourceSpan)
					# Location.create(ifile.uri,)
				elif isLink
					LocationLink.create(ifile.uri,textSpan,span,sourceSpan)
				else
					Location.create(ifile.uri,textSpan)

			elif item.name == '__new' and info.definitions.length > 1
				continue
			else
				let span = util.textSpanToRange(item.contextSpan or item.textSpan,item.fileName,tls)
				if isLink
					LocationLink.create(util.pathToUri(item.fileName),span,span,sourceSpan)
				else
					Location.create(util.pathToUri(item.fileName),span)
		return defs

	def getDefinitionAtOffset offset
		getDefinitionAtPosition(positionAt(offset))
	
	def getAdjustmentEdits pos, amount = 1
		let loc =  offsetAt(pos)
		let edit = idoc.adjustmentAtOffset(loc,amount)
		return edit

	def getReferencesAtOffset offset
		log 'getReferencesAtOffset',offset
		# get the token information
		let ctx = idoc.getContextAtOffset(offset)
		
		let tok = ctx.token
		
		# if tok.match('entity.name.component')
		#	console.log 'get references for tag!!',tok.value
			
		
		let tloc = generatedLocFor(offset)
		log 'references',uri,offset,tloc

		let refs = tls.getReferencesAtPosition(fileName,tloc)
		
		for ref in refs
			let ifile\ImbaFile = ils.files[ref.fileName]
			let range = ifile..o2d(ref.textSpan)
			continue unless range
			Location.create(ifile.uri,range)
		
	def getQuickInfoAtPosition pos
		return if isLegacy
		
		let dloc = offsetAt(pos)
		let snap = currentCompilation
		let ctx = idoc.getContextAtOffset(dloc)

		# see if we should move one step ahead
		if ctx.after.token == '' and !ctx.before.character.match(/\w/)
			if ctx.after.character.match(/[\w\$\@\#\-]/)
				ctx = idoc.getContextAtOffset(dloc + 1)

		let grp = ctx.group
		let tok = ctx.token or {match: (do no)}
		
		if tok.match('white')
			return
			
		if tok.match('keyword')
			# look for exact match for the 
			
			return

		if ctx.token and !ctx.token.value
			log 'token without value',ctx.token

		let range = idoc.getTokenRange(ctx.token)
		let g = {}
		
		# more like completions?
		let checker = self.checker

		# console.log 'the context we got here',ctx.mode,range
		try
			let info = null
			let symbol = null
			if grp.match('path')
				console.log 'matching path!',grp.value
			

			if tok.match("tag.flag")
				info = "```imba\n<el class='... {tok.value} ...'>\n```"

			if tok.match("tag.id")
				info = "```imba\n<el id='{tok.value.slice(1)}'>\n```"
				
			if tok.match("tag.name")
				console.log 'matched tag name'
				symbol = checker.getTagSymbol(tok.value)
				# info = "```imba\n<el id='{tok.value.slice(1)}'>\n```"

			if tok.match("style.property.modifier") or tok.match("style.selector.modifier")
				let [m,pre,post] = tok.value.match(/^(@|\.+)([\w\-\d]*)$/)
				devlog 'matching!!',m,pre,post

				if pre == '@' or pre == ''
					symbol = getSymbolAtPath("global.imba.stylemodifiers.{post}")
				elif pre == '.'
					info = "Style only applies when element has '{post}' class"
				elif pre == '..'
					info = "Style only applies when a parent of element has has '{post}' class"
			
			g.listener = grp.closest('listener')
			g.el = grp.closest('tag')
			let csspropkey = g.csspropkey = grp.closest('stylepropkey')
			let cssprop = g.cssprop = grp.closest('styleprop')

			if csspropkey and !symbol and !info
				devlog 'csspropkey info!!',ctx,csspropkey.modifier,csspropkey.propertyName
				info = ils.entities.getCSSInfo(ctx)

			if tok.match('style.value')
				info = ils.entities.getCSSValueInfo(tok.value,cssprop.propertyName,ctx)

			if tok.match('tag.event.name')
				let name = tok.value.replace('@','')
				# devlog 'tagevent name',name,grp,g.el.name,g.listener.name
				# let path = "global.imba.types.events.{name}|__unknown"
				symbol = checker.sym("ImbaEvents.{name}")
				# let info = ils.entities.getTagEventInfo(g.listener.name,g.el.name)
				# devlog info
				# return {range: range, contents: info.description} if info

			if tok.match('tag.event-modifier')
				let name = tok.value.replace('.','')
				# let path = "global.imba.types.events.{g.listener.name}|__unknown.MODIFIERS.{name}"
				symbol = checker.sym("ImbaEvents.{name}.MODIFIERS.{name}")

			if !info and symbol
				let display = checker.getSymbolInfo(symbol)
				
				if display
					let out = {
						range: range
						contents: [{
							value: util.displayPartsToString(display.displayParts)
							language: 'typescript'
						}]
					}

					if display.documentation
						out.contents.push(value: util.displayPartsToString(display.documentation), language: 'text')
					return out
				
				let details = symbol.getCompletionDetails()
				let md = util.detailsToMarkdown(details)
				info = {markdown: md}
			
			if typeof info == 'string'
				info = {markdown: info}

			if info and info.markdown
				return {range: range, contents: {kind: 'markdown', value: info.markdown}}

			# don't fall back to typescript if we're in style mode
			if (grp.closest('style') or grp.closest('rule')) && !grp.closest('styleinterpolation')
				return {}
		catch e
			devlog 'error in getQuickInfo',e
			# get quick info via typescript
		
		let oloc = snap.d2o(dloc)
		let tinfo = util.time(&,'quickinfo') do ils.tls.getQuickInfoAtPosition(fileName,oloc)
		devlog 'getQuickInfoAtPosition',dloc,oloc,tinfo
		
		if tinfo
			let out = {
				range: snap.o2d(tinfo.textSpan)
				contents: [{
					value: util.displayPartsToString(tinfo.displayParts)
					language: 'typescript'
				}]
			}

			if tinfo.documentation
				out.contents.push(value: util.displayPartsToString(tinfo.documentation), language: 'text')
			return out

		return null

	get checker
		#checker ||= new ProgramSnapshot(ils.getProgram!,self)

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

	def getSymbolAtPath path,resolveGlobal = yes
		devlog "get symbol {path}"
		let {file,checker,program} = getTypeContext!
		let type = null
		let target = null
		let parts = path.split('.')

		let getCompletionDetails = do
			ts.Completions.createCompletionDetailsForSymbol(this,checker,file,file)
		
		while let part = parts.shift!
			let alternatives = part.split('|')
			part = alternatives.shift!
			let sym = null
			if part.match(/^\<[\w\-]+\>$/)
				let name = part.slice(1,-1)
				let pascal = util.pascalCase(name)

				if name == pascal
					part = name
					parts.unshift('prototype')
					# sym = file.locals.get(name)
				else
					sym ||= getSymbolAtPath("global.imba.types.html.tags.{name}")
					sym ||= getSymbolAtPath("global.{name.replace(/\-/g,'_')}$$TAG$$.prototype")

			sym ||= target ? target.#type.getProperty(part) : file.locals.get(part)

			if !target and !sym and (part == 'global' or resolveGlobal)
				part = 'globalThis' if part == 'global'
				sym = checker.resolveName(part,undefined,ts.SymbolFlags.Value,false)


			if !sym and alternatives.length
				parts.unshift alternatives.join('|')
				continue

			return null unless sym

			let type = sym.#type = checker.getTypeOfSymbolAtLocation(sym,file)
			sym.#parent = target
			sym.getCompletionDetails = getCompletionDetails
			sym.#type.getCompletionDetails = getCompletionDetails.bind(sym)
			type.#path = path
			target = sym
		
		return target

	def getPropertiesAtPath path, ...filters
		let type = getTypeAtPath(path)
		return [] unless type

		let props = type.getApparentProperties!
		
		for filter in filters
			if filter isa Array
				props = props.filter do(item) filter.some do $1(item)
			elif filter isa Function
				props = props.filter(filter)
			elif filter isa RegExp
				props = props.filter do !$1.escapedName.match(filter)
		
		props.keys = {}

		for item in props
			if let name = item.escapedName
				try
					props.keys[name] = item
					item.#path = "{type.#path}.{name}"
				catch e
					devlog e,props.keys,props,name
		return props

	def getTypeAtPath path
		let sym = getSymbolAtPath(path)
		
		return sym and sym.#type

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

	def completions offset, options = {}
		let completions = new CompletionsContext(self,offset,options)
		return completions

	def getCompletionsAtOffset offset, options = {}
		unless emittedCompilation
			log 'got no working file'
			return []
			
		if #completions
			#completions.release!

		let completions = #completions = new CompletionsContext(self,offset,options)
		if $web$
			global.cl = completions
		
		completions.retain!
		let out = completions.serialize!
		return out

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
		# should only happen if this clearly happens much later than the last change
		if isTyping and (now - times.edited) > 3
			console.log 'flushing emitFile',now - times.edited
			isTyping = no
			setTimeout(&,1) do $flush('emitFile')
		return

export class Imba1File < ImbaFile

export class JSONFile < File

export class AssetFile < File

export class HTMLFile < AssetFile

export class ImageFile < AssetFile

export class SVGFile < AssetFile

	def getCompiledBody
		return 'export default /** @type {ImbaAsset} */({})'
		# super