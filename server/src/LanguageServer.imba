

import {createConnection, TextDocuments,TextDocument,Location,LocationLink,MarkedString} from 'vscode-languageserver'
import {CompletionItemKind} from 'vscode-languageserver-types'

import {URI} from 'vscode-uri'

import {File} from './File'
import * as util from './utils'

var fs = require 'fs'
var ts = require 'typescript'
var imbac = require 'imba/dist/compiler.js'

var tsServiceOptions = {
	allowJs: true,
	checkJs: true,
	# declaration: true,
	# emitDeclarationOnly: true,
	noEmit: true,
	allowNonTsExtensions: true,
	allowUnreachableCode: true,
	allowUmdGlobalAccess: true,
	allowUnusedLabels: true,
	incremental: true,
	target: ts.ScriptTarget.Latest,
	lib: ['lib.es6.d.ts'],
	moduleResolution: ts.ModuleResolutionKind.NodeJs,
	tsBuildInfoFile: "/Users/sindre/repos/tsbuildinfo"
}

export class LanguageServer
	
	def constructor connection, documents, {rootUri}
		
		@files = {}
		@documents = documents
		@connection = connection
		@rootUri = util.uriToPath(rootUri)
		@rootFiles = []
		@snapshots = {}
		@version = 0

		console.log 'start for',@rootUri

		# create the host
		var servicesHost = {
			getScriptFileNames: do
				return @rootFiles

			# getScriptKind: do |fileName|
			# 	if @files[fileName]
			# 		return 1
			# 	else
			# 		return 5

			getProjectVersion: do
				# console.log 'getProjectVersion',@version
				return '' + @version

			getTypeRootsVersion: do
				return '' + 1

			# getLocalizedDiagnosticMessages: do
			# 	console.log 'getLocalizedDiagnosticMessages'

			getScriptVersion: do |fileName|
				# console.log "getScriptVersion",fileName,@files[fileName] and @files[fileName].version.toString()
				# if @snapshots[fileName]
				# 	console.log 'hsas snapshot',@snapshots[fileName]
				return @files[fileName] ? @files[fileName].version.toString() : "1"

			getScriptSnapshot: do |fileName|
				return undefined if !@fileExists(fileName)
				# @snapshots[fileName] ||= ts.ScriptSnapshot.fromString(@readFile(fileName).toString())
				# console.log "get snapshot {fileName}"
				return ts.ScriptSnapshot.fromString(@readFile(fileName).toString())
				return @snapshots[fileName] # ts.ScriptSnapshot.fromString(@readFile(fileName).toString())
			
			getCurrentDirectory: do @rootUri
			getCompilationSettings: do tsServiceOptions
			getDefaultLibFileName: do |options| ts.getDefaultLibFilePath(options)
			fileExists: @fileExists.bind(self)
			readFile: @readFile.bind(self)
			readDirectory: ts.sys.readDirectory
			writeFile: do |filename,str|
				console.log "writeFile {fileName}"
		}

		@registry = ts.createDocumentRegistry()
		@service = ts.createLanguageService(servicesHost)
		# console.log "program??",@service.getProgram()
		console.log @service.getCompilerOptionsDiagnostics()
		self

	def log ...params
		console.log(...params)

	def acquireDocument path, source, version
		source = ts.ScriptSnapshot.fromString(source) if source isa String
		@registry.acquireDocument(path,tsServiceOptions,source,version)

	def updateDocument path, source, version
		source = ts.ScriptSnapshot.fromString(source) if source isa String
		@registry.updateDocument(path,tsServiceOptions,source,version)

	def sourceFileExists(fileName)
		if @files[fileName]
			return true

		var alt = fileName.replace(/\.js$/, '.imba')

		if alt != fileName && ts.sys.fileExists(alt)
			File.new(self,alt)
			return true
		return false

	def fileExists(fileName) 
		console.log("fileExists {fileName}")
		@sourceFileExists(fileName) || ts.sys.fileExists(fileName)

	def readFile(fileName)
		var source = @files[fileName]

		if source
			@log("readFile {source.imbaPath}")
			source.compile()
			return source.js

		return ts.sys.readFile(fileName)

	# methods for vscode
	def onDidOpen event
		let doc = event.document
		let uri = util.uriToPath(event.document.uri)
		self

	def onDidSave event
		let doc = event.document
		let uri = util.uriToPath(doc.uri)
		@version++
		let file = @getImbaFile(doc)
		if file
			file.didSave(doc)
			let diag = @service.getProgram().getGlobalDiagnostics()

		self

	def onDidChangeContent event
		@log "server.onDidChangeContent"
		let doc = event.document
		if let file = @getImbaFile(event.document)
			file.didChange(doc)


	def getImbaFile file
		let doc = @documents.get(file.uri or file)
		let src = util.uriToPath(file.uri or file).replace('.imba','.js')
		return @files[src] ||= File.new(self,src)

	def getDefinitionAtPosition uri, pos
		let file = @getImbaFile(uri)
		let loc = @documents.get(uri).offsetAt(pos)
		let jsloc = file.generatedLocFor(loc)
		let info = @service.getDefinitionAndBoundSpan(file.jsPath,jsloc)

		if info and info.definitions
			console.log 'definitions!',info
			let sourceSpan = file.textSpanToRange(info.textSpan)

			var defs = for item,i in info.definitions
				
				let ifile = @files[item.fileName]
				if ifile
					console.log 'definition',item
					let textSpan = ifile.textSpanToRange(item.textSpan)
					let span = item.contextSpan ? ifile.textSpanToRange(item.contextSpan) : textSpan
					# Location.create(ifile.uri,item.textSpan.range)
					# let range = item.textSpan.range
					# contextSpan = {
					# 	start: {line: textSpan.start.line, character: 1}
					# 	end: {line: textSpan.start.line + 5, character: 1}
					# }

					if item.containerName == 'globalThis' and item.name.indexOf('Component') >= 0
						span = {
							start: {line: textSpan.start.line, character: 0}
							end: {line: textSpan.start.line + 1, character: 0}
						}
	
					let link = LocationLink.create(
						ifile.uri,
						textSpan,
						span,
						sourceSpan
					)
					# console.log 'def map',[item.textSpan,item.contextSpan],[textSpan,span],sourceSpan
					link
					# Location.create(ifile.uri,textSpan)

				elif item.name == '__new' and info.definitions.length > 1
					continue
				else
					let span = util.textSpanToRange(item.contextSpan or item.textSpan,item.fileName,@service)
					LocationLink.create(
						util.pathToUri(item.fileName),
						span,
						span,
						sourceSpan
					)

			return defs
		# if let info = file.getDefinitionAtPosition(loc)
		#	return info

	def getCompletionsAtPosition uri, pos, context
		let file = @getImbaFile(uri)
		let loc = @documents.get(uri).offsetAt(pos)
		let loc2 = file.generatedLocFor(loc)
		let options = {
			triggerCharacter: context.triggerCharacter
			includeCompletionsForModuleExports: true
		}
		let res = @service.getCompletionsAtPosition(file.jsPath,loc2,options)
		
		if res
			console.log 'complete',uri,loc,loc2,res.isNewIdentifierLocation,res.isGlobalCompletion
			if res.isMemberCompletion
				console.log 'completions',res.entries

			let entryFor = do |entry|
				{
					uri: uri,
					position: pos,
					label: entry.name,
					kind: util.convertCompletionKind(entry.kind,entry),
					sortText: entry.sortText
					data: {
						loc: loc2
						path: file.jsPath
						origKind: entry.kind
					}
				}

			let items = res.entries.map(entryFor)

			if res.isMemberCompletion
				items = items.filter do $1.kind != CompletionItemKind.Text
				console.log 'resulting completions',items

			let out = {
				isIncomplete: false,
				items: items
			}
			return out
		return null

	def doResolve item
		console.log 'resolving',item
		let details = @service.getCompletionEntryDetails(item.data.path,item.data.loc,item.label)
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
		let loc2 = file.generatedLocFor(loc)
		# console.log pos2
		if let info = @service.getQuickInfoAtPosition(file.jsPath, loc2) # file.getQuickInfoAtPosition(loc)

			let contents = [{
					value: ts.displayPartsToString(info.displayParts)
					language: 'typescript'
				}]

			if info.documentation
				# contents.push({type: 'text', value: })
				contents.push(ts.displayPartsToString(info.documentation))
			return {
				range: file.textSpanToRange(info.textSpan)
				contents: contents
			}
