import {createConnection, TextDocuments} from 'vscode-languageserver'
import { TextDocument } from 'vscode-languageserver-textdocument'
import {LanguageServer} from './LanguageServer'

var connection = process.argv.length <= 2 ? createConnection(process.stdin, process.stdout) : createConnection()

# Create a simple text document manager. The text document manager
# supports full document sync only
const documents = TextDocuments.new(TextDocument)
documents.listen(connection)

var server\LanguageServer

documents.onDidOpen do |event|
	server.onDidOpen(event) if server

documents.onDidChangeContent do |change|
	server.onDidChangeContent(change) if server
	return

documents.onDidSave do |event|
	server.onDidSave(event) if server

documents.listen(connection)

connection.onInitialize do |params|
	connection.console.log("[Server({process.pid}) {params.rootUri}] Started and initialize received")
	server = LanguageServer.new(connection,documents,params)

	return {
		capabilities: {
			textDocumentSync: documents.syncKind,
			completionProvider: {
				resolveProvider: true,
				triggerCharacters: ['.', ':', '<', '"', '/', '@', '*','%']
			},
			signatureHelpProvider: { triggerCharacters: ['('] },
			documentRangeFormattingProvider: false,
			hoverProvider: true,
			documentHighlightProvider: true,
			documentSymbolProvider: true,
			workspaceSymbolProvider: true,
			semanticTokensProvider: {
				legend: {
					tokenTypes: ['variable']
					tokenModifiers: ['declaration','static']
				}
				rangeProvider: false
				documentProvider: true
			},
			definitionProvider: true,
			referencesProvider: false
		}
	}

connection.onInitialized do |params|
	console.log 'on initialized'

	connection.onNotification('onDidRenameFiles') do |event|
		server.onDidRenameFiles(event)
		# console.log 'service.onDidRenameFiles',event
	connection.onNotification('onDidDeleteFiles') do |event|
		server.onDidDeleteFiles(event)

	connection.onNotification('onDidCreateFiles') do |event|
		server.onDidCreateFiles(event)

connection.onDidChangeConfiguration do |change|
	console.log "connection.onDidChangeConfiguration"

connection.onDocumentSymbol do |event|
	let uri = event.textDocument.uri
	if server
		return server.getSymbols(event.textDocument.uri)
	return []

connection.onWorkspaceSymbol do |event|
	return []


connection.onDefinition do |event,b|
	console.log 'onDefinition',event
	let res = server.getDefinitionAtPosition(event.textDocument.uri,event.position)
	return res

connection.onTypeDefinition do |event|
	return undefined

connection.onHover do |event|
	# console.log "onhover",event
	let res = server.getQuickInfoAtPosition(event.textDocument.uri,event.position)
	# console.log res
	return res


connection.onCompletion do |event|
	console.log "oncompletion",event
	let res = server.getCompletionsAtPosition(event.textDocument.uri,event.position,event.context)
	console.log res && res.items.slice(0,2)

	return res

connection.onCompletionResolve do |item|
	return server.doResolve(item)

connection.onDocumentHighlight do |event|
	console.log 'onDocumentHighlight',event
	return []

connection.listen()