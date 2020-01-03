var path = require 'path'

import workspace, window, languages, IndentAction from 'vscode'
import LanguageClient, TransportKind, RevealOutputChannelOn from 'vscode-languageclient'

import WorkspaceHandler from './WorkspaceHandler'

let wsp = WorkspaceHandler.new(workspace)

export def activate context
	var serverModule = context.asAbsolutePath(path.join('server', 'index.js'))
	let outputChannel = window.createOutputChannel('imba-language-server')

	wsp.activate(outputChannel, serverModule)

	workspace.onDidOpenTextDocument do |doc|
		wsp.didOpenTextDocument(doc)
	workspace:textDocuments.forEach do |doc|
		wsp.didOpenTextDocument(doc)
	workspace.onDidChangeWorkspaceFolders do |event|
		wsp.purgeClient(event)

	# TODO: do we really need this subscription?
	# context:subscriptions.push(disposable)

	# set language configuration
	languages.setLanguageConfiguration('imba',{
		wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\$\-\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/g,
		onEnterRules: [{
			beforeText: /^\s*(?:var def|let def|const def|export def|def|export class|class|for|if|elif|else|while|try|with|finally|except|async).*?$/,
			action: { indentAction: IndentAction.Indent }
		},{
			beforeText: /\s*(?:do)\s*(\|.*\|\s*)?$/,
			action: { indentAction: IndentAction.Indent }
		}]
	})

export def deactivate
	let promises = wsp.stopAllClients()
	return Promise.all(promises).then()