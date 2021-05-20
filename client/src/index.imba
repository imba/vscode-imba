let path = require 'path'

import { CompletionItemKind,window, commands, languages, IndentAction, workspace,SnippetString, SemanticTokensLegend, SemanticTokens,Range, extensions} from 'vscode'
import {LanguageClient, TransportKind} from 'vscode-languageclient'

import {SemanticTokenTypes,SemanticTokenModifiers} from 'imba/program'
import ipc from 'node-ipc'

let debugChannel = null # window.createOutputChannel("Imba Debug")

def log msg,...rest
	if debugChannel
		debugChannel.appendLine(msg)
		if rest.length
			debugChannel.appendLine(JSON.stringify(rest))

let initialStamp = Date.now!
	
def stamp
	(Date.now! - initialStamp) + 'ms'

# TODO(scanf): handle workspace folder and multiple client connections
const HAS_TSPLUGIN = no

let client\LanguageClient = null
let isReady = no

languages.setLanguageConfiguration('imba',{
	wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)|(#+[\w\-]+)/g,
	onEnterRules: [{
		beforeText: /^\s*(?:export def|constructor|def|(export (default )?)?(static )?(def|get|set)|(export (default )?)?(class|tag)|for\s|if\s|elif|else|while\s|try|with|finally|except).*?$/,
		action: { indentAction: IndentAction.Indent }
	},{
		beforeText: /\s*(?:do)\s*(\|.*\|\s*)?$/,
		action: { indentAction: IndentAction.Indent }
	},{
		beforeText: /^\s*(css)\b.*$/,
		action: { indentAction: IndentAction.Indent }
	},{
		beforeText: /\s*(?:do)\(.*\)\s*$/,
		action: { indentAction: IndentAction.Indent }
	}]
})


const foldingToggles = {}
const receivedSemanticTokens = {}



class SemanticTokensProvider
	def provideDocumentSemanticTokens(doc, token)
		# await true
		let uri = doc.uri.toString!
		
		
		let t = Date.now!
		let last = receivedSemanticTokens[uri]
		let response = null
		
		log("provideDocumentSemanticTokens {uri} {doc.version} {stamp!}")
		if last
			log("found existing tokens {last.version} {doc.version} {stamp!}")
		
		

		if last and last.version == doc.version			
			response = last.tokens
		else
			unless isReady
				await client.onReady!
			response = await client.sendRequest('semanticTokens',{uri: uri})
		log("semanticTokens {uri} {doc.version} request? {response.length} - {Date.now! - t}ms {stamp!}")

		if response
			let out = new SemanticTokens(response)
			return out
		return []

def adjustmentCommand amount = 1
	return do(editor,edit)
		# log("increment!!! {JSON.stringify(editor.selection)} {editor.document.uri}")
		let doc = editor.document
		let edits = await client.sendRequest('increment',{
			by: amount
			selections: editor.selections
			uri: doc.uri.toString!
		})

		if edits
			let start = doc.positionAt(edits[0])
			let end = doc.positionAt(edits[0] + edits[1])
			let range = new Range(start,end)

			editor.edit do(edit)
				edit.replace(range,edits[2])

def getStyleBlockLines doc
	let count = doc.lineCount
	let i = 0
	let lines = []
	while i < count
		let line = doc.lineAt(i)
		let m = line.text.match(/^(\t*)(global )?css\b/)
		if m
			let k = i
			let res = undefined
			while res === undefined and k < count
				let next = doc.lineAt(++k)
				let m2 = next.text.match(/^([\t\s]*)(?=[^\#]|\#\w)/)
				if m2 
					let diff = m2[1].length - m[1].length
					if diff > 0
						lines.push(i)
						res = yes
					else
						res = no
				# need to figure out whether the css part stretches multiple lines
				lines.push(i) if res == yes
		i++
	log 'getStyleBlockLines',lines
	return lines
	
def configure items = {}
	let cfg = workspace.getConfiguration(undefined,null)
	for own k,v of items
		cfg.update(k,v)

let ipcserver = null

		
export def activate context
	let serverModule = context.asAbsolutePath(path.join('server','dist','src','index.loader.js'))
	let debugOptions = { execArgv: ['--nolazy', '--inspect=6005'] }
	let conf = workspace.getConfiguration('imba')
	
	log("activating!")
	
	if HAS_TSPLUGIN
		let id = String(Math.random!)
		const tsExtension = extensions.getExtension('vscode.typescript-language-features')
		try
			let subs = context.subscriptions
			let subs2 = context.subscriptions = {}
			
			subs2.push = do(item)
				log("push disposable!!")
				subs.push(item)
				
			const tsapi2 = await tsExtension.activate(context)
			context.subscriptions = subs
			
			ipc.config.id = process.env['IMBA_VSCODE_CLIENT'] = id
			ipc.serve do(e)
				log('serving!!')
				ipc.server.on('message') do(e)
					log 'message from ipc!!'
					log e
			ipc.server.start!
		
		try
			await commands.executeCommand("typescript.restartTsServer")

		const tsapi = try tsExtension.exports.getAPI(0)
	
	let serverOptions = {
		run: {module: serverModule, transport: TransportKind.ipc }
		debug: {module: serverModule, transport: TransportKind.ipc, options: debugOptions }
	}
	
	

	workspace.getConfiguration(undefined,null)
	
	let clientOptions = {
		documentSelector: [
			{scheme: 'file', language: 'imba'},
			{scheme: 'file', language: 'imba1'}
		]
		synchronize: { configurationSection: ['imba'] }
		revealOutputChannelOn: 0
		outputChannelName: 'Imba Language Client'
		initializationOptions: {}
		middleware: {
			provideOnTypeFormattingEdits: do
				log("provideOnTypeFormattingEdits",$0)
				
			provideCompletionItem: do(document, position, context, token, next)
				let t = Date.now!
				let res = await next(document, position, context, token)
				log "provideCompletionItem {Date.now! - t}ms"
				return res
		}
	}

	
	if conf.get('debug')
		serverOptions.run.options = debugOptions
		clientOptions.revealOutputChannelOn = 4 # never
		delete clientOptions.outputChannelName
	
	client = new LanguageClient('imba', 'Imba Language Server', serverOptions, clientOptions)
	
	let semanticLegend = new SemanticTokensLegend(SemanticTokenTypes,SemanticTokenModifiers)
	languages.registerDocumentSemanticTokensProvider({language: 'imba'},new SemanticTokensProvider,semanticLegend)
	languages.registerDocumentSemanticTokensProvider({language: 'imba1'},new SemanticTokensProvider,semanticLegend)

	commands.registerCommand('imba.getProgramDiagnostics') do
		# window.showInformationMessage('Checking program...')
		client.sendNotification('getProgramDiagnostics')

	commands.registerCommand('imba.clearProgramProblems') do
		client.sendNotification('clearProgramProblems')

	commands.registerCommand('imba.debugService') do
		configure("imba.verbose": false)
		# client.sendNotification('debugService')
		
	commands.registerCommand('imba.setDefaultSettings') do
		let settings = {
			"[imba].editor.insertSpaces": false,
			"[imba].editor.tabSize": 4,
			"[imba].editor.autoIndent": "advanced",
			"files.eol": "\n"
		}
		configure(settings)

	commands.registerTextEditorCommand('ximba.incrementByOne',adjustmentCommand(1))
	commands.registerTextEditorCommand('ximba.decrementByOne',adjustmentCommand(-1))

	commands.registerTextEditorCommand('imba.foldStyles') do(editor,edit)
		let key = editor.document.uri.toString!
		let lines = getStyleBlockLines(editor.document)
		foldingToggles[key] = yes
		await commands.executeCommand("editor.fold", {selectionLines: lines, direction: 'up'})

	commands.registerTextEditorCommand('imba.unfoldStyles') do(editor,edit)
		let key = editor.document.uri.toString!
		let lines = getStyleBlockLines(editor.document)
		foldingToggles[key] =  no
		await commands.executeCommand("editor.unfold", {selectionLines: lines})

	commands.registerTextEditorCommand('imba.toggleStyles') do(editor,edit)
		let key = editor.document.uri.toString!
		let lines = getStyleBlockLines(editor.document)
		let bool = foldingToggles[key] or no
		foldingToggles[key] = !bool
		let cmd = bool ? 'unfold' : 'fold'
		log 'toggle folding',cmd,lines,bool
		await commands.executeCommand("editor.{cmd}", {selectionLines: lines, direction: 'up'})
	
	
	# let disposable = client.start()
	# context.subscriptions.push(client.start!)
	
	
	
	client.start!
	log("client.start! {stamp!}")

	await client.onReady!

	isReady = yes
	
	client.onNotification('pushSemanticTokens') do(params)
		log("got semantic tokens {params.uri} {params.version} {stamp!}")
		params.now = Date.now!
		receivedSemanticTokens[params.uri] = params
		
	log("client ready! {stamp!}")
	
	

	window.onDidChangeTextEditorSelection do(e)
		const doc = e.textEditor.document
		const uri = doc.uri
		# log 'onDidChangeTextEditorSelection',e.kind,e.selections
		let params = {
			kind: e.kind
			selections: e.selections
			uri: uri.toString!
		}
		client.sendNotification('onDidChangeTextEditorSelection',params)

	workspace.onDidRenameFiles do(ev)
		client.sendNotification('onDidRenameFiles',ev)

export def deactivate
	if client
		client.stop!
		client = null
	return undefined