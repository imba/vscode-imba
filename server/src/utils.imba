import {CompletionItemKind,SymbolKind} from 'vscode-languageserver-types'
import {URI} from 'vscode-uri'

export def uriToPath uri
	return uri if uri[0] == '/' or uri.indexOf('://') == -1
	URI.parse(uri).path

export def pathToUri path
	'file://' + path

export def rangeFromTextSpan span
	rangeFromLocations(span.start,span.end)

export def textSpanToRange span, filename, service
	let start = service.toLineColumnOffset(filename,span.start)
	let end = service.toLineColumnOffset(filename,span.start + span.length)
	return {start: start, end: end}
	
export def rangeFromLocations start, end
	return
		start:
			line: Math.max(0, start.line - 1),
			character: Math.max(start.offset - 1, 0)
		end:
			line: Math.max(0, end.line - 1)
			character: Math.max(0, end.offset - 1)

const COMPLETION_KIND_MAP = {
	property: CompletionItemKind.Field
	method: CompletionItemKind.Method
	text: CompletionItemKind.Text
	operator: CompletionItemKind.Operator
	class: CompletionItemKind.Class
	var: CompletionItemKind.Variable
	function: CompletionItemKind.Function
	const: CompletionItemKind.Constant
	module: CompletionItemKind.Module
	keyword: CompletionItemKind.Keyword
	alias: CompletionItemKind.Variable
	warning: CompletionItemKind.Text
	getter: CompletionItemKind.Field
	enum: CompletionItemKind.Enum
	value: CompletionItemKind.Value
	export: CompletionItemKind.Field
}

export def convertCompletionKind kind, entry
	return COMPLETION_KIND_MAP[kind] or CompletionItemKind.Method


const SYMBOL_KIND_MAP = {
	property: SymbolKind.Field
	prop: SymbolKind.Field
	method: SymbolKind.Method
	def: SymbolKind.Method
	constructor: SymbolKind.Constructor
	class: SymbolKind.Class
	"local class": SymbolKind.Class
	var: SymbolKind.Variable
	let: SymbolKind.Variable
	function: SymbolKind.Function
	const: SymbolKind.Constant
	module: SymbolKind.Module
	alias: SymbolKind.Variable
	getter: SymbolKind.Field
	get: SymbolKind.Field
	set: SymbolKind.Field
	setter: SymbolKind.Field
	tag: SymbolKind.Class
}

export def matchFuzzyString query,string
	let i = 0
	let k = 0
	let s = string.toLowerCase()
	while i < query.length
		let chr = query[i++]
		k = s.indexOf(chr,k) + 1
		return no if k == 0
	return yes

export def convertSymbolKind kind, entry
	return SYMBOL_KIND_MAP[kind] or SymbolKind.Field

export def tsp2lspSymbolName name
	if let m = name.match(/([A-Z][\w\-]+)Component$/)
		return kebabCase(name.slice(0,-9))
	return name

export def tsp2lspCompletions items, {file,jsLoc,meta=null}
	let results = []
	for entry in items
		let name = entry.name
		let kind = entry.kind
		let modifiers = (entry.kindModifiers or '').split(/[\,\s]/)
		console.log entry
		if name.match(/^is([A-Z])/)
			name = name[2].toLowerCase() + name.slice(3) + '?'
		elif name.match(/^do([A-Z])/)
			name = name[2].toLowerCase() + name.slice(3) + '!'
			
		let item = {
			label: name,
			kind: convertCompletionKind(kind,entry),
			sortText: entry.sortText
			data: {
				loc: jsLoc
				path: file.lsPath
				origKind: kind
				kindModifiers: entry.kindModifiers
			}
		}
		for mod in modifiers when mod
			item.data[mod] = true
		Object.assign(item.data,meta) if meta
		results.push(item)

	return results


export def pascalCase str
	str.replace(/(^|[\-\_\s])(\w)/g) do |m,v,l| l.toUpperCase

export def camelCase str
	str = String(str)
	# should add shortcut out
	str.replace(/([\-\_\s])(\w)/g) do |m,v,l| l.toUpperCase

export def dashToCamelCase str
	str = String(str)
	if str.indexOf('-') >= 0
		# should add shortcut out
		str = str.replace(/([\-\s])(\w)/g) do |m,v,l| l.toUpperCase
	return str

export def kebabCase str
	let out = str.replace(/([A-Z])/g) do |m,l| '-' + l.toLowerCase()
	out[0] == '-' ? out.slice(1) : out


export def fastExtractSymbols text
	let lines = text.split(/\n/)
	let symbols = []
	let scope = {indent: -1,children: []}
	let m

	for line,i in lines
		if line.match(/^\s*$/)
			continue

		let indent = line.match(/^\t*/)[0].length

		while scope.indent >= indent
			scope = scope.parent

		m = line.match(/^(\t*((?:export )?(?:static )?)(class|tag|def|get|set|prop|attr) )([\w\-\$]+)/)
		# m ||= line.match(/^(.*(def|get|set|prop|attr) )([\w\-\$]+)/)

		if m
			let kind = m[3]
			let name = m[4]
			let ns = scope.name ? scope.name + '.' : ''
			let mods = m[2].trim().split(/\s+/)

			let span = {
				start: {line: i + 1, character: m[1].length}
				end: {line: i + 1, character: m[0].length}
			}
			let symbol = {
				kind: SYMBOL_KIND_MAP[kind]
				name: ns + name
				span: span
				indent: indent
				modifiers: mods
				children: []
				parent: scope
				type: kind
			}

			if mods.indexOf('static') >= 0
				symbol.containerName = 'static'

			scope.children.push(symbol)
			scope = symbol

			symbols.push(symbol)
	
	return symbols


