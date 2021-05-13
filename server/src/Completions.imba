import {Component} from './Component'
import {ProgramSnapshot} from './Checker'
export {ProgramSnapshot}

import {CompletionItemKind,DiagnosticSeverity,SymbolKind,Location,LocationLink} from 'vscode-languageserver-types'

import type {Program,TypeChecker} from 'typescript'
import * as ts from 'typescript'
import {Sym,CompletionTypes} from 'imba/program'
import * as util from './utils'
import {cssProperties} from './Entities'

const SymbolObject = ts.objectAllocator.getSymbolConstructor!
const TypeObject = ts.objectAllocator.getTypeConstructor!
const NodeObject = ts.objectAllocator.getNodeConstructor!

const Globals = {
	'global': 1
	'imba': 1
	'module': 1
	'window': 1
	'document': 1
	'exports': 1
	'console': 1
	'process': 1
	'parseInt': 1
	'parseFloat': 1
	'setTimeout': 1
	'setInterval': 1
	'setImmediate': 1
	'clearTimeout': 1
	'clearInterval': 1
	'clearImmediate': 1
	'globalThis': 1
	'isNaN': 1
	'isFinite': 1
	'__dirname': 1
	'__filename': 1
}

const Keywords = "and await begin break by case catch class const continue css debugger def get set delete do elif else export extends false finally for if import in instanceof is isa isnt let loop module nil no not null of or require return self static super switch tag then this throw true try typeof undefined unless until var when while yes".split(' ')

export class Completion

	static def fromSymbol symbol
		new Completion(symbol)

	data = {}
	label = {}

	constructor symbol, context, options = {}
		#context = context
		#symbol = symbol
		#options = options
		#cache = {}
		weight = 0

		item = {
			data: data
			label: label
			sortText: ""
		}

		setup!
		triggers options.triggers
		# resolve!
		
	get id
		return #nr if #nr >= 0
		#nr = #context.items.indexOf(self)
	
	get checker
		#context.checker
		
	get program
		checker.program

	get #type
		#symbol.type
		
	get doc
		#context.doc
		
	def triggers chars = ''
		return self unless chars
		let list = item.commitCharacters ||= []
		for chr of chars
			list.push(chr) unless list.indexOf(chr) >= 0
		return self
	
	def #resolve
		if #resolved =? yes
			# console.log 'resolving item',self
			resolve!
		return item
	
	def resolve
		self

	def setup
		self

	get completion
		self

	set kind kind
		item.kind = util.convertCompletionKind(kind)

	set name val
		label.name = val

	get name
		label.name

	set detail val
		item.detail = val

	set ns val
		if val isa Array
			val = val[0]
		
		if val and val.text
			val = val.text

		label.qualifier = val
	
	get ns
		label.qualifier
	
	set documentation val
		item.documentation = val

	set sourceFile val
		if #sourceFile = val
			sourcePath = val.path
			# data.source = val.path
			# ns = util.normalizeImportPath(#context.file.fileName,val.path)
			
	set sourcePath val
		if #sourcePath = val
			data.source = val
			ns = util.normalizeImportPath(#context.file.fileName,val)
			
	get sourceFile
		#sourceFile
		
	get exportInfo
		null

	def serialize context, stack
		let key = item.insertText or name
		
		if stack[key]
			return null
		
		stack[key] = self
		
		if #options..commitCharacters
			item.commitCharacters = #options.commitCharacters
		if #options.weight != undefined
			item.sortText = util.zerofill(#options.weight)
		item.data.id ||= "{#context.file.id}|{#context.id}|{id}"
		return item
		
	def resolveImportEdits
		let info = exportInfo
		if info
			let specifier = checker.getModuleSpecifierForBestExportInfo(info)
			let path = specifier.moduleSpecifier
			
			let alias = data.name or info[0].importName
			let name = specifier.importKind == 1 ? 'default' : alias

			let edits = doc.createImportEdit(path,name,alias)
			
			if edits.changes.length
				item.additionalTextEdits = edits.changes
				ns = "import from '{path}'"

			# console.log edits.changes,info,specifier,item,self

		self
	

export class ManualCompletion < Completion
	constructor symbol, context, o = {}
		super
		Object.assign(item,symbol or {})	
		

export class SymCompletion < Completion
	get #type
		##type ||= #context.checker.resolveType(#symbol)

	def setup
		name = #symbol.name
		kind = util.convertSymbolKind(#symbol.semanticKind)
		# console.warn "SYM TYPE",#type,#symbol
		self
		
	def resolve
		let typ = #type
		
		if typ
			let typestr = #context.checker.checker.typeToString(typ)
			label.type = typestr

		return self	
		

	get qualifier
		'imba'

export class SymbolObjectCompletion < Completion
	def setup
		let cat = #options.kind
		let sym = #symbol
		let par = #symbol.parent
		name = #symbol.details.name
		
		let type = #symbol.type
		let typesym = type..symbol or sym
		
		# kind = util.convertSymbolKind(#symbol.semanticKind)
		# let typestr = type and type.checker.typeToString(type)
		
		try
			let docs = sym.getDocumentationComment! or []
			if docs[0]
				detail = docs[0].text
		
		let qf = par and par.label
		# if par
		#	label.qualifier = par.label

		if qf == 'ImbaEvents'
			label.qualifier = 'event'
			label.type = typesym.label

		if typesym.flags & (ts.SymbolFlags.Function | ts.SymbolFlags.Method)
			label.parameters = typesym.parametersToString!
		
		if sym.modifier?
			let typestr = type.checker.typeToString(type)
			let [params,returnType] = typestr.split(' => ')
			label.parameters = params == '()' ? '' : params
			delete label.qualifier

		if let detail = sym.doctag('detail')
			ns = detail

		if sym.tagname? and sym.mapped?
			label.type = sym.typeName
			ns = undefined
		
		# path should be relative to the file path
		if sym.component?
			sourceFile = sym.sourceFile
			if sym.pascal?
				# what if this already exists though?
				data.source = sym.sourceFile.path
				data.name = name
				
		if sym.#exportInfoKey
			# see if this is the local file?
			name = sym.#exportInfoKey.split('|')[0]
			unless sym.parent
				console.log "export key has no parent",sym.#exportInfoKey
				# console.log "SOURCEFILE",sym,sym.sourceFile
			else
				sourcePath = sym.parent.escapedName.slice(1,-1)

		# not if this is a tag?!
		if cat == 'tagname'
			triggers '> .[#'
			kind = 'value'
			label.type = null
		elif cat == 'tag'
			triggers ' '
			kind = 'value'
			label.type = null
			item.filterText = name
			item.insertText = "<{name}>"
			name = item.insertText
		else
			triggers '!(,.['
			kind = util.tsSymbolFlagsToKindString(typesym.flags)

		return self
		
	get exportInfo
		if #symbol.#exportInfoKey
			return #context.checker.getSymbolToExportInfoMap!.get(#symbol.#exportInfoKey)
		return null
		
	def resolve
		yes
		# name = name + '?!'
		resolveImportEdits!
		self
		
	def serialize
		return null if #symbol.internal?
		super


export class StyleCompletion < Completion
	
export class KeywordCompletion < Completion
	
	def constructor word,ctx,o = {}
		super
		name = word
		kind = 'keyword'
		triggers ' '
	
export class StylePropCompletion < StyleCompletion
	def setup
		let sym = #symbol
		name = sym.name

		if sym.abbr
			item.insertText = sym.abbr
		if sym.expanded
			ns = sym.expanded
		elif sym.abbr
			ns = sym.abbr
		
		triggers '@:'
		item.sortText = sym.alias ? "-{name}" : name.replace(/^\-/,'Z')
		self

let counter = 1
let cachedContexts = new Map

export class CompletionsContext < Component
	
	get ils
		file.ils
		
	def release
		cachedContexts.delete(id)
		self
		
	def retain
		yes
		# cachedContexts.set(id,self)
		self
	
	static def releaseAll
		cachedContexts.clear!
		
	static def lookup id
		let [ctxid,itemid] = id.split(':')
		let res = cachedContexts.get(ctxid)
		if itemid and res
			res = res.items[itemid]
		return res
	
	constructor file, pos, options = {}
		super
		file = file
		pos = pos
		options = options
		trigger = options.triggerCharacter
		id = counter++
		#prefix = ''
		#added = {}
		#uniques = new Map
		$stamp 'init comp'
		items = []
		doc = file.idoc
		compilation = file.currentCompilation
		$stamp 'compilation'

		ctx = doc.getContextAtOffset(pos)
		$stamp 'got context'
		tok = ctx.token
		devlog 'context',ctx
		let flags = ctx.suggest.flags
		let T = CompletionTypes
		ctx.tag = ctx.group.closest('tag')
		
		if trigger == '=' and !tok.match('operator.equals.tagop')
			return
		
		# only show completions directly after : in styles	
		if trigger == ':' and !tok.match('style.property.operator')
			return
			
		# try to find the closest matching typescript location and node
		if true
			# only if there is a real position?
			oloc = checker.sourceFile.d2o(pos)
			checker.location = oloc
			# console.warn "TLOC IS",oloc,checker.location
		$stamp 'set location'

		# find the actual declarations reference
		util.time(&,'check variables') do checkVariables!
		let expr = try 
			util.time(&,'resolve type') do checker.resolveType(ctx.target,doc)
			
		$stamp 'resovled types?'

		devlog 'target type!!!!',expr,ctx.target,options
		
		# console.log ctx.suggest, ctx.token.type

		if tok.match('string')
			devlog 'in string!!'
			# should show if we are in dom string?
			return
			
		if flags & T.StyleValue
			let items = ils.entities.getCSSValueCompletions(ctx,ctx.suggest)
			add(items)

		if flags & T.StyleProp
			add Object.values(cssProperties).map do new StylePropCompletion($1,self)
		
		if flags & T.StyleModifier
			add checker.props('ImbaStyleModifiers',yes)
			
		if flags & T.StyleSelector
			add checker.props('ImbaHTMLTags',yes)

		if flags & T.TagName
			add('tagnames',kind: 'tagname')
		
		if flags & T.TagProp
			devlog 'tag attributes',ctx.tag.tagName
			# name may need to be resolved?
			add('tagattrs',name: ctx.tag.tagName)
		# we are in an actual expression

		if expr
			let props = checker.props(expr,yes).filter do
				$1.flags & ts.SymbolFlags.Value
			$stamp 'got props'
			props = props.filter do $1.escapedName[0] != '"'
			add(props)
			
		
		elif flags & T.Value
			# this is the special stuff now
			if ctx.group.closest('tagcontent') and !ctx.group.closest('tag')
				add('tagnames',kind: 'tag',weight: 300)

			add('values')
			
		if options.triggerCharacter == '<'
			let item = new ManualCompletion(null,self,{
				insertText: " "
				commitCharacters: [' ']
				filterText: ''
				preselect: yes
				sortText: "0000"
				kind: CompletionItemKind.Snippet
				textEdit: {range: doc.rangeAt(pos,pos+1), newText: ''}
				label: {name: ' '}
			})
			add(item)
		elif options.triggerCharacter == '.' and tok.match('operator.access')
			
			let item = new ManualCompletion(null,self,{
				filterText: ''
				preselect: yes
				sortText: "0000"
				textEdit: {range: doc.rangeAt(pos,pos), newText: ''}
				kind: CompletionItemKind.Snippet
				label: {name: ' '}
			})
			add(item)
		self
		
	def lookupKey key
		if items[key]
			return items[key]
		
	def checkAutoImports
		let out = ils.ts.codefix.getSymbolToExportInfoMap(checker.sourceFile,ils.tlshost,checker.program)
		# console.log "OUT!",Array.from(out.keys!)
		for [key,entry] of out
			console.log key
		return

	get checker
		#checker ||= new ProgramSnapshot(file.ils.getProgram!,file)

	def check
		checker.resolveType(ctx.token,file.idoc,ctx)

	def locals
		self

	def values
		add('variables',weight: 70)
		add('globals',weight: 500)
		
		# variables should have higher weight - but not the global variables?
		add('properties',value: yes, weight: 100)
		add('autoimports',weight: 700)
		add('keywords',weight: 650)
		self
		
	def autoimports
		checker.findExportSymbols!.map do $1[0].symbol
		# add('keywords',weight: 1000)
		
	def keywords o = {}
		for kw in Keywords
			new KeywordCompletion(kw,self,o)

	def properties
		# find the self-context or path
		let path = ctx.scope.selfScope.selfPath
		# devlog 'selfpath!!',path,ctx.scope,ctx.scope.selfScope
		let props = checker.props(path,yes)
		props = props.filter do $1.flags & ts.SymbolFlags.Value
		return props

	def tagnames o = {}
		let html = checker.props('HTMLElementTagNameMap')
		let custom = checker.props('globalThis').filter(do $1.component? )
		
		let localTags = checker.getLocalTagsInScope()
		let importTags = checker.getExportedComponentSymbols!
		
		# check the local items
		add(html,o)
		add(localTags,o)
		add(custom,o)
		add(importTags,o)
	
		
	def tagattrs o = {}
		# console.log 'check',"ImbaHTMLTags.{o.name}"
		let sym = checker.sym("HTMLElementTagNameMap.{o.name}")
		# let attrs = checker.props("ImbaHTMLTags.{o.name}")
		
		let pascal = o.name[0] == o.name[0].toUpperCase!
		let globalPath = pascal ? o.name : o.name.replace(/\-/g,'_') + '$$TAG$$'
		
		
		unless sym
			sym = try checker.sym("{globalPath}.prototype")

		if sym
			# this is a native tag
			let attrs = checker.props(sym)
			attrs = attrs.filter do(item)
				let par = item.parent..escapedName
				return no if par == "GlobalEventHandlers"
				return no if item.escapedName.match(/className|(__$)/)
				return util.isAttr(item)
			yes
			
			add(attrs,commitCharacters: ['='])
			
		# devlog 'found attrs',attrs
		yes

		# also add auto-imports?

	def checkVariables
		return #vars if #vars
		let scope = checker.sym(ctx.scope.path)
		# devlog 'getting scope',scope
		let loc = checker.location or scope

		let vars = #vars = doc.varsAtOffset(pos,yes)

		for item in vars
			let tsym = checker.local(item.name,loc)
			checker.type(tsym) # try to resolve the type
			if tsym and !item.name.match(/ctest/)
				item.#tsym = tsym

		return vars

	def variables
		let vars = checkVariables!
		vars.filter do !$1.global?
		
	def globals
		#globals ||= checker.props('globalThis')
		let items = #globals.slice(0).filter do
			$1.pascal? or Globals[$1.escapedName]
		return items

	def completionForItem item, opts
		if item isa Completion
			return item
		
		if item.#tsym
			item = item.#tsym

		let entry = #uniques.get(item)
		return entry if entry
		
		

		if item isa SymbolObject
			entry = new SymbolObjectCompletion(item,self,opts)
		elif item isa Sym
			entry = new SymCompletion(item,self,opts)
			
		elif item.label
			entry = new ManualCompletion(item,self,item)

		#uniques.set(item,entry)
		return entry

	def add type, options = {}
		
		if type isa Completion
			items.push(type) unless items.indexOf(type) >= 0
			return self
		
		if type isa Array
			for item in type
				add(completionForItem(item,options))
			return self

		return self if #added[type] 
		#added[type] = []
		
		let t = Date.now!
		let results = self[type](options)

		if results isa Array
			for item in results
				add(completionForItem(item,options))
				# items.push(completionForItem(item))

			devlog 'adding',type,results,Date.now! - t
		#added[type] = results or true
		return self

	def serialize
		let entries = []
		let stack = {}
		for item in items
			let entry = item.serialize(self,stack)
			entries.push(entry) if entry
			
		devlog 'serialized',entries,items
		return entries
		
	def find item
		items.find do $1.name == item
