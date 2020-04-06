import {CompletionItemKind,SymbolKind} from 'vscode-languageserver-types'
import {URI} from 'vscode-uri'
import {globals} from './constants'

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
	attr: SymbolKind.Field
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

export def tjs2imba text
	text = text.replace(/decorator\$/g,'@')
	text = text.replace(/\;/g,'')
	return text

export def tsp2lspCompletions items, {file,jsLoc,additions=null}
	let results = []
	let map = {}
	for entry in items

		let name = entry.name
		let kind = entry.kind
		let modifiers = (entry.kindModifiers or '').split(/[\,\s]/)

		let meta = {
			loc: jsLoc
			path: file.lsPath
			origKind: kind
			kindModifiers: entry.kindModifiers
			source: entry.source
		}

		if name.match(/[\w]Component$/) or name.match(/\$(member|static)\$/)
			continue

		# console.log entry
		if name.match(/^is([A-Z])/)
			name = name[2].toLowerCase! + name.slice(3) + '?'
		elif name.match(/^decorator\$(.+)/)
			meta.origKind = 'decorator'
			meta.origName = name
			name = name.slice(10)

		let item = {
			label: name,
			kind: convertCompletionKind(kind,entry),
			sortText: entry.sortText
			data: meta
		}

		for mod in modifiers when mod
			meta[mod] = true

		if entry.kindModifiers == 'declare' and entry.sortText == '4'
			yes

		if entry.kindModifiers == 'declare' and entry.sortText == '4'
			yes

		if entry.insertText
			if entry.insertText.indexOf('this.') == 0
				meta.implicitSelf = yes
				

		# only drop these in certain cases
		if kind == 'function' and meta.declare and name.match(/^[a-z]/)
			continue

		if (kind == 'var' or kind == 'parameter' or kind == 'function') and item.data.declare and name.match(/^[a-z]/)
			continue unless globals[name]

		Object.assign(meta,additions) if additions
		results.push(item)

	# add self
	results.push({
		label: 'self',
		kind: CompletionItemKind.Variable,
		sortText: '3'
		data: {
			resolved: yes
		}
	})

	return results


export def pascalCase str
	str.replace(/(^|[\-\_\s])(\w)/g) do |m,v,l| l.toUpperCase!

export def camelCase str
	str = String(str)
	# should add shortcut out
	str.replace(/([\-\_\s])(\w)/g) do |m,v,l| l.toUpperCase!

export def dashToCamelCase str
	str = String(str)
	if str.indexOf('-') >= 0
		# should add shortcut out
		str = str.replace(/([\-\s])(\w)/g) do |m,v,l| l.toUpperCase!
	return str

export def kebabCase str
	let out = str.replace(/([A-Z])/g) do |m,l| '-' + l.toLowerCase!
	out[0] == '-' ? out.slice(1) : out


export def fastExtractSymbols text
	let lines = text.split(/\n/)
	let symbols = []
	let scope = {indent: -1,children: []}
	let root = scope
	# symbols.root = scope
	let m

	for line,i in lines
		if line.match(/^\s*$/)
			continue

		let indent = line.match(/^\t*/)[0].length

		while scope.indent >= indent
			scope = scope.parent or root 

		m = line.match(/^(\t*((?:export )?(?:static )?(?:extend )?)(class|tag|def|get|set|prop|attr) )(\@?[\w\-\$\:]+(?:\.[\w\-\$]+)?)/)
		# m ||= line.match(/^(.*(def|get|set|prop|attr) )([\w\-\$]+)/)

		if m
			let kind = m[3]
			let name = m[4]
			let ns = scope.name ? scope.name + '.' : ''
			let mods = m[2].trim().split(/\s+/)
			let md = ''

			let span = {
				start: {line: i, character: m[1].length}
				end: {line: i, character: m[0].length}
			}

			let symbol = {
				kind: SYMBOL_KIND_MAP[kind]
				ownName: name
				name: ns + name
				span: span
				indent: indent
				modifiers: mods
				children: []
				parent: scope == root ? null : scope
				type: kind
				data: {}
				static: mods.indexOf('static') >= 0
				extends: mods.indexOf('extend') >= 0
			}

			if symbol.static
				symbol.containerName = 'static'
			
			symbol.containerName = m[2] + m[3]
				
			
			if kind == 'tag' and m = line.match(/\<\s+([\w\-\$\:]+(?:\.[\w\-\$]+)?)/)
				symbol.superclass = m[1]

			if scope.type == 'tag'
				md = "```html\n<{scope.name} {name}>\n```\n"
				symbol.description = {kind: 'markdown',value: md}

			scope.children.push(symbol)
			scope = symbol

			symbols.push(symbol)
	
	return symbols

export def fastParseCode code,after = ''
	let stack = [{type: 'code',start: 0}]
	let len = code.length
	let pairs = []
	let pairers = {
		'{':'}',
		'(':')',
		'[':']',
		'"': '"'
		"'": "'"
		"`": "`"
	}
	let i = 0

	let ctx = stack[0]

	let push = do(typ,o={})
		ctx = Object.assign(o,type: typ,up: ctx,start: i)
		ctx[typ] = 1
		stack.push(ctx)

	let pop = do
		ctx = ctx.up
		stack.pop()

	while i < len
		let chr = code[i++]

		if chr == '<' and ((code[i] and code[i].match(/[\w\{\[\.]/)) or after[0] == '>')
			push('tag')
		elif chr == '>' and ctx.tag
			pop()

		elif pairers[chr]
			push(chr,closer: pairers[chr])
		elif ctx.closer == chr
			pop()

	if ctx.type == '{' and ctx.up.type.match(/tag|"|`/)
		ctx.type = 'code'
	if ctx.type == '(' or ctx.type == '['
		ctx.type = 'code'
	
	if ctx.type.match(/"|`|'/)
		ctx.type = 'string'

	ctx.content = code.slice(ctx.start)
	if ctx.type == 'tag'
		if ctx.content.match(/\=\s*([^\s]*)$/)
			ctx.type = 'code'
	
	if ctx.type == '{'
		ctx.type = 'object'

	if ctx.type == 'string'
		if code.match(/import |from |require(\(|\s)/)
			ctx.type = 'filepath'
	return ctx


export def locationInString string, find, startFrom = 0
	let index = string.indexOf(find,startFrom)
	if index >= 0
		let br = string.indexOf('\n',index)
		let res = {offset: br >= 0 ? br : index}
		if find[find.length - 1] == '{'
			res.offset = index + find.length

		let k = index
		let l = string.length
		let pair = []
		# while k < l
		#	let letter = string[k++]
		return res
	return null

export def findStyleBlocks code
	let blocks = []
	let matcher = /\#\#\# css(\s|$)/
	let from = 0
	let loc
	while (loc = code.indexOf('### css',from)) >= 0
		let end = code.indexOf('###',loc + 3)
		let start = code.indexOf('\n',loc + 1)
		let block = {start: start, end: end}
		blocks.push(block)
		from = end + 3

	return blocks


export def stripNonStyleBlocks code
	let css = ""
	let blocks = findStyleBlocks(code)
	let start = 0
	for block in blocks
		let text = code.slice(start,block.start)
		css += text.replace(/\S/gm,' ')
		css += code.slice(block.start,block.end)
		start = block.end

	css += code.slice(start).replace(/\S/gm,' ')

	if false
		console.log css.length,code.length
		let lines = css.split('\n')
		let lines2 = code.split('\n')
		for line,i in lines
			console.log line.length, JSON.stringify(line)
			console.log lines2[i].length, JSON.stringify(lines2[i])
	return css

export def findCompiledOffsetForScope scope, javascript
	let findFromOffset = 0
	for scop in scope.chain
		let match = null
		if scop.type == 'root'
			scop.compiled-offset = 0
		elif scop.type == 'tag'
			match = "class {pascalCase(scop.name) + 'Component'}"
		elif scop.type == 'class'
			match = "class {scop.name}"
		elif scop.type.match(/get|set|def|prop/)
			match = scop.static ? '$static$(){' : '$member$(){'

		if match
			if let res = locationInString(javascript,match,findFromOffset)
				findFromOffset = res.offset
				scop.compiled-offset = res.offset
	return scope
		

	

export def fastExtractContext code, loc, tokens, compiled = ''
	let lft = loc
	let rgt = loc
	let len = code.length
	let chr
	let res = {
		loc: loc
		tokenState: ''
	}

	let styleBlocks = findStyleBlocks(code)
	let textBefore = code.slice(0,loc)
	let textAfter = code.slice(loc)
	
	let lnstart = textBefore.lastIndexOf('\n')
	let lnend = textAfter.indexOf('\n')
	let linesBefore = textBefore.split('\n')

	res.textBefore = linesBefore[linesBefore.length - 1]
	res.textAfter = textAfter.split('\n')[0]

	for block in styleBlocks
		if block.end > loc > block.start
			res.context = 'css'
			return res
	
	let currIndent = res.textBefore.match(/^\t*/)[0].length
	let maxIndent = currIndent
	res.indent = currIndent
	
	let ln = linesBefore.length
	res.lineAbove = linesBefore[ln - 2]

	let lineLoc = loc
	currIndent += 1

	let indents = []
	
	while ln > 0
		let line = linesBefore[--ln]
		lineLoc -= line.length
		if line.match(/^[\t\s]*$/) and indents.length
			lineLoc -= 1
			continue

		let ind = line.match(/^\t*/)[0].length
	
		if ind < currIndent
			currIndent = ind
			indents.unshift({loc: lineLoc, text: line.slice(ind)})
		lineLoc -= 1
	
	res.indents = indents
	res.scope = {type: 'root',root: yes,body: yes,tloc: {offset: 0}}
	res.tagtree = []
	res.path = ""

	# trace pairings etc
	let pre = res.indents.map(do $1.text).join('  ')
	let ctx = fastParseCode(pre,res.textAfter)
	res.ctxBefore = ctx.content
	
	let context-rules = [
		[/(def|set) [\w\$]+[\s\(]/,'params']
		[/(class) ([\w\-\:]+) <\s?([\w\-]*)$/,'superclass']
		[/(tag) ([\w\-\:]+) <\s?([\w\-]*)$/,'supertag']
		[/(def|set|get|prop|attr|class|tag) ([\w\-]*)$/,'naming']
		[/\<([\w\-\:]*)$/,'tagname']
		[/\\([\w\-\:]*)$/,'type']
	]

	for rule in context-rules
		if res.textBefore.match(rule[0])
			break res.context = rule[1]
	
	unless res.context
		res.context = ctx.type

		if ctx.type == 'object'
			if ctx.content.match(/\:\s*([^\s]*)$/)
				res.context = 'code'

	let findFromIndex = 0
	let tokenizeFromLoc = -1
	for indent in indents
		let line = indent.text
		let scope
		let match = null
		if let m = line.match(/^(export )?(tag|class) ([\w\-\:]+)/)
			tokenizeFromLoc = -1
			scope = {type: m[2], name: m[3],parent: res.scope, tloc: null}
			scope[m[2]] = m[3]
			let name = res.className = m[3]
			res.path += res.className
			# try to find 
			if m[2] == 'tag'
				name = pascalCase(name) + 'Component'

			match = "class {name}"
			
		elif let m = line.match(/^(static )?(def|get|set|prop) ([\w\-\$]+)/)
			tokenizeFromLoc = -1
			scope = {type: m[2], name: m[3],body: yes,parent: res.scope,static: !!m[1]}
			scope[m[2]] = m[3]
			let name = res.methodName = m[3]
			res.path += (m[1] ? '.' : '#') + m[3]

			if scope.type == 'prop'
				match = m[1] ? '$static$(){' : '$member$(){' # "{name}"
			elif scope.type == 'def'
				match = "{name}("
			else
				match = "{scope.type} {name}("

			match = m[1] + match if m[1]

		elif let m = line.match(/^(if|unless|while|for|try$) /)
			if tokenizeFromLoc == -1
				tokenizeFromLoc = indent.loc

		elif let m = line.match(/^\<([\w\-]+)/)
			# find something
			res.tagtree.push(m[1])
			res.scope.html = yes

		if match and scope
			if let m = locationInString(compiled,match,findFromIndex)
				findFromIndex = m.offset
				scope.tloc = m

		if scope
			# res.scopes.push(scope)
			res.scope = scope

	return res