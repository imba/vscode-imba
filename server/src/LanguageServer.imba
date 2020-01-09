

import {createConnection, TextDocuments,TextDocument,Location,MarkedString} from 'vscode-languageserver'
import {CompletionItemKind} from 'vscode-languageserver-types'

import {URI} from 'vscode-uri'

import {Program} from './Program'
import {File} from './File'
import * as util from './utils'

var fs = require 'fs'
var ts = require 'typescript'
var imbac = require 'imba/dist/compiler.js'

var tsServiceOptions = {
	allowJs: true,
	checkJs: false,
	# declaration: true,
	# emitDeclarationOnly: true,
	noEmit: true,
	# declarationMap: true,
	# inlineSourceMap: true,
	allowNonTsExtensions: true,
	allowUnreachableCode: true,
	target: ts.ScriptTarget.Latest,
	lib: ['lib.es6.d.ts'],
	moduleResolution: ts.ModuleResolutionKind.NodeJs
}

export class LanguageServer
	
	def constructor connection, documents, {rootUri}
		
		@files = {}
		@documents = documents
		@connection = connection
		@rootUri = util.uriToPath(rootUri)
		@rootFiles = [@rootUri + '/main.js']

		console.log 'start for',@rootUri

		# create the host
		var servicesHost = {
			getScriptFileNames: do
				return @rootFiles

			getScriptVersion: do |fileName|
				console.log "getScriptVersion",fileName
				return @files[fileName] ? @files[fileName].version.toString() : "0"

			getScriptSnapshot: do |fileName|
				return undefined if !@fileExists(fileName)
				return ts.ScriptSnapshot.fromString(@readFile(fileName).toString())
			
			getCurrentDirectory: do ''
			getCompilationSettings: do tsServiceOptions
			getDefaultLibFileName: do |options| ts.getDefaultLibFilePath(options)
			fileExists: @fileExists.bind(self)
			readFile: @readFile.bind(self)
			readDirectory: ts.sys.readDirectory
		}

		# create the ts language service that we pipe things through
		@service = ts.createLanguageService(servicesHost, ts.createDocumentRegistry())

		for file in @rootFiles
			@emitFile(file)

		self

	def log ...params
		# @connection.console.log(...params)
		console.log(...params)

	def sourceFileExists(fileName)
		if @files[fileName]
			return true

		var alt = fileName.replace(/\.js$/, '.imba')
		# intercepting when typescript tries to access a js file that has
		# a corresponding imba files

		if alt != fileName && ts.sys.fileExists(alt)
			@files[fileName] ||= File.new(self,alt)
			@files[alt] ||= @files[fileName]
			# @rootFiles.push(fileName) unless @rootFiles.indexOf(fileName) >= 0
			return true
		return false

	def fileExists(fileName) 
		console.log("fileExists {fileName}")
		@sourceFileExists(fileName) || ts.sys.fileExists(fileName)

	def readFile(fileName)
		@log("readFile {fileName}")
		var source = @files[fileName]

		if source
			source.compile()
			return source.js

		return ts.sys.readFile(fileName)

	def emitFile(fileName)
		if fileName.match(/\.imba$/)
			fileName = fileName.replace(/\.imba$/,'.js')

		console.log("emitFile " + fileName)

		var output = @service.getEmitOutput(fileName)

	# methods for vscode
	def onDidOpen event
		let doc = event.document
		let uri = util.uriToPath(event.document.uri)
		@log 'event document',uri
		# @emitFile(uri)
		self

	def onDidChangeContent event
		@log "server.onDidChangeContent"
		let doc = event.document
		if let file = @getImbaFile(event.document)
			file.didChange(doc)


	def rewriteDefinitions items
		for item,i in items
			let ifile = @files[item.fileName]
			if ifile
				ifile.originalDocumentSpanFor(item)
				items[i] = Location.create(ifile.uri,item.textSpan.range)
		return items

	def getImbaFile file
		let doc = @documents.get(file.uri or file)
		let src = util.uriToPath(file.uri or file).replace('.imba','.js')
		return @files[src] ||= File.new(self,src)

	def onDefinition event
		let doc = @documents.get(event.textDocument.uri)
		let loc = doc.offsetAt(event.position)
		
		let src = @files[util.uriToPath(doc.uri)]
		@log "server.onDefinition",doc,loc,!!src,util.uriToPath(doc.uri),@documents.keys()
		if src
			let definitions = src.getDefinitionAtPosition(loc)
			console.log definitions
			return definitions

	def getDefinitionAtPosition uri, pos
		let file = @getImbaFile(uri)
		let loc = @documents.get(uri).offsetAt(pos)
		if let info = file.getDefinitionAtPosition(loc)
			return info

	def getCompletionsAtPosition uri, pos, context
		let file = @getImbaFile(uri)
		let loc = @documents.get(uri).offsetAt(pos)
		let loc2 = file.generatedLocFor(loc)
		let options = {
			triggerCharacter: context.triggerCharacter
		}
		let res = @service.getCompletionsAtPosition(file.jsPath,loc2,options)
		console.log 'complete',uri,loc,loc2,!!res
		if res
			let entryFor = do |entry|
				{
					uri: uri,
					position: pos,
					label: entry.name,
					kind: util.convertCompletionKind(entry.kind,entry),
					sortText: entry.sortText
					data: {
						origKind: entry.kind
					}
				}
			let out = {
				isIncomplete: false,
				items: res.entries.map(entryFor)
			}
			return out
		return null

	def getQuickInfoAtPosition uri, pos
		# force the js imba file for conversion\
		# let path = util.uriToPath(file.url or file).replace('.imba','.js')
		# console.log "get quick info at pos {path}"
		
		let file = @getImbaFile(uri)
		let loc = @documents.get(uri).offsetAt(pos)
		let loc2 = file.generatedLocFor(loc)
		# console.log pos2
		if let info = file.getQuickInfoAtPosition(loc)
			console.log info
			let contents = ts.displayPartsToString(info.displayParts)
			return {
				range: file.textSpanToRange(info.textSpan)
				contents: 
					value: contents
					language: 'typescript'
			}

		# console.log 'quick info',res,file,pos

		###
		let info = jsLanguageService.getQuickInfoAtPosition(FILE_NAME, currentTextDocument.offsetAt(position));
			if (info) {
				let contents = ts.displayPartsToString(info.displayParts);
				return {
					range: convertRange(currentTextDocument, info.textSpan),
					contents: MarkedString.fromPlainText(contents)
				};
			}
			return null;
		###


