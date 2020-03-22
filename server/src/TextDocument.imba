import { TextDocument } from 'vscode-languageserver'
export class Document

	prop changes // List of recent changes to document
	prop scopes // List of all current scope-regions from latest
	prop doc\TextDocument

	/**
	@param {import("./LanguageServer").LanguageServer} program
	*/
	def constructor program, path
		self.program = program

	get tls
		self.program.tls
	
	get cssls
		self.program.cssls

	get ils
		self.program
	
	def positionAt offset
		doc.positionAt(offset)

	def offsetAt position
		doc.offsetAt(position)

	// Add incremental changes
	def update
		self