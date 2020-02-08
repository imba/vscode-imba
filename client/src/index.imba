var path = require 'path'

import {window, languages, IndentAction, workspace,SnippetString,Position} from 'vscode'
import {LanguageClient, TransportKind, RevealOutputChannelOn} from 'vscode-languageclient'

# TODO(scanf): handle workspace folder and multiple client connections

class ClientAdapter
	
	def uriToEditor uri, version
		for editor in window.visibleTextEditors
			let doc = editor.document
			if doc && uri === doc.uri.toString()
				if version and doc.version != version
					continue
				return editor
		return null

var adapter = ClientAdapter.new

export def activate context
	var serverModule = context.asAbsolutePath(path.join('server', 'index.js'))
	var debugOptions = { execArgv: ['--nolazy', '--inspect=6005'] }
	
	console.log serverModule, debugOptions # , debugServerModule
	
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
	}
	
	var client = LanguageClient.new('imba', 'Imba Language Server', serverOptions, clientOptions)
	var disposable = client.start()
	
	var type = window.createTextEditorDecorationType({
		light: {color: '#509DB5'},
		dark: {color: '#dbdcb2'},
		rangeBehavior: 1
	})

	context.subscriptions.push(disposable)

	
	client.onReady().then do

		workspace.onDidRenameFiles do |ev|
			console.log 'workspace onDidRenameFiles',ev
			client.sendNotification('onDidRenameFiles',ev)
			
		client.onNotification('closeAngleBracket') do |params|
			let editor = window.activeTextEditor
			console.log 'edit!!!',editor,params
			try
				false && editor.edit do |edits|
					let pos = Position.new(params.position.line,params.position.character)
					console.log 'editBuilder',edits,pos
					edits.insert(pos,'>')
				let str = SnippetString.new('$0>')
				editor.insertSnippet(str,null,{undoStopBefore: false,undoStopAfter: true})
			catch e
				console.log "error",e

		client.onNotification('entities') do |uri,version,markers|
			let editor = adapter.uriToEditor(uri,version)
			
			return unless editor

			var styles = {
				RootScope: ["#d6bdce","#509DB5"]
				"import": ['#91b7ea','#91b7ea']
			}

			var decorations = for marker in markers
				let color = styles[marker.type] or styles[marker.scope]
				
				{
					range: marker.range
					hoverMessage: "variable {marker.name}"
					renderOptions: color ? {dark: {color: color[0]}, light: {color: color[1]}, rangeBehavior: 1} : null
				}
			
			editor.setDecorations(type, decorations)
	
		languages.registerCompletionItemProvider('imba', {
			def provideCompletionItems document, position, token
				console.log('provideCompletionItems',token)
				let editor = window.activeTextEditor
				return
				# return {items: []}
				# return new Hover('I am a hover!')
		})
	
	# set language configuration
	languages.setLanguageConfiguration('imba',{
		wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\$\-\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/g,
		onEnterRules: [{
			beforeText: /^\s*(?:export def|def|(export (default )?)?(static )?(def|get|set)|(export (default )?)?(class|tag)|for|if|elif|else|while|try|with|finally|except|async).*?$/,
			action: { indentAction: IndentAction.Indent }
		},{
			beforeText: /\s*(?:do)\s*(\|.*\|\s*)?$/,
			action: { indentAction: IndentAction.Indent }
		}]
	})