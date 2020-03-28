import {Component} from './Component'
import {TAG_NAMES,TAG_TYPES,EVENT_MODIFIERS} from './constants'
import {CompletionItemKind,SymbolKind,InsertTextFormat,CompletionItem} from 'vscode-languageserver-types'
import {convertCompletionKind,matchFuzzyString} from './utils'

import {tags,globalAttributes} from './html-data.json'
import {snippets} from './snippets'
import {keywords} from './keywords'
import { items } from '../../test/data'

var globalEvents = for item in globalAttributes when item.name.match(/^on\w+/)
	item

for tagItem in tags
	tags[tagItem.name] = tagItem

export class Entities < Component

	def constructor program
		super
		program = program
		symbols = {}
		$cache = {}


	# cache based on project version
	def getWorkspaceSymbols query
		# only recollect if program has updated
		let files = program.files
		let symbols = []
		for file in files
			for symbol in file.symbols
				if !query or matchFuzzyString(query,symbol.name)
					symbols.push(symbol)
		return symbols

	def getTagTypeInfo name
		let res = tags[name]
		unless res
			let components = program.getWorkspaceSymbols(type: 'tag',query: name)
			return components.map do |item|
				{
					name: item.name
					description: {kind: 'markdown', value: 'custom element'}
					location: item.location
				}
		return [res]

	def getTagAttrInfo attrName, tagName
		let schema = tags[tagName]
		let match = schema and schema.attributes.find do $1.name == attrName
		match ||= globalAttributes.find do $1.name == attrName

		if match
			return match
	
	def getTagEventInfo eventName, tagName
		getTagAttrInfo "on{eventName}",tagName

	def getTagAttrCompletions context
		let el = context.scope..closest('element') || {}
		let items\CompletionItem[] = []

		for item in globalAttributes
			let desc = item.description
			if item.name.match(/^on\w+/)
				continue
				entry = {
					label: ':' + item.name.slice(2)
					sortText: item.name.slice(2)
					kind: CompletionItemKind.Enum
				}
			else
				entry = {
					label: item.name,
					kind: CompletionItemKind.Enum
				}

			if desc
				entry.documentation = desc

			items.push(entry)

		if let tagSchema = tags[el.name]
			for item in tagSchema.attributes
				items.push(
					label: item.name
					kind: CompletionItemKind.Enum
					documentation: item.description
				)
		elif el.name
			let tagtype = program.getWorkspaceSymbol(el.name)

			while tagtype
				let symbols = program.getWorkspaceSymbols(prefix: tagtype.name+'.',type: 'prop')
				console.log 'found symbols for tag',symbols,el.name,tagtype
				for sym in symbols
					items.push(
						label: sym.ownName
						kind: CompletionItemKind.Enum
						detail: "(property) {tagtype.name}"
						# documentation: item.description
					)
				tagtype = tagtype.superclass && program.getWorkspaceSymbol(tagtype.superclass)
		return items
		
	def getKeywordCompletions o = {}
		let keywords = ['yes','no','tag']
		
		let items\CompletionItem[] = []
		
		for kw in keywords
			items.push
				label: kw
				kind: CompletionItemKind.Keyword
				data: { resolved: true }

		return items

	def getTagEventCompletions o = {}
		var items = []
		for item in globalEvents
			items.push({
				label: item.name.slice(2)
				sortText: '0'
				kind: CompletionItemKind.EnumMember
				data: {resolved: yes}
				documentation: item.description
			})
		return items

	def getTagFlagCompletions o = {}
		var items = []
		# possibly add flags for tailwind etc
		return items

	def getTagEventModifierCompletions o = {}
		var items = []
		for item in EVENT_MODIFIERS
			items.push({
				label: item.name,
				kind: CompletionItemKind.Enum,
				data: {resolved: yes}
				detail: item.description
			})
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
		return results


	def registerTag
		[]

	def propertiesForTag name
		[]