import {Component} from './Component'
import {TAG_NAMES,TAG_TYPES,EVENT_MODIFIERS} from './constants'
import {CompletionItemKind,SymbolKind,InsertTextFormat,CompletionItem} from 'vscode-languageserver-types'
import {convertCompletionKind,matchFuzzyString} from './utils'

import {tags,globalAttributes} from './html-data.json'
import {snippets} from './snippets'
import {keywords} from './keywords'

var globalEvents = for item in globalAttributes when item.name.match(/^on\w+/)
	item

for tagItem in tags
	tags[tagItem.name] = tagItem

export class Entities < Component

	def constructor program
		super
		@program = program
		@symbols = {}
		$cache = {}

	# cache based on project version
	def getWorkspaceSymbols query
		# only recollect if program has updated
		let files = @program.files
		let symbols = []
		for file in files
			for symbol in file.symbols
				if !query or matchFuzzyString(query,symbol.name)
					symbols.push(symbol)
		return symbols
		
	def getKeywordCompletions o = {}
		let keywords = ['yes','no','tag']
		
		let items\CompletionItem[] = []
		
		for kw in keywords
			items.push
				label: kw
				kind: CompletionItemKind.Keyword
				data: { resolved: true }

		return items
		
	def getSnippetsForContext o = {}
		let matches = []
		let scope = o.scope
		for snippet in snippets
			continue unless snippet.scopes.length == 0 or snippet.scopes.some(do |key| scope[key])
			continue if snippet.excludes.length and snippet.excludes.some(do |key| scope[key])

			matches.push({
				label: snippet.name	
				insertText: snippet.body
				insertTextFormat: InsertTextFormat.Snippet
				kind: CompletionItemKind.Snippet
				sortText: snippet.name
				data: { resolved: true }
			})

		return matches

		# completion.insertText = name + '($1)$0'
		# completion.insertTextFormat = InsertTextFormat.Snippet
	
	def getTagNameCompletions o = {}

		let items\CompletionItem[] = []
		for own name,ctor of TAG_NAMES
			items.push {
				label: name.replace('_',':'),
				kind: CompletionItemKind.Field,
				sortText: name
				data: { resolved: true }
			}
		
		let components = @program.getWorkspaceSymbols(type: 'tag')
		# $cache.components = for item in @getWorkspaceSymbols()
		# 	console.log 'workspace item',item
		# 	continue unless item.type == 'tag'
		# 	item
		
		for item in components # $cache.components
			items.push {
				label: item.name
				kind: CompletionItemKind.Field,
				sortText: item.name
				data: {resolved: true}
			}

		for item in items
			if o.autoclose
				item.insertText = item.label + '$0>'
				item.insertTextFormat = InsertTextFormat.Snippet

		return items
		
	def rewriteTSCompletions items
		self

	def getCompletionsForContext uri,pos,ctx
		let items\CompletionItem[] = []
		let entry\CompletionItem

		let mode =  ctx.stack[0]
		if mode == 'tag'
			items = @getTagNameCompletions()

		elif mode == 'event'
			for item in globalEvents
				entry =
					label: ':' + item.name.slice(2)
					sortText: item.name.slice(2)
					kind: CompletionItemKind.Field
				items.push(entry)

		elif mode == 'modifier'
			for item in EVENT_MODIFIERS
				items.push({
					label: item.name,
					kinds: CompletionItemKind.Enum,
					detail: item.description or ''
				})

		elif mode == 'attr'
			for item in globalAttributes
				let desc = item.description
				if item.name.match(/^on\w+/)
					continue
					entry = {
						label: ':' + item.name.slice(2)
						sortText: item.name.slice(2)
						kind: CompletionItemKind.Field
					}
				else
					entry = {label: item.name}

				if desc
					entry.detail = desc.value

				items.push(entry)

			if let tagSchema = tags[ctx.tagName]
				for item in tagSchema.attributes
					items.push(label: item.name)

		for item in items
			item.kind ||= CompletionItemKind.Field
			item.data ||= { resolved: true }

			if typeof item.kind == 'string'
				item.kind = convertCompletionKind(item.kind)

			if item.label[0] == ':'
				item.kind = CompletionItemKind.Function
				item.sortText = item.label.slice(1)

			if mode == 'event' and item.label[0] == ':'
				item.insertText = item.label.slice(1)
				item.commitCharacters = ['.']

		return items
		
	def normalizeCompletions items, ctx
		let results = for item in items
			item.sortText ||= '0'
			let meta = item.data ||= {resolved: true}
			# sort our own declarations at the top?
			if meta.origKind == 'property' and !meta.declare and item.label != 'prototype'
				# console.log 'resulrt item',item
				item.sortText = '_' + item.label
			
			# item.sortText = item.label
			item
		
		# results = results.sort do |a,b|
		# 	# a.sortText.localeCompare(b.sortText)
		# 	b.label.localeCompare(a.label)

		return results


	def registerTag
		[]

	def propertiesForTag name
		[]