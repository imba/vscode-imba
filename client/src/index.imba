let path = require 'path'

import {window, commands, languages, IndentAction, workspace,SnippetString, SemanticTokensLegend, SemanticTokens,Range} from 'vscode'
import {LanguageClient, TransportKind} from 'vscode-languageclient'

import {SemanticTokenTypes,SemanticTokenModifiers} from 'imba/program'

let debugChannel = null # window.createOutputChannel("Imba Debug")

def log msg,...rest
	if debugChannel
		debugChannel.appendLine(msg)
		if rest.length
			debugChannel.appendLine(JSON.stringify(rest))

# TODO(scanf): handle workspace folder and multiple client connections

let client = null
let isReady = no

languages.setLanguageConfiguration('imba',{
	wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)|(#+[\w\-]+)/g,
	onEnterRules: [{
		beforeText: /^\s*(?:export def|def|(export (default )?)?(static )?(def|get|set)|(export (default )?)?(class|tag)|for\s|if\s|elif|else|while\s|try|with|finally|except).*?$/,
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


class SemanticTokensProvider
	def provideDocumentSemanticTokens(doc, token)
		# await true
		let uri = doc.uri.toString!
		unless isReady
			await client.onReady!
		
		let t = Date.now!
		let response = await client.sendRequest('semanticTokens',{uri: uri})
		log("semanticTokens {uri} request? {response.length} - {Date.now! - t}ms")

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

		
export def activate context
	let serverModule = context.asAbsolutePath(path.join('server','dist','src','index.loader.js'))
	let debugOptions = { execArgv: ['--nolazy', '--inspect=6005'] }
	
	log("activating!")
	# console.log serverModule, debugOptions # , debugServerModule
	
	let serverOptions = {
		run: {module: serverModule, transport: TransportKind.ipc }
		debug: {module: serverModule, transport: TransportKind.ipc, options: debugOptions }
	}
	
	let clientOptions = {
		documentSelector: [
			{scheme: 'file', language: 'imba'},
			{scheme: 'file', language: 'imba1'}
		]
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
	let provider = new SemanticTokensProvider
	languages.registerDocumentSemanticTokensProvider({language: 'imba'},provider,semanticLegend)
	languages.registerDocumentSemanticTokensProvider({language: 'imba1'},new SemanticTokensProvider,semanticLegend)

	commands.registerCommand('imba.getProgramDiagnostics') do
		# window.showInformationMessage('Checking program...')
		client.sendNotification('getProgramDiagnostics')

	commands.registerCommand('imba.clearProgramProblems') do
		client.sendNotification('clearProgramProblems')

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
	await client.onReady!
	isReady = yes

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

	client.onNotification('closeAngleBracket') do(params)
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