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
	}
	
	var client = LanguageClient.new('imba', 'Imba Language Server', serverOptions, clientOptions)
	var disposable = client.start()
	
	var styler = do |dark,light|
		return window.createTextEditorDecorationType({
			light: {color: '#509DB5'}
			dark: {
				color: dark.color or undefined
				border: "1px {dark.border or dark.color}40 solid",
				borderWidth: dark.border ? '0px 0px 1px 0px' : '0px'
			}
			borderRadius: '1px'
			rangeBehavior: 1
		})
	
	var colors =
		yellow: '#e8e6cb'
		pink: '#e8b8e5'
		indigo: '#BD9AC2'
		blue: '#a1bcd9'
		
	let styles =
		var: {color: colors.yellow}
		
	var semanticTypes =
		accessor: styler(color: colors.blue)
		imported:  styler(color: colors.indigo)
		var:       styler(styles.var)
		let:       styler(styles.var)
		param:     styler(styles.var)
		global:    styler(color: colors.indigo)

	context.subscriptions.push(disposable)

	
	client.onReady().then do

		workspace.onDidRenameFiles do |ev|
			# console.log 'workspace onDidRenameFiles',ev
			client.sendNotification('onDidRenameFiles',ev)
			
		client.onNotification('closeAngleBracket') do |params|
			let editor = window.activeTextEditor
			# console.log 'edit!!!',editor,params
			try
				false && editor.edit do |edits|
					let pos = Position.new(params.position.line,params.position.character)
					console.log 'editBuilder',edits,pos
					edits.insert(pos,'>')
				let str = SnippetString.new('$0>')
				editor.insertSnippet(str,null,{undoStopBefore: false,undoStopAfter: true})
			catch e
				console.log "error",e

		client.onNotification('entities') do |{uri,version,markers}|

			let editor = adapter.uriToEditor(uri,version)
			# console.log 'received entities',uri,version,markers,editor
			return unless editor
			
			var decorations = {}
			
			for mark in markers
				let [name,kind,loc,length,start,end] = mark				
				let range = {start: start, end: end}
				let group = (decorations[kind] ||= [])
				group.push(range: {start: start, end: end})
			# console.log 'decorations',decorations
			for own name,items of decorations
				if let type = semanticTypes[name]
					editor.setDecorations(type, items)
			return
			
	
		# languages.registerCompletionItemProvider('imba', {
		# 	def provideCompletionItems document, position, token
		# 		console.log('provideCompletionItems',token)
		# 		let editor = window.activeTextEditor
		# 		return
		# 		# return {items: []}
		# 		# return new Hover('I am a hover!')
		# })
	
	# set language configuration
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