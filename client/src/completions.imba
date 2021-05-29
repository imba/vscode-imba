import * as util from './util'

import { CompletionItem, Range, TextEdit } from 'vscode'

class ImbaCompletionItem < CompletionItem
	
	constructor raw
		super(raw.label.name)
		#raw = raw
		Object.assign(self,raw)
		# self.textEdit = raw.textEdit
		# self.triggerCharacters = raw.triggerCharacters

export default class CompletionsProvider
	constructor bridge
		#bridge = bridge


	def provideCompletionItems(doc, pos, token, context)
		let file = util.toPath(doc)
		util.log("provideCompletionItems!! {doc} {doc.fsPath} {doc.offsetAt(pos)} {file}")
		let res = await #bridge.call('getCompletions',file,doc.offsetAt(pos),context)
		# res.then do util.log("returned from getCompletions {JSON.stringify($1)}")

		let items = []
		
		for raw in res
			if let te = raw.textEdit
				let range = new Range doc.positionAt(te.start),doc.positionAt(te.start + te.length)
				raw.textEdit = TextEdit.replace(range,te.newText)
				
			elif raw.insertText == undefined
				raw.insertText = raw.label.name
				
			let item = new ImbaCompletionItem(raw)

			# if let te = raw.textEdit
			#	te.range = new Range(doc.positionAt(te.start),doc.positionAt(te.start + te.length))
			#	util.log("creste range!! {JSON.stringify(te)}")
			items.push(item)
		return items
	
	def resolveCompletionItem item, token
		util.log("resolving item {JSON.stringify(item)}")
		return item