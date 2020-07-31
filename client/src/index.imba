var path = require 'path'

import {window, languages, IndentAction, workspace,SnippetString, SemanticTokensLegend, SemanticTokens} from 'vscode'
import {LanguageClient, TransportKind} from 'vscode-languageclient'

import {SemanticTokenTypes,SemanticTokenModifiers} from 'imba/program'

let debugChannel = window.createOutputChannel("Imba Debug")

def log msg,...rest
	debugChannel.appendLine(msg)
	if rest.length
		debugChannel.appendLine(JSON.stringify(rest))

# TODO(scanf): handle workspace folder and multiple client connections

let client = null
let isReady = no

languages.setLanguageConfiguration('imba',{
	wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/g,
	onEnterRules: [{
		beforeText: /^\s*(?:export def|def|(export (default )?)?(static )?(def|get|set)|(export (default )?)?(class|tag)|for\s|if\s|elif|else|while\s|try|with|finally|except).*?$/,
		action: { indentAction: IndentAction.Indent }
	},{
		beforeText: /\s*(?:do)\s*(\|.*\|\s*)?$/,
		action: { indentAction: IndentAction.Indent }
	},{
		beforeText: /\s*(?:do)\(.*\)\s*$/,
		action: { indentAction: IndentAction.Indent }
	}]
})


class SemanticTokensProvider
	def provideDocumentSemanticTokens(doc, token)
		await true
		let uri = doc.uri.toString!
		unless isReady
			await client.onReady!
		# log("provide tokens!! {uri} {isReady}")
		let t = Date.now!
		let response = await client.sendRequest('semanticTokens',{uri: uri})
		log("semanticTokens {uri} request? {response.length} - {Date.now! - t}ms")

		if response
			let out = new SemanticTokens(response)
			return out
		return []

export def activate context
	var serverModule = context.asAbsolutePath(path.join('server', 'index.js'))
	var debugOptions = { execArgv: ['--nolazy', '--inspect=6005'] }
	
	log("activating!")
	# console.log serverModule, debugOptions # , debugServerModule
	
	var serverOptions = {
		run: {module: serverModule, transport: TransportKind.ipc }
		debug: {module: serverModule, transport: TransportKind.ipc, options: debugOptions }
	}
	
	var clientOptions = {
		documentSelector: [{scheme: 'file', language: 'imba'}]
		synchronize: { configurationSection: ['imba'] }
		revealOutputChannelOn: 0
		outputChannelName: 'Imba Language Client'
		initializationOptions: {
			something: 1
			other: 100
		}
	}
	
	client = new LanguageClient('imba', 'Imba Language Server', serverOptions, clientOptions)
	let semanticLegend = new SemanticTokensLegend(SemanticTokenTypes,SemanticTokenModifiers)
	let semanticProvider = languages.registerDocumentSemanticTokensProvider({language: 'imba'},new SemanticTokensProvider,semanticLegend)

	# let disposable = client.start()
	# context.subscriptions.push(client.start!)
	client.start!
	await client.onReady!
	isReady = yes

	window.onDidChangeTextEditorSelection do(e)
		log 'onDidChangeTextEditorSelection',e.kind,e.selections

	workspace.onDidRenameFiles do |ev|
		client.sendNotification('onDidRenameFiles',ev)

	client.onNotification('closeAngleBracket') do |params|
		let editor = window.activeTextEditor

		try
			let str = new SnippetString('$0>')
			editor.insertSnippet(str,null,{undoStopBefore: false,undoStopAfter: true})
		catch e
			console.log "error",e


export def deactivate
	if client
		client.stop!
		client = null
	return undefined