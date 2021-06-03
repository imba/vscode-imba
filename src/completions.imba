import * as util from './util'

import { CompletionItem, Range, TextEdit, MarkdownString, SnippetString } from 'vscode'
import * as Converters from './converters'

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
	
	def formatDocumentation doc, item
		return unless doc
		let str = new MarkdownString('')
		
		if doc isa Array
			for item in doc
				if item.kind == 'text'
					str.appendText(item.text)
				elif item.kind == 'markdown'
					str.appendMarkdown(item.text)
				else
					str.appendText(item.text)
			return str			
	
	def syncItem doc, item, raw
		if let te = raw.additionalTextEdits
			for entry,i in te
				continue if entry isa TextEdit
				let range = new Range doc.positionAt(entry.start),doc.positionAt(entry.start + entry.length)
				te[i] = TextEdit.replace(range,entry.newText)
			
			item.additionalTextEdits = te
		item

	def provideCompletionItems(doc, pos, token, context)
		let file = util.toPath(doc)
		util.log("provideCompletionItems!! {doc} {doc.fsPath} {doc.offsetAt(pos)} {file}")
		let res = await #bridge.call('getCompletions',file,doc.offsetAt(pos),context)
		#doc = doc
		# res.then do util.log("returned from getCompletions {JSON.stringify($1)}")

		let items = []
		
		for raw in res
			if let te = raw.textEdit
				let range = new Range doc.positionAt(te.start),doc.positionAt(te.start + te.length)
				raw.textEdit = TextEdit.replace(range,te.newText)
				
			elif raw.insertText == undefined
				raw.insertText = raw.label.name
				
			if raw.insertSnippet
				raw.insertText = new SnippetString(raw.insertSnippet)
			
			# if raw.data
			# 	util.log("has data {JSON.stringify(raw.data)}")
			let item = new ImbaCompletionItem(raw)
			item.kind = Converters.convertKind(raw.kind)
			# item.#data = raw.data

			# if let te = raw.textEdit
			#	te.range = new Range(doc.positionAt(te.start),doc.positionAt(te.start + te.length))
			#	util.log("creste range!! {JSON.stringify(te)}")
			items.push(item)
		return items
	
	def resolveCompletionItem item, token
		
		let res = await #bridge.call('resolveCompletionItem',item,item.data)
		util.log("resolving item {JSON.stringify(item)} {JSON.stringify(item.#raw)} {JSON.stringify(item.data)} {JSON.stringify(res)}")
		item.documentation ||= formatDocumentation(res.documentation,item)
		item.detail ||= res.detail
		
		syncItem(#doc,item,res)
		# item.label.parameters = "hello there"
		# also add code actions if needed(!)
		return item