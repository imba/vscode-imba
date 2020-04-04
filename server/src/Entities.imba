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

class TagQuery
	def constructor program, tagName
		# ought to go all the way up to <element>?
		program = program
		types = program.entities.getTagTypesForNamePattern(tagName)
		let regex = RegExp.new("^({types.map(do $1.name).join('|')}|element|htmlelement)(\\.|$)")
		symbols = program.getWorkspaceSymbols(query: regex)
		self

	def filter cb
		symbols.filter(cb)
		

export class Entities < Component

	def constructor program
		super
		program = program
		symbols = {}
		$cache = {}

	def getTagQuery name
		TagQuery.new(program,name)

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

	def getTagTypesForNamePattern name
		let types = []
		let query = RegExp.new("^{name.replace(/\*/g,'[\\w\\-]+')}$")
		if name.indexOf('*') >= 0
			let matches = program.getWorkspaceSymbols(type: 'tag',query: query)
			for match in matches
				for item in getTagTypesForNamePattern(match.name)
					types.push(item) unless types.indexOf(item) >= 0
		else
			let type = program.getWorkspaceSymbol(name)
			types.push(type) if type
			while type && type.superclass
				type = program.getWorkspaceSymbol(type.superclass)
				types.push(type) if type

		return types

	def getTagTypeInfo name
		let res = tags[name]
		unless res
			let query = RegExp.new("^{name.replace(/\*/g,'[\\w\\-]+')}$")

			let components = program.getWorkspaceSymbols(type: 'tag',query: query)
			return components.map do |item|
				{
					name: item.name
					description: {kind: 'markdown', value: 'custom element'}
					location: item.location
				}
		return [res]

	def getTagAttrInfo attrName, tagName
		let schema

		let symbols = getTagQuery(tagName).filter do
			!$1.static and $1.ownName == attrName

		let match = symbols[0]
		# while !match and symbol = program.getWorkspaceSymbol(tagName)
		#	match = program.getWorkspaceSymbol(symbol.name + '.' + attrName)
		#	tagName = symbol.superclass

		match || tags[tagName] and tags[tagName].attributes.find do $1.name == attrName
		match ||= globalAttributes.find do $1.name == attrName

		if match
			return match

	
	def getTagEventInfo eventName, tagName
		getTagAttrInfo "on{eventName}",tagName

	def getTagSymbols tagName, options = {}
		let items = []
		let tagtype

		while tagtype = program.getWorkspaceSymbol(tagName)
			let symbols = program.getWorkspaceSymbols(prefix: tagtype.name+'.',type: options.type, query: options.query)
			for sym in symbols
				items.push(sym)
			tagName = tagtype.superclass
		return items

	def getTagAttrCompletions context
		let el = context.scope..closest('element') || {}
		let items\CompletionItem[] = []
		let mapping = {}

		for item in globalAttributes
			let desc = item.description
			continue if item.name.match(/^on\w+/)
			
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
			let symbols = getTagQuery(el.name).symbols.filter do $1.type == 'prop' or $1.type == 'set'
			# let symbols = getTagSymbols(el.name,type: 'prop')
			for sym in symbols
				items.push(
					label: sym.ownName
					kind: CompletionItemKind.Enum
					detail: "(property) {sym.name}"
					# documentation: item.description
				)
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

	def getTagEventModifierCompletions context
		var items = []
		for item in EVENT_MODIFIERS
			items.push({
				label: item.name,
				kind: CompletionItemKind.Enum,
				data: {resolved: yes}
				detail: item.description
			})
		
		if context.tagScope
			let symbols = getTagSymbols(context.tagScope.name,type: 'def')
			for sym in symbols
				continue if sym.ownName.match(/^(unmount|mount|render|setup)/)
				continue if sym.static

				items.push(
					label: sym.ownName
					kind: CompletionItemKind.Method
					detail: "(method) {sym.name}"
					data: {resolved: yes, location: sym.location}
				)

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

		let components = program.getWorkspaceSymbols(type: 'tag')
		
		for item in components # $cache.components
			items.push {
				label: item.name
				kind: CompletionItemKind.Field,
				sortText: item.name
				data: {resolved: true}
			}

		unless o.mode == 'supertag'
			items.push {
				label: 'self'
				kind: CompletionItemKind.Field,
				sortText: 'self'
				data: {resolved: true}
			}

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