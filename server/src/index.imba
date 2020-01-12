import {createConnection, TextDocuments} from 'vscode-languageserver'
import {LanguageServer} from './LanguageServer'

var connection = process.argv.length <= 2 ? createConnection(process.stdin, process.stdout) : createConnection()

# Create a simple text document manager. The text document manager
# supports full document sync only
const documents = TextDocuments.new
documents.listen(connection)

var server

var workspaceFolder

documents.onDidOpen do |event|
	server.onDidOpen(event) if server

documents.onDidChangeContent do |change|
	server.onDidChangeContent(change) if server
	return

documents.onDidSave do |event|
	server.onDidSave(event) if server

documents.listen(connection)

connection.onInitialize do |params|
	workspaceFolder = params.rootUri
	connection.console.log("[Server({process.pid}) {workspaceFolder}] Started and initialize received")
	server = LanguageServer.new(connection,documents,params)

	return {
		capabilities: {
			textDocumentSync: documents.syncKind,
			completionProvider: {
				resolveProvider: true,
				triggerCharacters: ['.', ':', '<', '"', '/', '@', '*','%']
			},
			signatureHelpProvider: false, # { triggerCharacters: ['('] },
			documentRangeFormattingProvider: false,
			hoverProvider: true,
			documentHighlightProvider: true,
			documentSymbolProvider: true,
			workspaceSymbolProvider: true,
			definitionProvider: true,
			referencesProvider: false,
			selectionRangeProvider: false, # should use ts.getSmartSelectionRange and convert
		}
	}

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
	# onDefinition(handler: RequestHandler<TextDocumentPositionParams, Definition | DefinitionLink[] | undefined | null, void>): void;	

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
	# if res
	return res

connection.onCompletionResolve do |item|
	# console.log 'completion resolve',item
	# console.log 'completion resolve?'
	return server.doResolve(item)

connection.onDocumentHighlight do |event|
	console.log 'onDocumentHighlight',event
	return []

connection.listen()