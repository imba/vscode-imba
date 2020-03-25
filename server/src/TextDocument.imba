import { TextDocument,Position } from 'vscode-languageserver'
import { Component } from './Component'

export class Document < Component

	prop changes // List of recent changes to document
	prop scopes // List of all current scope-regions from latest
	prop doc\TextDocument

	/**
	@param {import("./LanguageServer").LanguageServer} program
	*/
	def constructor program, path
		super()
		self.version = 0
		self.program = program
		self.edits = []

	get tls
		self.program.tls
	
	get cssls
		self.program.cssls

	get ils
		self.program
	
	def positionAt offset
		let pos\Position = offset
		if typeof offset == 'number'
			pos = doc.positionAt(offset)
		return pos

	def offsetAt pos
		let offset\number = pos
		unless typeof offset == 'number'
			offset = doc.offsetAt(offset)
		return offset

	// Add incremental changes
	def update
		self

	def applyEdits edits
		self