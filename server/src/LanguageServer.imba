import {Component} from './Component'
import {snippets} from './snippets'
import {IConnection,InitializeParams,TextDocuments,Location,LocationLink,MarkedString,DocumentSymbol,InsertTextFormat} from 'vscode-languageserver'
import { TextDocument } from 'vscode-languageserver-textdocument'
import {CompletionItemKind,SymbolKind} from 'vscode-languageserver-types'
import {CompilerOptions,LanguageService} from 'typescript'

import {URI} from 'vscode-uri'

import {File} from './File'
import {Entities} from './Entities'
import * as util from './utils'

import {TAG_NAMES,TAG_TYPES} from './constants'

var path = require 'path'
var fs = require 'fs'
var ts = require 'typescript'
var glob = require 'glob'
var imbac = require 'imba/dist/compiler.js'
import htmlData from './html-data.json'

# var html-data = require './html-data.json'
var html-elements = {}

for item in htmlData.tags
	html-elements[item.name] = item

var tsServiceOptions\CompilerOptions = {
	allowJs: true
	checkJs: true
	noEmit: true
	skipLibCheck: true
	skipDefaultLibCheck: true
	allowUmdGlobalAccess: true
	allowNonTsExtensions: true
	allowUnreachableCode: true
	allowUnusedLabels: true
	noImplicitUseStrict: true
	noStrictGenericChecks: true
	allowSyntheticDefaultImports: true
	suppressExcessPropertyErrors: true
	traceResolution: true
	resolveJsonModule: true
	incremental: true
	target: ts.ScriptTarget.Latest
	lib: ['lib.es6.d.ts']
	moduleResolution: ts.ModuleResolutionKind.NodeJs
}

export class LanguageServer < Component

	prop allFiles\File[]
	prop rootFiles\string[]
	prop service\LanguageService

	def resolveConfigFile dir
		return null if !dir or (dir == path.dirname(dir))

		let src = path.resolve(dir,'imbaconfig.json')
		if fs.existsSync(src)
			return JSON.parse(fs.readFileSync(src,'utf8'))
		return self.resolveConfigFile(path.dirname(dir))

	def constructor(connection\IConnection, documents\TextDocuments, params\InitializeParams, o = {})
		super

		self.files = []
		self.documents = documents
		self.connection = connection
		self.entities = Entities.new(self)
		self.rootPath = self.rootUri = util.uriToPath(params.rootUri)
		self.imbaConfig = self.resolveConfigFile(self.rootPath) or {}
		self.rootFiles = o.rootFiles || []
		self.snapshots = {}
		self.version = 0
		self.debug = !!o.debug
		self.cache = {}

		createTypeScriptService!
		self
		
	def createTypeScriptService
		return if imbaConfig.legacy
		
		# @type {ts.LanguageServiceHost}
		var servicesHost = {
			getScriptFileNames:  do self.rootFiles
			getProjectVersion:   do '' + self.version
			getTypeRootsVersion: do 1

			getScriptVersion: do |fileName|
				let version = self.files[fileName] ? String(self.files[fileName].version.toString()) : "1"
				return version

			# @param {string} fileName
			getScriptSnapshot: do |fileName|
				if !self.fileExists(fileName)
					return undefined

				if let file = self.files[fileName]
					# console.log 'get script snapshot',fileName
					file.compile()
					return file.jsSnapshot

				let snapshot = self.snapshots[fileName] ||= ts.ScriptSnapshot.fromString(self.readFile(fileName).toString())
				return snapshot
			
			getCurrentDirectory: do self.rootPath
			getCompilationSettings: do tsServiceOptions
			getDefaultLibFileName: do |options| ts.getDefaultLibFilePath(options)
			fileExists: self.fileExists.bind(self)
			readFile: self.readFile.bind(self)
			writeFile: self.writeFile.bind(self)
			readDirectory: ts.sys.readDirectory
		}
		self.service = ts.createLanguageService(servicesHost,ts.createDocumentRegistry!)
		
		
	def invalidate
		version++
		cache = {}

	def emitRootFiles
		for file in self.rootFiles
			self.service.getEmitOutput(file)

	def addFile fileName
		fileName = path.resolve(self.rootPath,fileName)
		if self.sourceFileExists(fileName)
			self.files[fileName].emitFile()
			# @service.getEmitOutput(@files[fileName].jsPath)
			
	def indexFiles
		# let t = Date.now!
		allFiles ||= glob.sync(path.resolve(self.rootPath,'**','*.imba'),ignore: 'node_modules').map do getImbaFile($1)
		self

	def getProgram
		self.service.getProgram()

	def log ...params
		console.log(...params)

	# comment about the source file?
	def sourceFileExists fileName\string
		if let file = self.files[fileName]
			# What if it has been deleted?
			return file.removed ? false : true

		var alt = fileName.replace(/\.js$/, '.imba')

		if ((alt != fileName) or fileName.match(/\.imba$/)) && ts.sys.fileExists(alt)
			File.new(self,alt,self.service)
			return true
		return false

	def fileExists fileName 
		let res = self.sourceFileExists(fileName) || ts.sys.fileExists(fileName)
		return res

	def readFile fileName
		var source = self.files[fileName]

		if source
			self.log("compile file {source.imbaPath}")
			source.compile()
			return String(source.js)

		return ts.sys.readFile(fileName)

	def writeFile fileName, contents
		self.log "writeFile",fileName
		return

	// Used for testing mainly
	def $updateFile fileName, append
		fileName = path.resolve(self.rootPath,fileName)

		if let file = self.files[fileName]
			let t = Date.now()
			self.log 'found file!',fileName,file.version
			file.getSourceContent()
			if append isa Function
				file.content = append(file.content)
			elif typeof append == 'string'
				file.content += append

			file.version++
			file.invalidate()
			self.version++
			file.emitFile()
			self.log 'updatedFile',fileName,Date.now() - t
		return

	def removeFile fileName
		fileName = path.resolve(self.rootPath,fileName)
		if let file = self.files[fileName]
			file.removed = true
			self.version++

	def scheduleEmitDiagnostics
		emitDiagnostics!

	def emitDiagnostics
		let entries = service.getProgram!.getSemanticDiagnostics!
		let map = {}

		for entry in entries
			if let file = files[entry.file.fileName]
				let items = map[file.jsPath] ||= []
				items.push(entry)

		for file in files
			file.updateDiagnostics(map[file.jsPath])

		self

	def getSemanticDiagnostics
		let t = Date.now()
		let entries = self.service.getProgram().getSemanticDiagnostics()

		let info = entries.map do
			[$1.file.fileName,$1.messageText,$1.start,$1.length,$1.relatedInformation,$1]
		# let decl = @service.getProgram().getDeclarationDiagnostics()
		console.log 'got diagnostics',Date.now() - t,info
		return

	def inspectProgram
		let program = self.service.getProgram()
		let files = program.getSourceFiles().map do
			$1.fileName
		let file 
		console.log files

	def inspectFile fileName
		fileName = path.resolve(self.rootPath,fileName)
		let program = self.service.getProgram()
		let sourceFile = program.getSourceFile(fileName)
		# let deps = program.getAllDependencies(sourceFile)
		console.log sourceFile,sourceFile.referencedFiles

	# methods for vscode
	def onDidOpen event
		let doc = event.document
		let src = util.uriToPath(event.document.uri)
		self.log('onDidOpen',src)
		let existing = self.files[src]
		let file = self.getImbaFile(src)

		file.didOpen(doc)
		if !existing and file
			file.emitFile()
		self

	def onDidSave event
		let doc = event.document
		let src = util.uriToPath(doc.uri)

		let file = self.getImbaFile(src)
		if file
			file.didSave(doc)
			self.emitDiagnostics()
		else
			self.version++
		self

	def onDidRenameFiles event
		let version = self.version
		
		for entry in event.files
			console.log 'renamed file?',entry.oldUri.path
			if let file = self.files[entry.oldUri.path]
				console.log 'found renamed file!',file.imbaPath
				file.dispose()

		if self.version != version
			self.scheduleEmitDiagnostics()
		self

	def onDidCreateFiles event
		self

	def onDidDeleteFiles event
		self

	def onDidChangeContent event
		# @log "server.onDidChangeContent"
		let doc = event.document
		if let file = self.getImbaFile(doc.uri)
			file.didChange(doc,event)

	def getImbaFile src
		# let doc = @documents && @documents.get(file.uri or file)
		src = util.uriToPath(src)
		src = path.resolve(self.rootPath,src).replace(/\.(imba|js|ts)$/,'.imba')
		# what if it is a local file?
		let file\File = self.files[src] ||= File.new(self,src,self.service)

		return file

	def getDefinitionAtPosition uri, pos
		let file = self.getImbaFile(uri)
		let loc = self.documents.get(uri).offsetAt(pos)
		
		unless service
			return []

		let jsloc = file.generatedLocFor(loc)
		let info = self.service.getDefinitionAndBoundSpan(file.lsPath,jsloc)

		if info and info.definitions

			let sourceSpan = file.textSpanToRange(info.textSpan)
			let sourceText = file.textSpanToText(info.textSpan)
			let isLink = sourceText and sourceText.indexOf('-') >= 0
			# console.log 'definitions!',sourceSpan,sourceText,isLink

			var defs = for item of info.definitions
				console.log 'get definition',item
				let ifile = self.files[item.fileName]
				if ifile
					# console.log 'definition',item
					let textSpan = ifile.textSpanToRange(item.textSpan)
					let span = item.contextSpan ? ifile.textSpanToRange(item.contextSpan) : textSpan

					if item.containerName == 'globalThis' and item.name.indexOf('Component') >= 0
						span = {
							start: {line: textSpan.start.line, character: 0}
							end: {line: textSpan.start.line + 1, character: 0}
						}
					if isLink
						LocationLink.create(ifile.uri,textSpan,span,sourceSpan)
					else
						Location.create(ifile.uri,textSpan)
	
				elif item.name == '__new' and info.definitions.length > 1
					continue
				else
					let span = util.textSpanToRange(item.contextSpan or item.textSpan,item.fileName,self.service)
					if isLink
						LocationLink.create(
							util.pathToUri(item.fileName),
							span,
							span,
							sourceSpan
						)
					else
						Location.create(util.pathToUri(item.fileName),span)
			return defs
		# if let info = file.getDefinitionAtPosition(loc)
		#	return info
	
	# should delegate this through to the file itself
	def getCompletionsAtPosition uri, pos, context = {}
		let file = self.getImbaFile(uri)

		let loc = typeof pos == 'number' ? pos : self.documents.get(uri).offsetAt(pos)
		let types = {}
		let ctx = file.getContextAtLoc(loc)
		let items = []
		let trigger = context.triggerCharacter
		let TAG_START = /(\> |^\s*|[\[\(])\<$/
		# console.log 'completions at line',ctx
		self.log('completions context',ctx,loc)

		let options = {
			triggerCharacter: context.triggerCharacter
			includeCompletionsForModuleExports: true,
			includeCompletionsWithInsertText: true
		}

		if ctx.textBefore.match(TAG_START)
			
			if trigger == '<'
				options.autoclose = yes
				self.connection.sendNotification('closeAngleBracket',{location: loc,position: pos, uri: uri})

			let items = self.entities.getTagNameCompletions(options)
			return {isIncomplete: false, items: items}

		elif trigger == '<'
			return
			
		if trigger == '.' or ctx.textBefore.match(/\.[\w\$\-]*$/)
			console.log 'get completions directly',loc,options
			let tspitems = file.tspGetCompletionsAtPosition(loc,ctx,options)
			console.log('tspitems',tspitems.length)
			items.push(...tspitems)

		else
			# if the completion is part of an access - we want to
			# redirect directly to typescript?
			let snippets = self.entities.getSnippetsForContext(ctx)
			items.push(...snippets)

			let find = ctx.path.replace(/[\w\-]+$/,'')
			let members = file.getMemberCompletionsForPath(find,ctx)
			items.push(...members)

			# add tag completions as well?

		items = self.entities.normalizeCompletions(items,ctx)
		console.log 'return items',items

		return {isIncomplete: false, items: items}
		
		let jsLoc = context.jsLoc or file.generatedLocFor(loc)
	
		# return custom completions not based on typescript
		if ctx.context == 'tag'
			items = self.entities.getCompletionsForContext(uri,pos,ctx)
			if trigger == '<'
				items.unshift(
					label: 'none'
					insertText: '  '
					commitCharacters: [' ']
					sortText: '00'
					kind: CompletionItemKind.Field
					preselect: yes
					data: { resolved: true }
				)
				console.log 'added item?',items[0]
			return {isIncomplete: false, items: items}

		if types.tagName
			# console.log 'completion here!'
			let items = for own name,ctor of TAG_NAMES
				{
					uri: uri,
					position: pos,
					label: name.replace('_',':'),
					kind: CompletionItemKind.Field,
					sortText: name
					data: { resolved: true }
				}
			return {isIncomplete: false, items: items}

		let res = self.service.getCompletionsAtPosition(file.lsPath,jsLoc,options)
		
		if res
			if self.debug
				console.log 'complete',uri,loc,jsLoc,res.isNewIdentifierLocation,res.isGlobalCompletion
				console.log 'completions!!',res.entries && res.entries.filter(do $1.kindModifiers).map(do [$1.name,$1.kindModifiers,$1.insertText])

			let entryFor = do |entry|
				let name = entry.name
				let m
				
				if name.match(/^is([A-Z])/)
					name = name[2].toLowerCase() + name.slice(3) + '?'
				elif name.match(/^do([A-Z])/)
					name = name[2].toLowerCase() + name.slice(3) + '!'
		
				let completion = {
					label: name,
					kind: util.convertCompletionKind(entry.kind,entry),
					sortText: entry.sortText
					data: {
						loc: jsLoc
						path: file.lsPath
						origKind: entry.kind
					}
				}
				
				if entry.kind == 'method' and !name.match(/[\!\/?]$/)
					completion.insertText = name.replace(/\$/g,'\\$') + '($1)$0'
					completion.insertTextFormat = InsertTextFormat.Snippet
				elif entry.insertText
					yes
						
				if entry.source
					completion.sortText = '\uffff' + entry.sortText
					
				if entry.isRecommended
					completion.preselect = true

				return completion

			let items = res.entries.map(entryFor).filter(do $1)
			

			if res.isMemberCompletion
				items = items.filter do $1.kind != CompletionItemKind.Text

			let out = {
				isIncomplete: false,
				items: items
			}

			return out

		return {
			isIncomplete: false,
			items: []
		}

	def doResolve item
		console.log 'resolving',item
		if item and item.data.resolved
			return item
		let source = undefined
		let prefs = {
			includeCompletionsWithInsertText: true
		}
		let details = self.service.getCompletionEntryDetails(item.data.path,item.data.loc,item.label,undefined,source,prefs)
		if details
			console.log details
			item.detail = ts.displayPartsToString(details.displayParts)
			item.documentation = ts.displayPartsToString(details.documentation)
			delete item.data
		return item

	def getQuickInfoAtPosition uri, pos
		# force the js imba file for conversion\
		# let path = util.uriToPath(file.url or file).replace('.imba','.js')
		# console.log "get quick info at pos {path}"

		let file = getImbaFile(uri)
		let loc = documents.get(uri).offsetAt(pos)
		# @type {number}
		let loc2 = file.generatedLocFor(loc)
		let info = loc2 and service.getQuickInfoAtPosition(String(file.lsPath), loc2)

		# console.log pos2
		if info
			let contents = [{
				value: ts.displayPartsToString(info.displayParts)
				language: 'typescript'
			}]

			if info.documentation
				contents.push(value: ts.displayPartsToString(info.documentation), language: 'text')
			return {
				range: file.textSpanToRange(info.textSpan)
				contents: contents
			}
			
	def getWorkspaceSymbols {query,type} = {}
		indexFiles! # not after simple changes
		let symbols = cache.symbols ||= files.reduce(&,[]) do $1.concat($2.workspaceSymbols)
		
		if query
			symbols = symbols.filter do util.matchFuzzyString(query,$1.name)

		if (type instanceof Array)
			symbols = symbols.filter do type.indexOf($1.type) >= 0
		elif type
			symbols = symbols.filter do $1.type == type
		
		return symbols

		return self.entities.getWorkspaceSymbols(query)

	def getSymbols uri
		let file = self.getImbaFile(uri)
		return unless file

		unless service
			file.$indexWorkspaceSymbols!
			let conv = do |sym|
				{
					kind: sym.kind
					name: sym.ownName
					range: sym.span
					selectionRange: sym.span	
					children: sym.children.map(conv)
				}

			let results = file.cache.symbols.filter(do !$1.parent).map(conv)
			return results

		return file.getSymbols()