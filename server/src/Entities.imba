import {Component} from './Component'
import {TAG_NAMES,TAG_TYPES,EVENT_MODIFIERS,keywords} from './constants'
import {CompletionItemKind,SymbolKind,InsertTextFormat,CompletionItem} from 'vscode-languageserver-types'
import {convertCompletionKind,matchFuzzyString} from './utils'

import {tags,globalAttributes} from './html-data.json'
import {snippets} from './snippets'
import { items } from '../../test/data'

import * as cssData from './css-data.json'

import {aliases as cssAliases,StyleTheme} from 'imba/src/compiler/styler'
import {modifiers as cssModifiers} from 'imba/src/compiler/theme'
import * as theme from 'imba/src/compiler/theme'

import * as svg from './StylePreviews'

var globalEvents = for item in globalAttributes when item.name.match(/^on\w+/)
	item

for tagItem in tags
	tags[tagItem.name] = tagItem


const cssProperties = {}

for entry in cssData.properties
	cssProperties[entry.name] = entry

for own k,v of cssAliases
	let defn = {name: k,custom: yes,expanded:v,alias:yes}
	unless v isa Array
		if let orig = cssProperties[v]
			defn = Object.assign(alias: yes,expanded: orig.name,orig)
			orig.abbr = k
	else
		let origs = v.map do cssProperties[$1]
		defn.expanded = origs.map(do $1.name).join(" & ")

	if defn
		cssProperties[k] = defn



class TagQuery
	def constructor program, tagName
		# ought to go all the way up to <element>?
		program = program
		types = program.entities.getTagTypesForNamePattern(tagName)
		let regex = new RegExp("^({types.map(do $1.name).join('|')}|element|htmlelement)(\\.|$)")
		symbols = program.getWorkspaceSymbols(query: regex)
		self

	def filter cb
		symbols.filter(cb)
		

export class Entities < Component

	def constructor program, config = {}
		super
		program = program
		symbols = {}
		$theme = new StyleTheme(config ? config.styles : {})
		$cache = {}
		$easings = {}
		$colors = {}
		$styles = {
			rd: {}
			fs: {}
			ff: {}
		}

		for own name,value of theme.variants.easings
			registerEasing(name,value)

		for own name,value of $theme.palette
			registerColor(name,value) unless name.match(/^grey\d/)

		for own name,value of theme.variants.radius
			continue if name != name.toLowerCase!

			let item = {
				name: name
				detail: value
				type: 'radius'
				documentation: "![]({svg.md('rd',value)}|width=120,height=120)"
			}

			$styles.rd[name] = item

		for own name,value of theme.variants.fontSize
			continue unless name.match(/[a-z]/)
			registerFontSize(name,value)
		
		for own name,value of theme.fonts
			registerFontFamily(name,value)
		self

	def registerFontSize name, value
		let item = {
			name: name
			detail: value isa Array ? value[0] : value
			type: 'font-size'
			
		}
		item.documentation = "![]({svg.md('fs',item.detail)}|width=120,height=120)"

		$styles.fs[name] = item
	
	def registerFontFamily name, value
		let item = {
			name: name
			detail: value
			type: 'font'
			
		}
		$styles.ff[name] = item

	
	def registerEasing name, value
		let info = {
			name: name
			type: 'easing'
		}

		info.documentation = """
			![]({svg.md('easing',value)}|width=120,height=120)
		"""
		$easings[name] = info

	def registerColor name, value
		let color = "hsla({parseInt(value.h)},{parseInt(value.s)}%,{parseInt(value.l)}%,{parseFloat(value.a) / 100})"
		let info = {
			name: name
			type: 'color'
			detail: color
		}

		if name == 'current'
			info.type = 'value'
			info.detail = "Inherited value of `color`"
		else
			info.documentation = """
				![]({svg.md('color',value)}|width=240,height=120)
			"""

		$colors[name] = info

	def getTagQuery name
		new TagQuery(program,name)

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
		let query = new RegExp("^{name.replace(/\*/g,'[\\w\\-]+')}$")
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
			let query = new RegExp("^{name.replace(/\*/g,'[\\w\\-]+')}$")

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

	def getTagAttrCompletions el, o = {}
		# let el = context.scope..closest('element') || {}
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

	def getCSSValueInfo value, property, o = {}
		
		let item

		if item = $easings[value]
			yes
		elif item = $colors[value]
			yes
		
		if item
			return {
				name: item.name
				description: {kind: 'markdown', value: item.documentation}
			}

		return null
		
	def getKeywordCompletions o = {}
		let keywords = ['yes','no','tag']
		
		let items\CompletionItem[] = []
		
		for kw in keywords
			items.push
				label: kw
				kind: CompletionItemKind.Keyword
				data: { resolved: true }

		return items

	def getTagEventCompletions ctx, o = {}
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

	def getTagFlagCompletions ctx, o = {}
		var items = []
		# possibly add flags for tailwind etc
		return items

	def getTagEventModifierCompletions ctx, o = {}
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
	
	def getTagNameCompletions ctx, o = {}

		let items\CompletionItem[] = []
		for own name,ctor of TAG_NAMES
			items.push {
				label: name.replace('_',':'),
				kind: CompletionItemKind.Field,
				sortText: name
				data: { resolved: true }
			}

		let components = program.getWorkspaceSymbols(type: 'tag')
		let included = {}
		
		for item in components # $cache.components
			continue if included[item.name]
			items.push included[item.name] = {
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

	def getCSSCompletions ctx, o
		let items\CompletionItem[] = []
		if o.css.property or o.css.body
			items.push(...getCSSPropertyCompletions(o))
			console.log 'add property completions'
		if o.css.value
			items.push(...getCSSValueCompletions(o))
		if o.css.modifier
			items.push(...getCSSModifierCompletions(o))

		return items

	def getCSSPropertyCompletions ctx, o = {}
		let items\CompletionItem[] = []
		for own k,v of cssProperties
			continue unless v
			let detail = ''
			if k != v.name
				detail = v.name

			let item = {
				label: k # v.alias ? "{k} ({v.expanded})" : k
				insertText: k
				kind: CompletionItemKind.Field
				commitCharacters: ['@',':']
				sortText: v.alias ? "-{k}" : k.replace(/^\-/,'Z')
				detail: detail
				documentation: v.description
				data: {resolved: true}
			}

			if o.shorthandStyleProperties
				if v.abbr
					item.filterText = item.label
					item.label = "{item.label} ({v.abbr})"
					item.insertText = v.abbr

			items.push item
		return items

	def getCSSValueCompletions ctx,o = {}
		let items\CompletionItem[] = []
		let property = cssProperties[String(o.styleProperty)]

		return [] unless property

		let name = property.name
		let values = (property.values or []).slice(0)

		if name == 'transition-timing-function'
			values = Object.values($easings)
			# console.log 'set values',values,theme.variants.easings
		elif name == 'transition'
			# need to look at which part of the value we are in
			values = Object.values($easings)

		elif name == 'color'
			values = Object.values($colors)
		elif name == 'background' or name.match(/\-color/)
			values.push(...Object.values($colors))
		elif name == 'border-radius'
			values = Object.values($styles.rd)
		elif name == 'font-size'
			values = Object.values($styles.fs)
		elif name == 'font-family'
			values = Object.values($styles.ff) # .concat(values)
		
		for val,i in values
			let sort = 1000 + (val.name[0] == '-' ? (i + 100) : i)
			let detail = val.detail or val.description
			let item = {
				label: val.name
				insertText: val.name
				kind: CompletionItemKind.Value,
				sortText: "{sort}-{val.name}"
				detail: detail
				documentation: {
					kind: 'markdown'
					value: val.documentation or ''
				}
				data: {resolved: true}
			}

			if val.type == 'color'
				item.kind = CompletionItemKind.Color
				item.documentation = item.detail

			items.push(item)

		return items

	def getCSSModifierCompletions ctx, o= {}
		let items\CompletionItem[] = []
		for own k,v of cssModifiers
			items.push {
				label: k
				insertText: k
				commitCharacters: [':']
				kind: CompletionItemKind.Field,
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