

import {createConnection, TextDocuments,TextDocument,Location,LocationLink,MarkedString,DocumentSymbol} from 'vscode-languageserver'
import {CompletionItemKind,SymbolKind} from 'vscode-languageserver-types'

import {URI} from 'vscode-uri'

import {File} from './File'
import * as util from './utils'

var fs = require 'fs'
var ts = require 'typescript'
var imbac = require 'imba/dist/compiler.js'

var tsServiceOptions = {
	allowJs: true
	checkJs: true
	noEmit: true
	allowUmdGlobalAccess: true
	allowNonTsExtensions: true
	allowUnreachableCode: true
	# allowUmdGlobalAccess: true
	allowUnusedLabels: true
	noImplicitUseStrict: true
	noStrictGenericChecks: true
	allowSyntheticDefaultImports: true
	incremental: true
	target: ts.ScriptTarget.Latest
	lib: ['lib.es6.d.ts']
	moduleResolution: ts.ModuleResolutionKind.NodeJs
}

export class LanguageServer
	
	def constructor connection, documents, {rootUri}
		
		@files = {}
		@documents = documents
		@connection = connection
		@rootUri = util.uriToPath(rootUri)
		# @type {string[]}
		@rootFiles = []
		@snapshots = {}
		@version = 0

		# @type {ts.LanguageServiceHost}
		var servicesHost = {
			getScriptFileNames: do @rootFiles
			getProjectVersion: do '' + @version
			getTypeRootsVersion: do 1

			getScriptVersion: do |fileName|
				return @files[fileName] ? String(@files[fileName].version.toString()) : "1"
			# @param {string} fileName
			getScriptSnapshot: do |fileName|
				return undefined if !@fileExists(fileName)
				return ts.ScriptSnapshot.fromString(@readFile(fileName).toString())
			
			getCurrentDirectory: do @rootUri
			getCompilationSettings: do tsServiceOptions
			getDefaultLibFileName: do |options| ts.getDefaultLibFilePath(options)
			fileExists: @fileExists.bind(self)
			readFile: @readFile.bind(self)
			readDirectory: ts.sys.readDirectory
		}

		@registry = ts.createDocumentRegistry()
		@service = ts.createLanguageService(servicesHost,@registry)
		self

	def log ...params
		console.log(...params)

	def acquireDocument path, source, version
		source = ts.ScriptSnapshot.fromString(source) if typeof source == 'string'
		@registry.acquireDocument(path,tsServiceOptions,source,version)

	def updateDocument path, source, version
		source = ts.ScriptSnapshot.fromString(source) if typeof source == 'string'
		@registry.updateDocument(path,tsServiceOptions,source,version)

	def sourceFileExists fileName
		if @files[fileName]
			return true

		var alt = fileName.replace(/\.js$/, '.imba')

		if alt != fileName && ts.sys.fileExists(alt)
			File.new(self,alt,@service)
			return true
		return false

	def fileExists fileName 
		# console.log("fileExists {fileName}")
		@sourceFileExists(fileName) || ts.sys.fileExists(fileName)

	def readFile fileName
		var source = @files[fileName]

		if source
			# @log("readFile {source.imbaPath}")
			source.compile()
			return String(source.js)

		return ts.sys.readFile(fileName)

	# methods for vscode
	def onDidOpen event
		let doc = event.document
		let uri = util.uriToPath(event.document.uri)
		let file = @getImbaFile(doc)
		if file
			file.didOpen(doc)
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
		# @log "server.onDidChangeContent"
		let doc = event.document
		if let file = @getImbaFile(event.document)
			file.didChange(doc)


	def getImbaFile file
		let doc = @documents.get(file.uri or file)
		let src = util.uriToPath(file.uri or file)
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
			# console.log 'definitions!',info,sourceSpan,sourceText

			var defs = for item of info.definitions

				let ifile = @files[item.fileName]
				if ifile
					console.log 'definition',item
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

	def getCompletionsAtPosition uri, pos, context
		let file = @getImbaFile(uri)
		let loc = @documents.get(uri).offsetAt(pos)
		let loc2 = file.generatedLocFor(loc)
		let options = {
			triggerCharacter: context.triggerCharacter
			includeCompletionsForModuleExports: true
		}
		let res = @service.getCompletionsAtPosition(file.lsPath,loc2,options)
		
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
						path: file.lsPath
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
		let details = @service.getCompletionEntryDetails(item.data.path,item.data.loc,item.label,undefined,undefined,undefined)
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
		let tree = @service.getNavigationTree(file.lsPath)
		# console.log 'found results',tree
		let conv = do |item|
			return unless item.nameSpan
			return if item.kind == 'alias'
			console.log "symbol",item.kind,item.text,item.nameSpan
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
