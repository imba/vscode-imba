# imba$selfless=1

var path = require 'path'

import {window, languages, IndentAction, workspace,SnippetString,Position,TextDocument,CancellationToken,DocumentSemanticTokensProvider,SemanticTokensLegend} from 'vscode'
import {LanguageClient, TransportKind, RevealOutputChannelOn} from 'vscode-languageclient'
import { SemanticTokensFeature, DocumentSemanticsTokensSignature } from 'vscode-languageclient/lib/semanticTokens.proposed'


import {SemanticTokenTypes,SemanticTokenModifiers} from '../../src/protocol'

const DecorationsCache = {}

# TODO(scanf): handle workspace folder and multiple client connections

class ClientAdapter

	def constructor
		var styler = do |dark,light|
			return window.createTextEditorDecorationType({
				light: {color: '#509DB5'}
				dark: {
					# color: dark.color or undefined
					
					# borderWidth: dark.border ? '0px 0px 1px 0px' : '0px'
					# border: "1px {dark.color}40 dashed",
					# borderWidth: '0px 0px 1px 0px'
					color: dark.color
				}
				borderRadius: '2px'
				rangeBehavior: 1
			})
	
		var colors = {
			yellow: '#e8e6cb'
			pink: '#e8b8e5'
			indigo: '#BD9AC2'
			purple: '#c5badc'
			blue: '#a1bcd9'
		}
			
		var styles = {
			root: {color: colors.purple}
			method: {color: colors.yellow, border: colors.yellow}
			flow:   {color: colors.yellow, border: colors.yellow}
			class:  {color: colors.blue, border: colors.blue}
		}
		# should fetch colors from supplied theme?

		self.semanticTypes = {
			# accessor: styler(color: colors.blue)
			global: styler(color: colors.indigo)
			root: styler(styles.root)
			class: styler(styles.class)
			tag: styler(styles.class)
			method: styler(styles.method)
			lambda: styler(styles.method)
			if: styler(styles.flow)
			for: styler(styles.flow)
		}
		
	def uriToEditor uri, version
		for editor in window.visibleTextEditors
			let doc = editor.document
			if doc && uri === doc.uri.toString()
				if version and doc.version != version
					continue
				return editor
		return null

	def decorateEditor uri, version, markers
		let editor = self.uriToEditor(uri,version)
		DecorationsCache[uri] = markers

		# console.log 'received entities',uri,version,markers,editor
		unless editor
			console.log 'could not find editor for entities',uri
			return
		
		var decorations = {}
		
		for mark in markers
			let [name,scope,kind,loc,length,start,end] = mark		
			let range = {start: start, end: end}
			# range.end.character = range.start.character + 1

			let group = (decorations[scope] ||= [])
			group.push(range: range)

		# console.log 'decorations',decorations
		for own name,items of decorations
			if let type = self.semanticTypes[name]
				editor.setDecorations(type, items)

		return

var adapter = ClientAdapter.new

languages.setLanguageConfiguration('imba',{
	wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\-\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/g,
	onEnterRules: [{
		beforeText: /^\s*(?:export def|def|(export (default )?)?(static )?(def|get|set)|(export (default )?)?(class|tag)|for|if|elif|else|while|try|with|finally|except|async).*?$/,
		action: { indentAction: IndentAction.Indent }
	},{
		beforeText: /\s*(?:do)\s*(\|.*\|\s*)?$/,
		action: { indentAction: IndentAction.Indent }
	}]
})


class SemanticTokensProvider
	def provideDocumentSemanticTokens(document\TextDocument, token\CancellationToken)
		console.log 'provide semantic tokens!',document
		await []
		return []

export def activate context
	var serverModule = context.asAbsolutePath(path.join('server', 'index.js'))
	var debugOptions = { execArgv: ['--nolazy', '--inspect=6005'] }
	
	# console.log serverModule, debugOptions # , debugServerModule
	
	var serverOptions = {
		run: {module: serverModule, transport: TransportKind.ipc, options: debugOptions }
		debug: {module: serverModule, transport: TransportKind.ipc, options: debugOptions }
	}
	
	var clientOptions = {
		documentSelector: [{scheme: 'file', language: 'imba'}]
		synchronize: { configurationSection: ['imba'] }
		revealOutputChannelOn: RevealOutputChannelOn.Info
		initializationOptions: {
			something: 1
			other: 100
		}
		/*
		middleware: {
			# Workaround for https://github.com/microsoft/vscode-languageserver-node/issues/576
			def provideDocumentSemanticTokens(document\TextDocument, token\CancellationToken, next\DocumentSemanticsTokensSignature) 
				let res = await next(document, token)
				if (res === undefined) then throw Error.new('busy')
				return res;
		}
		*/
	}
	
	var client = LanguageClient.new('imba', 'Imba Language Server', serverOptions, clientOptions)
	// let sematicLegend = SemanticTokensLegend.new(SemanticTokenTypes,SemanticTokenModifiers)
	// let semanticProvider = languages.registerDocumentSemanticTokensProvider({language: 'imba'},SemanticTokensProvider.new,sematicLegend)
	// client.registerFeature(SemanticTokensFeature.new(client))

	var disposable = client.start()

	context.subscriptions.push(disposable)
	
	await client.onReady!

	window.onDidChangeActiveTextEditor do |ev|
		console.log 'changed active editor!'

	window.onDidChangeVisibleTextEditors do |editors|
		console.log 'onDidChangeVisibleTextEditors',editors
		for editor in editors
			try
				let doc = editor.document
				let uri = doc.uri.toString!
				let version = doc.version
				console.log 'show decorations for?',uri
				if let markers = DecorationsCache[uri]
					adapter.decorateEditor(uri,version,markers)
				

	
	workspace.onDidRenameFiles do |ev|
		client.sendNotification('onDidRenameFiles',ev)

	client.onNotification('closeAngleBracket') do |params|
		let editor = window.activeTextEditor

		try
			let str = SnippetString.new('$0>')
			editor.insertSnippet(str,null,{undoStopBefore: false,undoStopAfter: true})
		catch e
			console.log "error",e

	client.onNotification('entities') do |{uri,version,markers}|
		console.log 'setting decorations for editor',uri
		DecorationsCache[uri] = markers
		# let editor = adapter.uriToEditor(uri,version)
		adapter.decorateEditor(uri,version,markers)