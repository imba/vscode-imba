import {createConnection, TextDocuments, Location,TextDocumentSyncKind} from 'vscode-languageserver'
import { TextDocument } from 'vscode-languageserver-textdocument'
import {LanguageServer} from './LanguageServer'

import {snippets} from './snippets'

var connection = process.argv.length <= 2 ? createConnection(process.stdin, process.stdout) : createConnection()

# Create a simple text document manager. The text document manager
# supports full document sync only
const documents = TextDocuments.new(TextDocument)
documents.listen(connection)

var server\LanguageServer

documents.onDidOpen do |event|
	server.onDidOpen(event) if server

documents.onDidChangeContent do |change|
	# console.log 'changed content',change.contentChanges
	server.onDidChangeContent(change) if server
	return

documents.onDidSave do |event|
	server.onDidSave(event) if server

documents.listen(connection)

connection.onInitialize do |params|
	// Could this start a single instance for multiple workspaces?
	# connection.console.log("[Server({process.pid}) {params.rootUri}] Started and initialize received")
	server = LanguageServer.new(connection,documents,params)

	return {
		capabilities: {
			textDocumentSync: TextDocumentSyncKind.Full
			completionProvider: {
				resolveProvider: true,
				triggerCharacters: ['.', ':', '<', '"', '/', '@', '*','%']
			},
			# signatureHelpProvider: { triggerCharacters: ['('] },
			signatureHelpProvider: false,
			documentRangeFormattingProvider: false,
			hoverProvider: true,
			documentHighlightProvider: true,
			documentSymbolProvider: true,
			workspaceSymbolProvider: true,
			renameProvider: true,
			semanticTokensProvider: {
				legend: {
					tokenTypes: ['variable']
					tokenModifiers: ['declaration','static']
				}
				rangeProvider: false
				documentProvider: true
			},
			definitionProvider: true,
			referencesProvider: true
		}
	}

connection.onInitialized do |params|
	# console.log 'on initialized'

	connection.onNotification('onDidRenameFiles') do |event|
		server.onDidRenameFiles(event)
		# console.log 'service.onDidRenameFiles',event
	connection.onNotification('onDidDeleteFiles') do |event|
		server.onDidDeleteFiles(event)

	connection.onNotification('onDidCreateFiles') do |event|
		server.onDidCreateFiles(event)
		
	# connection.onDidChangeTextDocument do |event|
	# 	console.log 'onDidChangeTextDocument',event

connection.onDidChangeConfiguration do |change|
	console.log "connection.onDidChangeConfiguration"

connection.onDocumentSymbol do |event|
	return server ? server.getSymbols(event.textDocument.uri) : []

connection.onWorkspaceSymbol do |event|
	return server ? server.getWorkspaceSymbols(event) : []


connection.onDefinition do |event|
	# console.log 'onDefinition',event
	let res\any[] = server.getDefinitionAtPosition(event.textDocument.uri,event.position)
	return res

connection.onReferences do(event)
	let res = server.onReferences(event)
	return res

connection.onTypeDefinition do |event|
	return undefined

connection.onRenameRequest do(event)
	if server
		return server.onRenameRequest(event)
	return

connection.onHover do |event|
	# console.log "onhover",event
	let res = server.getQuickInfoAtPosition(event.textDocument.uri,event.position)
	# console.log res
	return res


connection.onCompletion do |event|
	let res\any = server.getCompletionsAtPosition(event.textDocument.uri,event.position,event.context)
	if res isa Array
		res = {isIncomplete: false, items: res}
	# console.log res && res.items.slice(0,2)

	return res

connection.onCompletionResolve do |item|
	return server.doResolve(item)

connection.onDocumentHighlight do |event|
	# console.log 'onDocumentHighlight',event
	return []

connection.listen()