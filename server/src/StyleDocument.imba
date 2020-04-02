import { TextDocument, Position, Range } from 'vscode-languageserver-types'
import { Document } from './TextDocument'
import * as utils from './utils'

export class StyleDocument < Document
	prop script
	prop content\String

	def constructor program,path,script
		super(program,path)
		script = script
		version = -1
		uri = script.uri.replace(/\.imba$/,'.css') # mac only
		refresh!

	def refresh
		if version < script.version
			version = script.version
			let body = utils.stripNonStyleBlocks(script.doc.getText!)
			if body != content
				doc = TextDocument.create(uri,'css',version,content = body)
				stylesheet = cssls.parseStylesheet(doc)
		self

	def getCompletionsAtOffset loc\number, options = {}
		refresh!
		let vals = cssls.doComplete(doc,positionAt(loc),stylesheet)
		for item in vals.items
			item.data = {resolved: true, context: 'css'}
		return vals.items

	def doHover loc
		refresh!
		let res = cssls.doHover(doc,positionAt(loc),stylesheet)
		return res