import {Component} from './Component'
import {snippets} from './snippets'
import {IConnection,InitializeParams,TextDocuments,Location,LocationLink,MarkedString,DocumentSymbol,InsertTextFormat,ReferenceParams,CompletionItem} from 'vscode-languageserver'
import { TextDocument } from 'vscode-languageserver-textdocument'
import {CompletionItemKind,SymbolKind} from 'vscode-languageserver-types'
import {CompilerOptions,LanguageService,LanguageServiceHost,UserPreferences} from 'typescript'

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
	forceConsistentCasingInFileNames: true
	
	moduleResolution: ts.ModuleResolutionKind.NodeJs
}

export class LanguageServer < Component

	prop allFiles\File[]
	prop rootFiles\string[]
	prop tls\LanguageService

	def resolveConfigFile dir
		return null if !dir or (dir == path.dirname(dir))
		
		let src = path.resolve(dir,'imbaconfig.json')
		if fs.existsSync(src)
			let resolver = do |key,value|
				if typeof value == 'string' and value.match(/^\.\//)
					return path.resolve(dir,value)
				return value

			let config = JSON.parse(fs.readFileSync(src,'utf8'),resolver)
			return config

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
		log('imba config',imbaConfig)

		for item in imbaConfig.entries
			self.rootFiles.push(item.input)

		createTypeScriptService!
		setTimeout(&,0) do indexFiles!
		self
		
	def createTypeScriptService
		return if imbaConfig.legacy
	
		var options\CompilerOptions = Object.assign({},tsServiceOptions)
		options.baseUrl =  self.rootPath

		if imbaConfig.alias
			let paths = options.paths = {}
			for own key, value of imbaConfig.alias
				paths[key] = [value]
				paths[key + '/*'] = [value + '/*']

		log 'starting with options',options

		var servicesHost\LanguageServiceHost = {
			getScriptFileNames:  do self.rootFiles
			getProjectVersion:   do '' + self.version
			getTypeRootsVersion: do 1
			useCaseSensitiveFileNames: do yes

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
			getCompilationSettings: do options
			getDefaultLibFileName: do |options| ts.getDefaultLibFilePath(options)
			fileExists: self.fileExists.bind(self)
			readFile: self.readFile.bind(self)
			writeFile: self.writeFile.bind(self)
			readDirectory: ts.sys.readDirectory
			getNewLine: do '\n'
		}

		var resolutionHost = {
			fileExists: self.fileExists.bind(self)
			readFile: self.readFile.bind(self)
		}

		// servicesHost.resolveModuleNames = do |moduleNames,containingFile,reusedNames,redirectedReference,options2|
		// 	# console.log 'resolve module names',containingFile,moduleNames
		// 	for name in moduleNames
		// 		let result = ts.resolveModuleName(name, containingFile, options,resolutionHost)
		// 		result.resolvedModule
		// 	# return []
		// 	# moduleNames: string[], containingFile: string, reusedNames: string[] | undefined, redirectedReference: ResolvedProjectReference | undefined, options: CompilerOptions
		
		self.tls = ts.createLanguageService(servicesHost,ts.createDocumentRegistry!)
		
	def invalidate
		version++
		cache = {}

	def emitRootFiles
		for file in self.rootFiles
			tls.getEmitOutput(file)

	def addFile fileName
		fileName = path.resolve(self.rootPath,fileName)
		if self.sourceFileExists(fileName)
			self.files[fileName].emitFile()
			# @service.getEmitOutput(@files[fileName].jsPath)
			
	def indexFiles
		let t = Date.now!
		let matches = glob.sync(path.resolve(self.rootPath,'**','*.imba'),ignore: 'node_modules')
		matches = matches.filter do |file| file.indexOf('node_modules') == -1
		allFiles ||= matches.map do |file|
			getImbaFile($1)
		# console.log "indexed files",Date.now! - t
		self

	def getProgram
		tls.getProgram()

	# comment about the source file?
	def sourceFileExists fileName\string
		if let file = self.files[fileName]
			# What if it has been deleted?
			return file.removed ? false : true

		var alt = fileName.replace(/\.js$/, '.imba')

		if ((alt != fileName) or fileName.match(/\.imba$/)) && ts.sys.fileExists(alt)
			File.new(self,alt)
			return true
		return false

	def fileExists fileName 
		let res = self.sourceFileExists(fileName) || ts.sys.fileExists(fileName)
		return res

	def readFile fileName
		var source = self.files[fileName]

		if source
			log("compile file {source.imbaPath}")
			source.compile()
			return String(source.js)

		return ts.sys.readFile(fileName)

	def writeFile fileName, contents
		log "writeFile",fileName
		return

	// Used for testing mainly
	def $updateFile fileName, append
		fileName = path.resolve(rootPath,fileName)

		if let file = self.files[fileName]
			let t = Date.now!
			log 'found file!',fileName,file.version
			file.getSourceContent!
			if append isa Function
				file.content = append(file.content)
			elif typeof append == 'string'
				file.content += append

			file.version++
			file.invalidate!
			self.version++
			file.emitFile!
			log 'updatedFile',fileName,Date.now! - t
		return

	def removeFile fileName
		fileName = path.resolve(self.rootPath,fileName)
		if let file = self.files[fileName]
			file.removed = true
			self.version++

	def scheduleEmitDiagnostics
		emitDiagnostics!

	def emitDiagnostics
		let entries = tls.getProgram!.getSemanticDiagnostics!
		let map = {}

		for entry in entries
			# console.log 'diagnostic entry',entry.file.fileName
			if let file = files[entry.file.fileName]
				let items = map[file.jsPath] ||= []
				items.push(entry)

		for file in files
			file.updateDiagnostics(map[file.jsPath])

		self

	def getSemanticDiagnostics
		let t = Date.now!
		let entries = tls.getProgram!.getSemanticDiagnostics!

		let info = entries.map do
			[$1.file.fileName,$1.messageText,$1.start,$1.length,$1.relatedInformation,$1]

		return

	def inspectProgram
		let program = tls.getProgram!
		let files = program.getSourceFiles!.map do $1.fileName
		console.log files

	def inspectFile fileName
		fileName = path.resolve(rootPath,fileName)
		let program = tls.getProgram!
		let sourceFile = program.getSourceFile(fileName)
		console.log sourceFile,sourceFile.referencedFiles

	# methods for vscode
	def onDidOpen event
		let doc = event.document
		let src = util.uriToPath(event.document.uri)
		log('onDidOpen',src)
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
			log 'renamed file?',entry.oldUri.path
			if let file = self.files[entry.oldUri.path]
				# console.log 'found renamed file!',file.imbaPath
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
		let file\File = self.files[src] ||= File.new(self,src)

		return file

	def getDefinitionAtPosition uri, pos
		let file = self.getImbaFile(uri)
		let loc = self.documents.get(uri).offsetAt(pos)
		
		unless tls
			return []

		let jsloc = file.generatedLocFor(loc)
		let info = tls.getDefinitionAndBoundSpan(file.lsPath,jsloc)

		if info and info.definitions

			let sourceSpan = file.textSpanToRange(info.textSpan)
			let sourceText = file.textSpanToText(info.textSpan)
			let isLink = sourceText and sourceText.indexOf('-') >= 0
			# console.log 'definitions!',sourceSpan,sourceText,isLink

			var defs = for item of info.definitions
				# console.log 'get definition',item
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
					let span = util.textSpanToRange(item.contextSpan or item.textSpan,item.fileName,tls)
					if isLink
						LocationLink.create(util.pathToUri(item.fileName),span,span,sourceSpan)
					else
						Location.create(util.pathToUri(item.fileName),span)
			return defs

	# should delegate this through to the file itself
	def getCompletionsAtPosition uri, pos, context = {}
		let file = getImbaFile(uri)
		let loc = typeof pos == 'number' ? pos : documents.get(uri).offsetAt(pos)
		let ctx = file.getContextAtLoc(loc)

		let options = {
			triggerCharacter: context.triggerCharacter
			includeCompletionsForModuleExports: true,
			includeCompletionsWithInsertText: true
		}
	
		if ctx.context == 'tagname' and context.triggerCharacter == '<'
			options.autoclose = yes
			connection.sendNotification('closeAngleBracket',{location: loc,position: pos, uri: uri})

		return file.getCompletionsAtPosition(loc,options)

	def doResolve item\CompletionItem
		console.log 'resolving',item
		if item and item.data.resolved
			return item

		let source = item.data.source
	
		let prefs\UserPreferences = {
			includeCompletionsForModuleExports: true,
			includeCompletionsWithInsertText: true,
			importModuleSpecifierPreference: "relative",
			importModuleSpecifierEnding: "minimal"
		}

		let details = tls.getCompletionEntryDetails(item.data.path,item.data.loc,item.label,{},source,prefs)
		if details
			console.dir details, {depth: 8}
			item.detail = ts.displayPartsToString(details.displayParts)
			item.documentation = ts.displayPartsToString(details.documentation)

			let actions = details.codeActions || []
			let additionalEdits = []
			let actionDescs = ''
			for action in actions
				actionDescs += action.description + '\n'
				if let m = action.description.match(/Change '([^']+)' to '([^']+)'/)
					console.log 'change action',m
					if m[1] == (item.insertText or item.label)
						item.insertText = m[2]
						continue

				for change in action.changes
					let file = getImbaFile(change.fileName)

					for textedit in change.textChanges
						let range = file.textSpanToRange(textedit.span)
						console.log 'additional change here',textedit,range
						let text = textedit.newText.replace(/\;/g,'')
						additionalEdits.push(range: range, newText: text)
			item.detail = actionDescs + item.detail
			item.additionalTextEdits = additionalEdits
			console.log item
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
		let info = loc2 and tls.getQuickInfoAtPosition(String(file.lsPath), loc2)

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
			
	def getWorkspaceSymbols {query='',type=null} = {}
		# indexFiles! # not after simple changes
		let symbols = cache.symbols ||= files.reduce(&,[]) do $1.concat($2.workspaceSymbols)
		if query
			symbols = symbols.filter do util.matchFuzzyString(query,$1.name)

		if (type instanceof Array)
			symbols = symbols.filter do type.indexOf($1.type) >= 0
		elif type
			symbols = symbols.filter do $1.type == type
		
		return symbols

	def onReferences params\ReferenceParams
		return [] unless tls

		let uri = params.textDocument.uri
		let file = getImbaFile(uri)
		let loc = documents.get(uri).offsetAt(params.position)
		# @type {number}
		let tsp-loc = file.generatedLocFor(loc)
		console.log 'referencs',uri,params.position,loc,tsp-loc

		let references = tls.getReferencesAtPosition(file.jsPath,tsp-loc)
		let results\Location[] = []
		console.log references
		for ref in references
			let ifile\File = files[ref.fileName]
			let span = ifile.textSpanToRange(ref.textSpan)
			results.push(Location.create(ifile.uri,span)) if span
		console.log 'results',results
		return results

	def getSymbols uri
		let file = self.getImbaFile(uri)
		return unless file

		unless tls
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