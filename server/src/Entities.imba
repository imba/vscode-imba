import {Component} from './Component'
import {TAG_NAMES,TAG_TYPES,keywords,PRIMITIVE_TYPE_COMPLETIONS} from './constants'
import {CompletionItemKind,SymbolKind,InsertTextFormat} from 'vscode-languageserver-types'
import {convertCompletionKind,matchFuzzyString,tsp2lspCompletions,displayPartsToString} from './utils'

import type {CompletionItem} from 'vscode-languageserver-types'

import {tags,globalAttributes} from './html-data.json'
import * as cssData from './css-data.json'

import {snippets} from './snippets'

import {aliases as cssAliases,StyleTheme} from 'imba/src/compiler/styler'
import * as theme from 'imba/src/compiler/theme'

import * as svg from './StylePreviews'

let globalEvents = for item in globalAttributes when item.name.match(/^on\w+/)
	item

for tagItem in tags
	tags[tagItem.name] = tagItem


const cssProperties = {}


const UserPrefs = {
	imports: {
		includeCompletionsForModuleExports:true
		importModuleSpecifierPreference: "shortest"
		importModuleSpecifierEnding: "minimal"
		includePackageJsonAutoImports:"on"
		includeAutomaticOptionalChainCompletions:false
	}
}

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
			bxs: {}
			assets: {}
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

		for own name,value of theme.variants['box-shadow']
			registerBoxShadow(name,value)

		registerAssets!
		self
	
	def registerAssets
		let conf = program.imbaConfig
		if conf.assets
			for own name,value of conf.assets
				let item = {
					name: name
					type: 'asset'
					documentation: "![]({svg.uri(value.body)}|width=120,height=120)"
					
				}
				$styles.assets[name] = item
		return self

	def registerFontSize name, value
		let item = {
			name: name
			detail: value isa Array ? value[0] : value
			type: 'font-size'
			
		}
		item.documentation = "![]({svg.md('fs',item.detail)}|width=316,height=120)"

		$styles.fs[name] = item

	def registerBoxShadow name, value
		let item = {
			name: name
			detail: ''
			type: 'box-shadow'
		}
		item.documentation = "![]({svg.md('bxs',value)}|width=316,height=120)\n\n`{value}`"
		$styles.bxs[name] = item
	
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

	def getCSSInfo ctx
		let property = ctx.group.closest('styleprop')
		let propname = property and property.propertyName
		let grp
		let info = null
		let md = []

		if let key = ctx.group.closest('stylepropkey')
			# let raw = key.value.replace(/\:\s*$/,'')
			if info = cssProperties[propname]
				let link = info.references and info.references[0]
				if link
					md.push "**[{info.name}]({link.url})**"
				else
					md.push "**{info.name}**"
				md.push info.description
				# for ref in info.references
				#	md.push "[{ref.name}]({ref.url})"
			# now find the potential modifiers as well

		if md.length
			return {markdown: md.join('\n\n')}
	
		if info
			let md = info.documentation or info.description or info.detail
			return {
				name: info.name
				description: {kind: 'markdown', value: md}
			}

		return null


	def getCSSValueInfo value, propname, ctx = {}

		let item

		if item = $easings[value]
			yes
		elif item = $colors[value]
			yes
		else
			let completions = getCSSValueCompletions(ctx)
			let val = completions.$values and completions.$values[value]
			
			if val
				item = val
		
		if item
			let md = item.documentation or item.description or item.detail
			return {markdown: md}

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
		let items = []
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
		let items = []
		# possibly add flags for tailwind etc
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

	def isImport item
		return no if !item.source or item.source.match(/data\:text/)
		return no if item.source.match(/^node:/)
		return no if item.source == 'constants'
		return no if item.source.match(/[\/\\]imba[\/\\]src/)
		return yes

	def isUpperCase item
		!!item.name.match(/^[A-Z]/)

	def getGlobalCompletionsForFile file,...filters
		let end = file.getCompiledBody!.length
		let res = program.tls.getCompletionsAtPosition(file.fileName,end,UserPrefs.imports)
		res.entries = util.filterList(res.entries,...filters)
		
		return tsp2lspCompletions(res.entries,{file:file,jsLoc:end,additions:{prefs: 'imports'}})

	def getAutoImportsForFile file,ctx={}
		let end = file.getCompiledBody!.length
		let res = program.tls.getCompletionsAtPosition(file.fileName,end,UserPrefs.imports)
		return [] unless res..entries

		res.entries = for item in res.entries
			continue unless isImport(item)
			item

		devlog "getAutoImports",res.entries

		return tsp2lspCompletions(res.entries,{file:file,jsLoc:end,additions:{prefs: 'imports'}})

	def getTypesForFile file
		let items = getGlobalCompletionsForFile(file,[isImport,isUpperCase])
		items.unshift(...PRIMITIVE_TYPE_COMPLETIONS)
		return items

	def resolveCompletionEntry item\CompletionItem
		devlog 'getCompletionEntryDetails',item

		if item.data.resolved or item.data.symbolPath
			return item

		let source = item.data.source
		let name = item.data.origName or item.label.name or item.label
		let prefs = UserPrefs[item.data.prefs] or UserPrefs.imports
		let details = program.tls.getCompletionEntryDetails(item.data.path,item.data.loc,name,{},source,prefs)
		devlog 'details',details

		return unless details

		item.detail = displayPartsToString(details.displayParts)
		item.documentation = displayPartsToString(details.documentation)

		let actions = details.codeActions || []
		let additionalEdits = []
		let actionDescs = ''
		for action in actions
			actionDescs += action.description + '\n'

			devlog 'codeActions',action

			if let m = action.description.match(/Change '([^']+)' to '([^']+)'/)
				devlog 'change action',m

				if m[1] == (item.insertText or item.label)
					item.insertText = util.tjs2imba(m[2])
					continue

			for change in action.changes
				let file = program.getRichFile(change.fileName)

				for textedit in change.textChanges
					let range = file.textSpanToRange(textedit.span)
					devlog 'additional change here',textedit,range
					let text = util.tjs2imba(textedit.newText)
					additionalEdits.push(range: range, newText: text)

		item.detail = util.tjs2imba(actionDescs + item.detail)
		item.additionalTextEdits = additionalEdits
		item.data.resolved = yes
		return item
	
	def getTagNameCompletions ctx, o = {}, file = null

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
		let importable = []
		let globals = null
		
		for item in components # $cache.components
			continue if included[item.name]

			let entry = {
				label: item.name
				kind: CompletionItemKind.Field,
				sortText: item.name
				data: {resolved: true}
			}

			let local? = item.name[0] == item.name[0].toUpperCase!

			if local? and item.#file != file
				# what if it is already imported
				
				if item.modifiers.indexOf('export') >= 0
					# entry.label = "IMPORT {entry.label}"
					globals ||= getGlobalCompletionsForFile(file) do(item)
						item.source or item.kind == 'alias'

					let other = globals.find(do $1.name == item.name)
					if other
						if $web$
							resolveCompletionEntry(other)
							devlog 'resolved completion',other
							other.detail = null
							other.data.resolved = yes
						entry = other
						
					# if globals.find(do $1.label == '')
				else
					continue

			items.push included[item.name] = entry

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
		let propalias = o.styleProperty

		unless propalias
			let p = ctx.group.closest('styleprop')
			if p
				propalias = p.propertyName

		let property = cssProperties[String(propalias)]

		return [] unless property

		let name = property.name
		let values = (property.values or []).slice(0)
		let syntax = property.syntax or ''
		# console.log 'css value completions',name
		let signature = syntax.split(' || ')
		let before = ctx..before..group
		let nr = before ? before.split(' ').length : 0

		# console.log 'parts',signature,before,nr,before.split(' ')

		if signature.length > 1 and before
			# let nr = before.split(' ')
			let kind = signature[before.split(' ').length - 1]
			# console.log 'parts',signature,kind
			# if place
			if kind == '<color>'
				name = 'color'

		if name == 'transition'
			if nr == 1
				values = property.values.slice(0)
			elif nr == 3
				values = Object.values($easings)

		elif name.match(/^border(-(left|right|top|bottom))?$/)
			if nr == 2
				values = cssProperties['text-decoration-style'].values.slice(0)
			elif nr == 3
				values = Object.values($colors)

		elif name == 'transition-timing-function'
			values = Object.values($easings)
			# console.log 'set values',values,theme.variants.easings
		# elif name == 'transition'
		#	# need to look at which part of the value we are in
		#	values = Object.values($easings)
		elif name == 'svg'
			values = Object.values($styles.assets)
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
		elif name == 'box-shadow'
			values = Object.values($styles.bxs) # .concat(values)
		
		let map = items.$values = {}
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

			map[val.name] = val
			items.push(item)

		return items

	def getCSSModifierCompletions ctx, o= {}
		let items\CompletionItem[] = []
		for own k,v of theme.modifiers
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