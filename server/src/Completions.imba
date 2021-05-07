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

export class Completion

	static def fromSymbol symbol
		new Completion(symbol)

	data = {}
	label = {}

	constructor symbol, context, options = {}
		#context = context
		#symbol = symbol
		#options = options

		item = {
			data: data
			label: label
			sortText: ""
		}

		setup!
		triggers options.triggers
		resolve!

	get #type
		#symbol.type
		
	def triggers chars = ''
		return self unless chars
		let list = item.commitCharacters ||= []
		for chr of chars
			list.push(chr) unless list.indexOf(chr) >= 0
		return self
	
	def resolve
		if #resolved =? yes
			#resolve!
		return self
	
	def #resolve
		yes
		

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
		label.qualifier = val
	
	get ns
		label.qualifier
	
	set documentation val
		item.documentation = val

	set sourceFile val
		if val
			data.source = val.path
			ns = util.normalizeImportPath(#context.file.fileName,val.path)

	def serialize context
		if #options..commitCharacters
			item.commitCharacters = #options.commitCharacters
		return item
	

export class ManualCompletion < Completion
	constructor symbol, context, o = {}
		super
		Object.assign(item,o)	
		

export class SymCompletion < Completion
	get #type
		##type ||= #context.checker.resolvePath(#symbol)

	def setup
		name = #symbol.name
		kind = util.convertSymbolKind(#symbol.semanticKind)
		# console.warn "SYM TYPE",#type,#symbol
		self
		
	def #resolve
		let typ = #type
		
		if typ
			let typestr = #context.checker.checker.typeToString(typ)
			label.type = typestr
			
		

	get qualifier
		'imba'

export class SymbolObjectCompletion < Completion
	def setup
		let sym = #symbol
		let par = #symbol.parent
		name = #symbol.details.name
		
		let type = #symbol.type
		let typesym = type..symbol or sym
		kind = util.tsSymbolFlagsToKindString(typesym.flags)
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
			
		# if #options.value
		# 	ns = 'self'
		# 	yes
			
		# if typestr 
		#	label.type ||= typestr\
		triggers '!(,.['

		return self
		
	def serialize
		return null if #symbol.internal?
		super


export class StyleCompletion < Completion
	
export class KeywordCompletion < ManualCompletion
	
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
		

export class CompletionsContext < Component
	
	get ils
		file.ils
	
	constructor file, pos, options = {}
		super
		file = file
		pos = pos
		options = options
		trigger = options.triggerCharacter

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

		devlog 'target type!!',expr,ctx.target,options
		
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
			add('tagnames',triggers: '> .[#')
		
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
			add('values')
			
			
		if options.triggerCharacter == '<'
			let item = new ManualCompletion(null,self,{
				insertText: " "
				commitCharacters: [' ']
				filterText: ''
				preselect: yes
				kind: CompletionItemKind.Snippet
				textEdit: {range: doc.rangeAt(pos,pos+1), newText: ''}
				label: {name: ' '}
			})
			add(item)

	get checker
		#checker ||= new ProgramSnapshot(file.ils.getProgram!,file)

	def check
		checker.resolveType(ctx.token,file.idoc,ctx)

	def locals
		self

	def values
		# add('keywords')
		add('variables')
		# add('globals')
		add('properties',value: yes)
		self
		
	def keywords
		for kw in ctx.suggest.keywords
			let item = new KeywordCompletion(kw,self,{
				label: kw
				triggerCharacters: ' '
				
			})
			item

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
		add(html,o)
		add(custom,o)
		
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
			# let sym = rootsymbols.find(do $1.label == item.name)
			if tsym and !item.name.match(/ctest/)
				
				item.#tsym = tsym
				# check if the location of the ts definition
				# matches our expectation
		
				# devlog "match tsym variable",tsym
				# devlog 'found symbol for var',item.name,tsym

		return vars

	def variables
		return checkVariables!
		
	def globals
		#globals ||= checker.props('globalThis')
		let items = #globals.slice(0).filter do $1.pascal?
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
		for item in items
			let entry = item.serialize(self)
			entries.push(entry) if entry
			
		devlog 'serialized',entries,items
		return entries
		
	def find item
		items.find do $1.name == item
