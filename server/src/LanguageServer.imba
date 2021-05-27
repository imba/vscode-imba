import { Component } from './Component'
import { snippets } from './snippets'
# import { Bridge } from './tsbridge'


import type {TextDocuments,IConnection,InitializeParams,ReferenceParams,CompletionItem, RenameRequest} from 'vscode-languageserver'
import type { WorkspaceEdit } from 'vscode-languageserver-types'
import type {CompilerOptions,LanguageService,LanguageServiceHost,UserPreferences,Program} from 'typescript'

import {CompletionItemKind,SymbolKind, Location, LocationLink} from 'vscode-languageserver-types'

import {URI} from 'vscode-uri'
import {File,ImbaFile} from './File'
import {Entities} from './Entities'
import * as util from './utils'
import { ProgramSnapshot } from './Checker'
import { CompletionsContext } from './Completions'

import {TAG_NAMES,TAG_TYPES} from './constants'

const path = require 'path'
const fs = require 'fs'
const ts = require 'typescript'

import * as glob from 'glob'
import system from './system'

const imbac = require 'imba/compiler'

import {resolveConfigFile} from 'imba/src/compiler/imbaconfig'
import ServiceHost from './Host'

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
	maxNodeModuleJsDepth:2
	incremental: true
	target: ts.ScriptTarget.ES2020
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

		self.files\File[] = []
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
		self.tsscache = {}

		self.settings = {}
		self.counters = {diagnostics: 1}
		self.sys = ts.sys || system
		self.nextId = 0

		for item in imbaConfig.entries
			if let file = getImbaFile(item.input)
				yes

		self
	
	def lookupKey key
		files.find do $1.id == key

	def logPath path,...params
		if path.match(/\.js$/) and path.match(/vscode-imba/)
			console.log(...params,path)
			
	def emitChanges
		$cancel('emitChanges')
		invalidate!
		# maybe only when we save?!
		log 'emit changes'
		# emitDiagnostics!
		# for file in files
		#	file.emitDiagnostics!
		self
		
	def updateConfiguration settings,all
		# console.log 'updating settings',settings
		config.update(settings)

	def start settings = {}
		self.settings = settings
		# console.log 'initialized!',settings

		tslOptions = Object.assign({},tsServiceOptions,settings.ts or {})
		if settings.checkImba !== undefined
			tslOptions.checkJs = settings.checkImba
		
		if false
			tss = new Bridge(cwd: rootPath)
			
			tss.on('projectsUpdatedInBackground') do(data)
				console.log "projectsUpdatedInBackground!!!",data
				tsscache = {}
				let autoImports = await tss.rpc('getAutoImportTree')
				console.log "found autoImports",JSON.stringify(autoImports).length
				tsscache.autoImports = autoImports

		createTypeScriptService tslOptions
		setTimeout(&,0) do indexFiles!
		for file in files
			file.didLoad!
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
		
		options.rootDir = self.rootPath
			

		#tshost = self.tlshost = new ServiceHost(self,options)
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
		console.log 'indexedFiles',matches,rootFiles.map(do $1)
		invalidate!
		self

	def getProgram
		tls.getProgram()

	get tlsprogram
		tls.getProgram()

	def getSnapshot
		let prog = tls.getProgram()
		prog.#snapshot ||= new ProgramSnapshot(prog)

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
		
	def getSemanticDiagnosticsForFile file
		if #program
			let source = #program.getSourceFileByPath(file.fileName)
			return #program.getSemanticDiagnostics(source)
		else
			tls.getSemanticDiagnostics(file.fileName)

	def emitDiagnostics force = no
		false && util.time(&,'for whole program') do
			let prog = getProgram!
			let items = prog.getSemanticDiagnostics!
			console.log 'found diagnostics',items.length
		
		util.time(&,'emitDiagnostics') do
			let prog = #program = getProgram!
			# p.getSemanticDiagnostics(f0.checker.sourceFile)
			# console.log 'emit global diagnostics!'
			# #program = null
			for file in files when file.shouldEmitDiagnostics
				file.emitDiagnostics(force)
			#program = null

		return self

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
			res
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
			util.time(&,'change') do file.didChange(doc,event)

	def getImbaFile src
		# let doc = @documents && @documents.get(file.uri or file)
		let origsrc = src
		src = util.uriToPath(src)
		src = util.normalizePath(path.resolve(self.rootPath,src).replace(/\.(imba|js|ts)$/,'.imba'))
		# what if it is a local file?
		let file\ImbaFile = self.files[src] || File.build(self,src)
		return file

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
		return fileres

	# should delegate this through to the file itself
	def getCompletionsAtPosition uri, pos, context = {}
		let file = getImbaFile(uri)
		console.log 'get completions',uri,pos,context
		let loc = typeof pos == 'number' ? pos : documents.get(uri).offsetAt(pos)

		try
			
			let items = util.time(&,'getCompletions') do file.getCompletionsAtOffset(loc,context)
			console.log 'found',items..length,'items'
			return items				
		catch e
			console.log 'error from getCompletions',e
			return []

	def getEditsForFileRename from, to
		self

	def doResolve item\CompletionItem
		item = #resolveCompletionItem(item)
		if item.label.name and item.insertText === undefined
			item.insertText = item.label.name
		return item

	def #resolveCompletionItem item\CompletionItem
		let id = item.data..id
		
		if id
			let res = lookupRef(id,0)
			devlog 'resolveCompletionItem',res
			if res
				return res.#resolve!
		inspect item

		let resolved = entities.resolveCompletionEntry(item)
		
		if item and (!item.data or item.data.resolved)
			
			return item
		
		if let path = item.data.symbolPath
			let file = files[item.data.path]
			let sym = file.getSymbolAtPath(path)
			let details = sym..getCompletionDetails()

			if details
				item.detail = util.displayPartsToString(details.displayParts)
				# item.documentation = util.displayPartsToString(details.documentation)

				item.documentation = util.displayPartsToMarkup(details.documentation)
				
				# if path.match(/imba\.events/)
				# 	item.detail = item.documentation
				# 	delete item.documentation
			console.log 'resolved completion item',item
			item.data.resolved = yes
			return item


		let source = item.data.source
		let name = item.data.origName or item.label

		return item unless item.data.path
		
	
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
		return items
			
	def getWorkspaceSymbols options = {}
		# indexFiles! # not after simple changes
		let symbols = cache.symbols ||= files.reduce(&,[]) do $1.concat($2.workspaceSymbols)

		unless cache.symbolmap
			cache.symbolmap = {}
			for sym in symbols
				cache.symbolmap[sym.name] = sym

		if (options.type isa Array)
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
		let iloc = file.offsetAt(params.position)
		return file.getReferencesAtOffset(iloc)

	def onRenameRequest params
		let renames\WorkspaceEdit = {changes: {}}
		
		try
			let newName = params.newName
			let file = getImbaFile(params.textDocument.uri)
			let iloc = file.offsetAt(params.position)
			let tloc = file.generatedLocFor(iloc)
			# log 'rename request',iloc,tloc,params
			let t_renames = tls.findRenameLocations(file.fileName,tloc,false,false)
			# log t_renames
			let added = {}

			for rename in t_renames
				let dest = getImbaFile(rename.fileName)
				let edits = (renames.changes[dest.uri] ||= [])
				let range = dest.o2d(rename.textSpan, no )

				if range and !added[range[0]]
					added[range[0]] = range
					edits.push(range: range, newText: newName)
		# inspect renames
		return renames

	def onDocumentOnTypeFormatting params
		console.log "TYPE FORMATTING",params
		let uri = params.textDocument.uri
		let file = getImbaFile(uri)
		yes


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