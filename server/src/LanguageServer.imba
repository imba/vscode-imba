

import {snippets} from './snippets'
import {IConnection,InitializeParams,TextDocuments,Location,LocationLink,MarkedString,DocumentSymbol,InsertTextFormat} from 'vscode-languageserver'
import { TextDocument } from 'vscode-languageserver-textdocument'
import {CompletionItemKind,SymbolKind} from 'vscode-languageserver-types'
import {CompilerOptions} from 'typescript'

import {URI} from 'vscode-uri'

import {File} from './File'
import {Entities} from './Entities'
import * as util from './utils'

import {TAG_NAMES,TAG_TYPES} from './constants'

var path = require 'path'
var fs = require 'fs'
var ts = require 'typescript'
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

export class LanguageServer

	def resolveConfigFile dir
		return null if !dir or (dir == path.dirname(dir))

		let src = path.resolve(dir,'imbaconfig.json')
		if fs.existsSync(src)
			return JSON.parse(fs.readFileSync(src,'utf8'))
		return @resolveConfigFile(path.dirname(dir))

	def constructor connection\IConnection, documents\TextDocuments, params\InitializeParams, o = {}
		# {rootUri,rootFiles,debug}
		@files = []
		@documents = documents

		@connection = connection
		@entities = Entities.new(self)
		@rootPath = @rootUri = util.uriToPath(params.rootUri)
		@imbaConfig = @resolveConfigFile(@rootPath)
		
		console.log 'found imba config?!',@imbaConfig
		# find config file
		# @type {string[]}
		@rootFiles = o.rootFiles || []
		@snapshots = {}
		@version = 0
		@debug = !!o.debug
				
		# @type {ts.LanguageServiceHost}
		var servicesHost = {
			getScriptFileNames: do
				@log('getScriptFileNames')
				@rootFiles
			getProjectVersion: do '' + @version
			getTypeRootsVersion: do 1

			getScriptVersion: do |fileName|
				let version = @files[fileName] ? String(@files[fileName].version.toString()) : "1"
				# console.log 'get script version',fileName,version,@version
				return version
			# @param {string} fileName
			getScriptSnapshot: do |fileName|
				return undefined if !@fileExists(fileName)
				if let file = @files[fileName]
					# console.log 'get script snapshot',fileName
					file.compile()
					return file.jsSnapshot

				let snapshot = @snapshots[fileName] ||= ts.ScriptSnapshot.fromString(@readFile(fileName).toString())
				return snapshot
			
			getCurrentDirectory: do @rootPath
			getCompilationSettings: do tsServiceOptions
			getDefaultLibFileName: do |options| ts.getDefaultLibFilePath(options)
			fileExists: @fileExists.bind(self)
			readFile: @readFile.bind(self)
			writeFile: @writeFile.bind(self)
			readDirectory: ts.sys.readDirectory
		}
		console.log 'creating registry'
		@registry = ts.createDocumentRegistry()
		console.log 'creating service'
		@service = ts.createLanguageService(servicesHost,@registry)

		self

	def emitRootFiles
		for file in @rootFiles
			@service.getEmitOutput(file)

	def addFile fileName
		fileName = path.resolve(@rootPath,fileName)
		if @sourceFileExists(fileName)
			@files[fileName].emitFile()
			# @service.getEmitOutput(@files[fileName].jsPath)

	def getProgram
		@service.getProgram()

	def log ...params
		console.log(...params)

	# comment about the source file?
	def sourceFileExists fileName\string
		if let file = @files[fileName]
			# What if it has been deleted?
			return file.removed ? false : true

		var alt = fileName.replace(/\.js$/, '.imba')

		if ((alt != fileName) or fileName.match(/\.imba$/)) && ts.sys.fileExists(alt)
			@log "created {fileName} / {alt}"
			File.new(self,alt,@service)
			return true
		return false

	def fileExists fileName 
		let res = @sourceFileExists(fileName) || ts.sys.fileExists(fileName)
		return res

	def readFile fileName
		var source = @files[fileName]

		if source
			@log("compile file {source.imbaPath}")
			source.compile()
			return String(source.js)

		return ts.sys.readFile(fileName)

	def writeFile fileName, contents
		@log "writeFile",fileName
		return

	def updateFile fileName, append
		fileName = path.resolve(@rootPath,fileName)
		if let file = @files[fileName]
			let t = Date.now()
			@log 'found file!',fileName,file.version
			file.getSourceContent()
			if append isa Function
				file.content = append(file.content)
			elif typeof append == 'string'
				file.content += append

			file.version++
			file.invalidate()
			@version++
			file.emitFile()
			@log 'updatedFile',fileName,Date.now() - t
		return

	def removeFile fileName
		fileName = path.resolve(@rootPath,fileName)
		if let file = @files[fileName]
			file.removed = true
			@version++

	def scheduleEmitDiagnostics
		@emitDiagnostics()

	def emitDiagnostics
		let entries = @service.getProgram().getSemanticDiagnostics()
		let map = {}

		for entry in entries
			if let file = @files[entry.file.fileName]
				let items = map[file.jsPath] ||= []
				items.push(entry)

		for file in @files
			file.updateDiagnostics(map[file.jsPath])

		self

	def getSemanticDiagnostics
		let t = Date.now()
		let entries = @service.getProgram().getSemanticDiagnostics()

		let info = entries.map do
			[$1.file.fileName,$1.messageText,$1.start,$1.length,$1.relatedInformation,$1]
		# let decl = @service.getProgram().getDeclarationDiagnostics()
		console.log 'got diagnostics',Date.now() - t,info

		return
		# fileName = path.resolve(@rootPath,fileName)
		# if let file = @files[fileName]
		#	file.emitDiagnostics()
		#	# @service.getSemanticDiagnostics(file.lsPath)

	def inspectProgram
		let program = @service.getProgram()
		let files = program.getSourceFiles().map do
			$1.fileName
		let file 
		console.log files

	def inspectFile fileName
		fileName = path.resolve(@rootPath,fileName)
		let program = @service.getProgram()
		let sourceFile = program.getSourceFile(fileName)
		# let deps = program.getAllDependencies(sourceFile)
		console.log sourceFile,sourceFile.referencedFiles

	# methods for vscode
	def onDidOpen event
		# emit this file only if it has not yet been requested
		# by anyone

		let doc = event.document
		let src = util.uriToPath(event.document.uri)
		@log('onDidOpen',src)
		let existing = @files[src]
		let file = @getImbaFile(src)

		file.didOpen(doc)
		if !existing and file
			file.emitFile()
		self

	def onDidSave event
		let doc = event.document
		let src = util.uriToPath(doc.uri)

		let file = @getImbaFile(src)
		if file
			file.didSave(doc)
			@emitDiagnostics()
		else
			@version++
		self

	def onDidRenameFiles event
		let version = @version
		
		for entry in event.files
			console.log 'renamed file?',entry.oldUri.path
			if let file = @files[entry.oldUri.path]
				console.log 'found renamed file!',file.imbaPath
				file.dispose()

		if @version != version
			@scheduleEmitDiagnostics()
		self

	def onDidCreateFiles event
		self

	def onDidDeleteFiles event
		self

	def onDidChangeContent event
		# @log "server.onDidChangeContent"
		let doc = event.document
		if let file = @getImbaFile(doc.uri)
			file.didChange(doc)


	def getImbaFile src
		# let doc = @documents && @documents.get(file.uri or file)
		src = util.uriToPath(src)
		src = path.resolve(@rootPath,src).replace(/\.(imba|js|ts)$/,'.imba')
		# what if it is a local file?

		return @files[src] ||= File.new(self,src,@service)

	def getDefinitionAtPosition uri, pos
		let file = @getImbaFile(uri)
		let loc = @documents.get(uri).offsetAt(pos)

		
		let jsloc = file.generatedLocFor(loc)
		let info = @service.getDefinitionAndBoundSpan(file.lsPath,jsloc)

		if info and info.definitions

			let sourceSpan = file.textSpanToRange(info.textSpan)
			let sourceText = file.textSpanToText(info.textSpan)
			let isLink = sourceText and sourceText.indexOf('-') >= 0
			# console.log 'definitions!',sourceSpan,sourceText,isLink

			var defs = for item of info.definitions

				let ifile = @files[item.fileName]
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
					let span = util.textSpanToRange(item.contextSpan or item.textSpan,item.fileName,@service)
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
		let file = @getImbaFile(uri)

		let loc = typeof pos == 'number' ? pos : @documents.get(uri).offsetAt(pos)
		let types = {}
		let ctx = file.getContextAtLoc(loc)
		let items = []
		let trigger = context.triggerCharacter
		let TAG_START = /(\> |^\s*|[\[\(])\<$/
		# console.log 'completions at line',ctx
		@log('completions context',ctx,loc)

		let options = {
			triggerCharacter: context.triggerCharacter
			includeCompletionsForModuleExports: true,
			includeCompletionsWithInsertText: true
		}


		if ctx.textBefore.match(TAG_START)
			console.log 'matching tags!!'
			
			if trigger == '<'
				options.autoclose = yes
				@connection.sendNotification('closeAngleBracket',{location: loc,position: pos, uri: uri})

			let items = @entities.getTagNameCompletions(options)
			return {isIncomplete: false, items: items}

		elif trigger == '<'
			return
			
		if trigger == '.' or ctx.textBefore.match(/\.[\w\$\-]*$/)
			let tspitems = file.tspGetCompletionsAtPosition(loc,ctx,options)
			items.push(*tspitems)
		
		else
			# if the completion is part of an access - we want to
			# redirect directly to typescript?
			let snippets = @entities.getSnippetsForContext(ctx)
			items.push(*snippets)
			
			let find = ctx.path.replace(/[\w\-]+$/,'')
			let members = file.getMemberCompletionsForPath(find,ctx)
			items.push(*members)

		items = @entities.normalizeCompletions(items,ctx)
		console.log 'return items',items

		return {isIncomplete: false, items: items}
		
		let jsLoc = context.jsLoc or file.generatedLocFor(loc)
	
		# return custom completions not based on typescript
		if ctx.context == 'tag'
			items = @entities.getCompletionsForContext(uri,pos,ctx)
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

		let res = @service.getCompletionsAtPosition(file.lsPath,jsLoc,options)
		
		if res
			if @debug
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
		let details = @service.getCompletionEntryDetails(item.data.path,item.data.loc,item.label,undefined,source,prefs)
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

		let file = @getImbaFile(uri)
		let loc = @documents.get(uri).offsetAt(pos)
		# @type {number}
		let loc2 = file.generatedLocFor(loc)
		let info = @service.getQuickInfoAtPosition(String(file.lsPath), loc2)
		# console.log pos2
		if info
			let contents = [{
				value: ts.displayPartsToString(info.displayParts)
				language: 'typescript'
			}]

			if info.documentation
				# contents.push({type: 'text', value: })
				contents.push(value: ts.displayPartsToString(info.documentation), language: 'text')
			return {
				range: file.textSpanToRange(info.textSpan)
				contents: contents
			}

	def getSymbols uri
		let file = @getImbaFile(uri)
		# console.log 'found file?',file.jsPath
		let tree = @service.getNavigationTree(file.lsPath)
		
		if file.lsPath.indexOf('LongPromise') >= 0
			console.log 'found results?',tree

		let conv = do |item|
			return unless item.nameSpan
			return if item.kind == 'alias'
			# console.log "symbol",item.kind,item.text,item.nameSpan
			let range = file.textSpanToRange(item.nameSpan)
			let kind = util.convertSymbolKind(item.kind)
			unless range and range.start and range.start.line
				return

			let children = item.childItems or []

			if item.kind == 'method' or item.kind == 'function'
				children = []

			return {
				kind: kind
				name: item.text
				range: range
				selectionRange: range
				children: children.map(conv).filter(do !!$1)
			}
		let res = tree.childItems.map(conv).filter(do !!$1)
		# console.log 'found results',res
		return res