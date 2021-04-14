import { Component } from './Component'
import { snippets } from './snippets'
# import { Location, LocationLink } from 'vscode-languageserver'
import type {TextDocuments,IConnection,InitializeParams,ReferenceParams,CompletionItem, RenameRequest} from 'vscode-languageserver'
# import { TextDocument } from 'vscode-languageserver-textdocument'
import {CompletionItemKind,SymbolKind, Location, LocationLink} from 'vscode-languageserver-types'
import type { WorkspaceEdit } from 'vscode-languageserver-types'
import type {CompilerOptions,LanguageService,LanguageServiceHost,UserPreferences} from 'typescript'

import {URI} from 'vscode-uri'
import {File} from './File'
import {Entities} from './Entities'
import * as util from './utils'

import {TAG_NAMES,TAG_TYPES} from './constants'

const path = require 'path'
const fs = require 'fs'
const ts = require 'typescript'
import * as glob from 'glob'
import system from './system'

# const glob = require 'glob'
const imbac = require 'imba/compiler'

import {resolveConfigFile} from 'imba/src/compiler/imbaconfig'
import ServiceHost from './Host'
# const imbac = require 'imba/dist/compiler.js'

global.ts = ts

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
	assumeChangesOnlyAffectDirectDependencies: false
	suppressExcessPropertyErrors: true
	suppressImplicitAnyIndexErrors: true
	traceResolution: false
	resolveJsonModule: true
	incremental: true
	target: ts.ScriptTarget.ES2020
	# lib: ['lib.esnext.d.ts','lib.dom.d.ts','lib.dom.d.ts']
	# types: ['node']
	types: ['node']
	module: ts.ModuleKind.ESNext
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
		self.ts = ts
		self.documents = documents
		self.connection = connection
		self.rootPath = util.uriToPath(params.rootUri)
		self.imbaConfig = resolveConfigFile(self.rootPath,fs:fs,path:path) or {}
		self.entities = new Entities(self,self.imbaConfig)
		
		self.rootFiles = o.rootFiles || []

		self.snapshots = {} # need to be invalidated with program?
		self.version = 0
		self.debug = !!o.debug
		self.cache = {}
		self.settings = {}
		self.counters = {diagnostics: 1}

		self.sys = ts.sys || system

		# long promise for tls?
		# log('imba config',imbaConfig)
		# log('assets',Object.keys(imbaConfig.assets or {}))

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

	def start settings = {}
		self.settings = settings
		# console.log 'initialized!',settings
				
		tslOptions = Object.assign({},tsServiceOptions,settings.ts or {})
		if settings.checkImba !== undefined
			tslOptions.checkJs = settings.checkImba

		createTypeScriptService tslOptions
		setTimeout(&,0) do indexFiles!
		return self
		
	def createTypeScriptService options
		return if imbaConfig.legacy

		if imbaConfig.alias
			let paths = options.paths ||= {}
			for own key, value of imbaConfig.alias
				paths[key] = [value]
				paths[key + '/*'] = [value + '/*']

		if imbaConfig.types
			options.types = imbaConfig.types

		#tshost = new ServiceHost(self,options)
		self.tlsdocs = ts.createDocumentRegistry(yes,self.rootPath)
		self.tls = ts.createLanguageService(#tshost,tlsdocs)
		return self

	def getDirectories dir
		let res = sys.getDirectories(dir)
		return res

	def readDirectory dir,...params
		return sys.readDirectory(dir,...params)

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
		let file = getRichFile(fileName,yes)
		file..emitFile!
		return file

	def indexFiles
		let t = Date.now!
		let matches = glob.sync(path.resolve(self.rootPath,'**','*.imba'),ignore: 'node_modules')
		matches = matches.filter do(file) file.indexOf('node_modules') == -1
		allFiles ||= matches.map do(file) getRichFile(file)

		self

	def getProgram
		tls.getProgram()

	get tlsprogram
		tls.getProgram()

	def fileExists fileName
		# console.log 'fileExists',fileName,util.t2iPath(fileName)
		return sys.fileExists(util.t2iPath(fileName))

	def readFile fileName
		devlog 'readFile',fileName

		let source = self.files[fileName]
		if source
			return source.getCompiledBody!
			source.compile()
		# log 'readFile',fileName
		return system.readFile(fileName)

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

		let targets = files.filter do $1.shouldEmitDiagnostics

		for file in targets
			versions[file.tsPath] = {
				doc: file.doc.version
				idoc: file.idoc.version
			}

		if true # setTimeout(&,10) do 
			devlog 'getSemanticDiagnostics'
			let entries = program.getSemanticDiagnostics!
			if request != counters.diagnostics
				devlog 'other diagnostics are on the way'
				return

			# console.log 'received diagnostics',entries

			for entry in entries when entry.file
				# console.log 'diagnostic entry',entry.file
				if let file = files[entry.file.fileName]
					let items = map[file.tsPath] ||= []
					items.push(entry)

			if true # setTimeout(&,10) do
				devlog 'updateDiagnostics'
				for file in targets
					file.updateDiagnostics(map[file.tsPath],versions[file.tsPath])
		
		# console.log 'emitDiagnostics took',Date.now! - t0
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
		let origsrc = src
		src = util.uriToPath(src)
		src = util.normalizePath(path.resolve(self.rootPath,src).replace(/\.(imba|js|ts)$/,'.imba'))
		# what if it is a local file?
		return self.files[src] || File.build(self,src)

	def getRichFile src,onlyIfExists = no
		if src.indexOf('file://') == 0
			src = util.uriToPath(src)

		src = util.normalizePath(path.resolve(self.rootPath,src))

		if onlyIfExists and !system.fileExists(src)
			return null

		return self.files[src] || File.build(self,src)

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
		let info = tls.getDefinitionAndBoundSpan(file.tsPath,jsloc)

		log 'get definition',uri,pos,loc,jsloc,info

		if info and info.definitions
			let sourceSpan = file.textSpanToRange(info.textSpan)
			let sourceText = file.textSpanToText(info.textSpan)
			let isLink = sourceText and sourceText.indexOf('-') >= 0
			
			let defs = for item of info.definitions
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
					
					log 'definition',item,textSpan,span,item.kind
					if item.kind == 'module'
						textSpan = {start: {line:0,character:0},end: {line:0,character:0}}
						console.log 'LocationLink',ifile.uri,textSpan,sourceSpan
						LocationLink.create(ifile.uri,textSpan,textSpan,sourceSpan)
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