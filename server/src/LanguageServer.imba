import {Component} from './Component'
import {snippets} from './snippets'
import {IConnection,InitializeParams,TextDocuments,Location,LocationLink,MarkedString,DocumentSymbol,InsertTextFormat,ReferenceParams,CompletionItem, RenameRequest} from 'vscode-languageserver'
import { TextDocument } from 'vscode-languageserver-textdocument'
import {CompletionItemKind,SymbolKind, WorkspaceEdit} from 'vscode-languageserver-types'
import {CompilerOptions,LanguageService,LanguageServiceHost,UserPreferences} from 'typescript'

import {URI} from 'vscode-uri'

import {File} from './File'
import {Entities} from './Entities'
import * as util from './utils'

import {TAG_NAMES,TAG_TYPES} from './constants'

const path = require 'path'
const fs = require 'fs'
const ts = require 'typescript'
const glob = require 'glob'
const imbac = require 'imba/dist/compiler.js'
import {resolveConfigFile} from 'imba/src/compiler/imbaconfig'
# const imbac = require 'imba/dist/compiler.js'

const tsServiceOptions\CompilerOptions = {
	allowJs: true
	checkJs: true
	noEmit: true
	skipLibCheck: true
	skipDefaultLibCheck: true
	allowUmdGlobalAccess: true
	allowNonTsExtensions: true
	allowUnreachableCode: true
	allowUnusedLabels: true
	strictNullChecks: false
	noImplicitUseStrict: true
	noStrictGenericChecks: true
	allowSyntheticDefaultImports: true
	suppressExcessPropertyErrors: true
	traceResolution: true
	resolveJsonModule: true
	incremental: true
	target: ts.ScriptTarget.Latest
	lib: ['lib.es6.d.ts']
	# types: ['node']
	types: ['node']
	forceConsistentCasingInFileNames: true
	# module: ts.ModuleKind.System
	moduleResolution: ts.ModuleResolutionKind.NodeJs
	inlineSources: true
}

export class LanguageServer < Component

	prop allFiles\File[]
	prop rootFiles\string[]
	prop tls\LanguageService

	def resolveConfigFile dir
		return null if !dir or (dir == path.dirname(dir))
		
		let src = path.resolve(dir,'imbaconfig.json')
		if fs.existsSync(src)
			let resolver = do(key,value)
				if typeof value == 'string' and value.match(/^\.\//)
					return path.resolve(dir,value)
				return value

			let config = JSON.parse(fs.readFileSync(src,'utf8'),resolver)
			return config

		return self.resolveConfigFile(path.dirname(dir))

	def constructor(connection\IConnection, documents\TextDocuments, params\InitializeParams, o = {})
		super
		files\File[] = []

		self.documents = documents
		self.connection = connection
		self.rootPath = self.rootUri = util.uriToPath(params.rootUri)
		self.imbaConfig = resolveConfigFile(self.rootPath,fs:fs,path:path) or {}
		self.entities = new Entities(self,self.imbaConfig)

		self.rootFiles = o.rootFiles || []
		self.snapshots = {}
		self.version = 0
		self.debug = !!o.debug
		self.cache = {}
		self.settings = {}
		self.counters = {diagnostics: 1}

		# long promise for tls?
		# log('imba config',imbaConfig)
		log('assets',Object.keys(imbaConfig.assets or {}))

		for item in imbaConfig.entries
			if let file = getImbaFile(item.input)
				yes

		self

	def logPath path,...params
		if path.match(/\.js$/) and path.match(/vscode-imba/)
			console.log(...params,path)
		

	def updateConfiguration settings,all
		# console.log 'updating settings',settings
		config.update(settings)

	def start settings
		self.settings = settings
		# console.log 'initialized!',settings
		
		tslOptions = Object.assign({},tsServiceOptions)
		if settings.checkImba !== undefined
			tslOptions.checkJs = settings.checkImba

		createTypeScriptService tslOptions

		setTimeout(&,0) do indexFiles!
		return self

	
		
	def createTypeScriptService options
		return if imbaConfig.legacy

		# options.baseUrl =  self.rootPath

		if imbaConfig.alias
			let paths = options.paths = {}
			for own key, value of imbaConfig.alias
				paths[key] = [value]
				paths[key + '/*'] = [value + '/*']

		const realpath = do(path)
			log 'realpath',path
			return path

		if imbaConfig.types
			options.types = imbaConfig.types

		const resolutionHost = {
			fileExists: self.fileExists.bind(self)
			readFile: self.readFile.bind(self)
		}

		const resolveModuleNames = do(moduleNames,containingFile)
			const resolvedModules = []
			log 'resolving',moduleNames,containingFile
			for moduleName of moduleNames
				
				# try to use standard resolution
				let result = ts.resolveModuleName(moduleName, containingFile, options, resolutionHost)
				if result.resolvedModule
					console.log 'resolved module',result.resolvedModule
					resolvedModules.push(result.resolvedModule)
				else
					console.log 'could not resolve module!!!!',moduleName
					# check fallback locations, for simplicity assume that module at location
					# should be represented by '.d.ts' file
					for location of []
						const modulePath = path.join(location, moduleName + ".d.ts")
						if fileExists(modulePath)
							resolvedModules.push({ resolvedFileName: modulePath })

			return resolvedModules

		const servicesHost\LanguageServiceHost = {
			getScriptFileNames:  do self.rootFiles
			getProjectVersion:   do '' + self.version
			getTypeRootsVersion: do 1
			useCaseSensitiveFileNames: do yes
			# realpath: realpath
			# resolveModuleNames: resolveModuleNames
			getScriptKind: do(fileName)
				let file = self.files[fileName]
				
				if file
					return ts.ScriptKind.JS
				else
					return ts.getScriptKindFromFileName(fileName)
				

			getScriptVersion: do(fileName)
				let version = self.files[fileName] ? String(self.files[fileName].version.toString()) : "1"
				return version

			# @param {string} fileName
			getScriptSnapshot: do(fileName)
				logPath fileName, 'getScriptSnapshot'
				if !self.fileExists(fileName)
					return undefined

				if let file = self.files[fileName]
					file.compile()
					return file.jsSnapshot

				let snapshot = self.snapshots[fileName] ||= ts.ScriptSnapshot.fromString(self.readFile(fileName).toString())
				return snapshot
			
			getCurrentDirectory: do self.rootPath
			getCompilationSettings: do options
			getDefaultLibFileName: do(options) ts.getDefaultLibFilePath(options)
			getSourceFile: self.getSourceFile.bind(self)
			fileExists: self.fileExists.bind(self)
			readFile: self.readFile.bind(self)
			writeFile: self.writeFile.bind(self)
			readDirectory: ts.sys.readDirectory
			getNewLine: do '\n'
		}

		self.tls = ts.createLanguageService(servicesHost,ts.createDocumentRegistry!)

	def resolveModuleNames moduleNames, containingFile
		log 'resolveModuleNames',containingFile

	def getSourceFile filename, languageVersion
		log 'getSourceFile',filename

	def invalidate
		version++
		cache = {}

	def emitRootFiles
		for file in self.rootFiles
			console.log 'emit output',file
			tls.getEmitOutput(file)

	def addFile fileName
		fileName = path.resolve(self.rootPath,fileName)
		# sourceFileExists
		if self.sourceFileExists(fileName)
			self.files[fileName].emitFile()
		return self.files[fileName]
			
	def indexFiles
		let t = Date.now!
		let matches = glob.sync(path.resolve(self.rootPath,'**','*.imba'),ignore: 'node_modules')
		matches = matches.filter do(file) file.indexOf('node_modules') == -1
		allFiles ||= matches.map do(file) getImbaFile(file)

		self

	def getProgram
		tls.getProgram()

	# comment about the source file?
	def sourceFileExists fileName\string
		let [m,ext] = (fileName.match(/\.(d\.ts|\w+)$/) or [])
	
		var alt = fileName.replace(/\.ts/, '.imba')

		if ext == 'd.ts'
			return false

		if let file = self.files[alt]
			return file.removed ? false : true
		
		if ((alt != fileName) or fileName.match(/\.imba$/)) && ts.sys.fileExists(alt)
			if ts.sys.fileExists(alt.replace(/\.imba$/,'.d.ts'))
				return false

			new File(self,alt,fileName)
			return true
		return false

	def fileExists fileName
		let res = self.sourceFileExists(fileName) || ts.sys.fileExists(fileName)
		return res

	def readFile fileName
		var source = self.files[fileName]
		# logPath(fileName,'readFile')
		# log 'readFile',fileName
		if source
			source.compile()
			return String(source.js)

		return ts.sys.readFile(fileName)

	def writeFile fileName, contents
		log "writeFile",fileName
		return

	def removeFile fileName
		fileName = path.resolve(self.rootPath,fileName)
		if let file = self.files[fileName]
			file.removed = true
			self.version++

	def clearProblems
		for file in files
			file.diagnostics.clear!
		self

	def emitDiagnostics
		let versions = {}
		let map = {}
		let t0 = Date.now!
		let program = tls.getProgram!
		let request = ++counters.diagnostics

		console.log 'emitDiagnostics'
		for file in files
			versions[file.tsPath] = {
				doc: file.doc.version
				idoc: file.idoc.version
			}

		if true # setTimeout(&,10) do 
			console.log 'getSemanticDiagnostics'
			let entries = program.getSemanticDiagnostics!
			if request != counters.diagnostics
				console.log 'other diagnostics are on the way'
				return

			for entry in entries when entry.file
				# console.log 'diagnostic entry',entry.file.fileName
				if let file = files[entry.file.fileName]
					let items = map[file.tsPath] ||= []
					items.push(entry)

			if true # setTimeout(&,10) do
				console.log 'updateDiagnostics'
				for file in files
					file.updateDiagnostics(map[file.tsPath],versions[file.tsPath])
		
		console.log 'emitDiagnostics took',Date.now! - t0
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
		else
			self.version++
		self

	def onDidChangeTextEditorSelection event
		let src = util.uriToPath(event.uri)
		if files[src]
			files[src].onDidChangeTextEditorSelection(event)
		yes

	def onDidRenameFiles event
		let version = self.version
		
		for entry in event.files
			log 'renamed file?',entry.oldUri.path
			if let file = self.files[entry.oldUri.path]
				# console.log 'found renamed file!',file.imbaPath
				file.dispose()
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
		let file\File = self.files[src] ||= new File(self,src)

		return file

	def getSemanticTokens uri
		let file = self.getImbaFile(uri)
		return file.idoc.getEncodedSemanticTokens!

	def getDefinitionAtPosition uri, pos
		let file = self.getImbaFile(uri)
		if !file or file.isLegacy
			return []

		let loc = self.documents.get(uri).offsetAt(pos)
		let fileres = file.getDefinitionAtPosition(pos)

		if fileres
			return fileres
		
		unless tls
			return []

		let jsloc = file.generatedLocFor(loc)
		let info = tls.getDefinitionAndBoundSpan(file.lsPath,jsloc)

		if info and info.definitions
			let sourceSpan = file.textSpanToRange(info.textSpan)
			let sourceText = file.textSpanToText(info.textSpan)
			let isLink = sourceText and sourceText.indexOf('-') >= 0
			console.log 'definitions!',sourceSpan,sourceText,isLink

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

		try
			return file.getCompletionsAtOffset(loc,context)
		catch e
			console.log 'error from getCompletions',e
			return []


	def doResolve item\CompletionItem
		inspect item
		if item and (!item.data or item.data.resolved)
			return item

		let source = item.data.source
		let name = item.data.origName or item.label
	
		let prefs\UserPreferences = {
			includeCompletionsForModuleExports: true,
			includeCompletionsWithInsertText: true,
			importModuleSpecifierPreference: "relative",
			importModuleSpecifierEnding: "minimal"
		}

		let details = tls.getCompletionEntryDetails(item.data.path,item.data.loc,name,{},source,prefs)

		if details
			inspect details
			item.detail = ts.displayPartsToString(details.displayParts)
			item.documentation = ts.displayPartsToString(details.documentation)

			let actions = details.codeActions || []
			let additionalEdits = []
			let actionDescs = ''
			for action in actions
				actionDescs += action.description + '\n'
				if let m = action.description.match(/Change '([^']+)' to '([^']+)'/)
					log 'change action',m

					if m[1] == (item.insertText or item.label)
						item.insertText = util.tjs2imba(m[2])
						continue

				for change in action.changes
					let file = getImbaFile(change.fileName)

					for textedit in change.textChanges
						let range = file.textSpanToRange(textedit.span)
						log 'additional change here',textedit,range
						let text = util.tjs2imba(textedit.newText)
						additionalEdits.push(range: range, newText: text)

			item.detail = util.tjs2imba(actionDescs + item.detail)
			item.additionalTextEdits = additionalEdits

			log item
			delete item.data
		return item

	def getQuickInfoAtPosition uri, pos
		# force the js imba file for conversion\
		# let path = util.uriToPath(file.url or file).replace('.imba','.js')
		# console.log "get quick info at pos {path}"
		try
			let file = getImbaFile(uri)
			let res = file.getQuickInfoAtPosition(pos)
			return res
		catch e
			log 'getQuickInfoAtPosition error',e,uri,pos
			return null

	def getPathCompletions basePath, query
		# index all files in the project
		log 'path completions',basePath,query
		# should be cached for a file for some time?
		let items = []
		let dir = path.dirname(basePath)
		for file in files
			let full = file.imbaPath
			let rel = path.relative(dir,full)
			rel = "./{rel}" if rel[0] != '.'
			rel = rel.replace(/\.imba$/,'')
			let sortText = "" + rel.replace(/[^\.\/]/g,'').length
			items.push({
				label: rel
				kind: CompletionItemKind.File
				data: {resolved: yes}
				sortText: sortText
				
			})

		# if query
		#	items = items.filter do util.matchFuzzyString(item.label,$1.name)
		
		return items
			
	def getWorkspaceSymbols options = {}
		# indexFiles! # not after simple changes
		let symbols = cache.symbols ||= files.reduce(&,[]) do $1.concat($2.workspaceSymbols)

		unless cache.symbolmap
			cache.symbolmap = {}
			for sym in symbols
				cache.symbolmap[sym.name] = sym

		if (options.type instanceof Array)
			symbols = symbols.filter do options.type.indexOf($1.type) >= 0
		elif options.type
			symbols = symbols.filter do $1.type == options.type

		if options.prefix
			symbols = symbols.filter do $1.name.indexOf(options.prefix) == 0
		
		if options.query isa RegExp
			symbols = symbols.filter do options.query.test($1.name)
			
		elif options.query
			let q = options.query.toLowerCase!
			symbols = symbols.filter do util.matchFuzzyString(q,$1.name)
		
		return symbols

	def getWorkspaceSymbol name
		getWorkspaceSymbols!
		return cache.symbolmap[name]

	def onReferences params\ReferenceParams
		return [] unless tls

		let uri = params.textDocument.uri
		let file = getImbaFile(uri)
		let loc = documents.get(uri).offsetAt(params.position)
		# @type {number}
		let tsp-loc = file.generatedLocFor(loc)
		log 'references',uri,params.position,loc,tsp-loc

		let references = tls.getReferencesAtPosition(file.tsPath,tsp-loc)
		let results\Location[] = []
		inspect references
		for ref in references
			let ifile\File = files[ref.fileName]
			let span = ifile.textSpanToRange(ref.textSpan)
			results.push(Location.create(ifile.uri,span)) if span
		inspect results
		return results

	def onRenameRequest params
		let renames\WorkspaceEdit = {changes: {}}
		try
			let newName = params.newName
			let file = getImbaFile(params.textDocument.uri)
			let iloc = file.offsetAt(params.position)
			let tloc = file.generatedLocFor(iloc)
			log 'rename request',iloc,tloc,params
			let t_renames = tls.findRenameLocations(file.tsPath,tloc,false,false)
			log t_renames

			for rename in t_renames
				let dest = getImbaFile(rename.fileName)
				let edits = (renames.changes[dest.uri] ||= [])
				let range = dest.textSpanToRange(rename.textSpan)
				edits.push(range: range, newText: newName)
		inspect renames
		return renames

	def getSymbols uri
		let file = self.getImbaFile(uri)
		return unless file

		return file.getSymbols()

		if !tls or true
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