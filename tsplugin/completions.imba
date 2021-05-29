
import * as util from './util'
import Context from './context'

import {Sym,CompletionTypes as CT} from '../document'


const Globals = "global imba module window document exports console process parseInt parseFloat setTimeout setInterval setImmediate clearTimeout clearInterval clearImmediate globalThis isNaN isFinite __dirname __filename".split(' ')

const Keywords = "and await begin break by case catch class const continue css debugger def get set delete do elif else export extends false finally for if import in instanceof is isa isnt let loop module nil no not null of or require return self static super switch tag then this throw true try typeof undefined unless until var when while yes".split(' ')


export class Completion
	
	data = {}
	label = {}

	constructor symbol, context, options = {}
		#cache = {}
		#context = context
		#options = options
		sym = #symbol = symbol
		weight = 0
		
		item = {data: data, label: label, sortText: ""}
		load(symbol,context,options)
		kind = options.kind if options.kind
	
		setup(symbol)
		triggers options.triggers
		
	def load symbol, context, options = {}
		yes
		self
		
	def setup sym
		Object.assign(item,sym)
		
	get id
		return #nr if #nr >= 0
		#nr = #context.items.indexOf(self)
	
	get checker
		#context.checker
		
	get program
		checker.program

	get #type
		#symbol.type or #symbol.#type
		
	get importInfo
		null
		
	def resolveImportInfo
		let info = importInfo
		return unless info
		let alias = info.importName or info.name
		let name = info.importKind == 1 ? 'default' : alias
		let edits = doc.createImportEdit(info.source,name,alias)
		
		if edits.alias
			item.insertText = edits.alias
			ns = edits.alias

		elif edits.changes.length
			item.additionalTextEdits = edits.changes
		self
		
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

	get completion
		self
		
	get source
		null

	set kind kind
		item.kind = kind
	
	get kind
		item.kind

	set name val do label.name = val
	get name do label.name

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
			
	set sourcePath val
		if #sourcePath = val
			data.source = val
			ns = util.normalizeImportPath(#context.file.fileName,val)
			
	get sourceFile
		#sourceFile
		
	get exportInfo
		null
	
	get uniqueName
		#uniqueName or item.insertText or name

	def serialize context, stack
		let o = #options
		let key = uniqueName
		
		if stack[key]
			return null
			
		if o.startsWith
			return null unless key.indexOf(o.startsWith) == 0
		
		stack[key] = self
		
		if o..commitCharacters
			item.commitCharacters = o.commitCharacters
		if o.weight != undefined
			item.sortText = util.zerofill(o.weight)
		# item.data.id ||= "{#context.file.id}|{#context.id}|{id}"
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
				ns = "from '{path}'"

			# console.log edits.changes,info,specifier,item,self

		self

export class SymbolCompletion < Completion
	def setup sym
		let cat = #options.kind
		let par = sym.parent
		let o = #options
		let f = sym.flags
		name = sym.imbaName
		# let pname = sym.parent..escapedName
		if cat == 'styleprop'
			#uniqueName = name
			if let alias = sym.doctag('alias')
				ns = alias
				# check if we've enabled shorthand css completions in settings
				if alias.length < name.length
					item.insertText = alias
			triggers ':@.'	
			

export default class Completions
	
	constructor script, pos, prefs
		self.script = script
		self.pos = pos
		self.prefs = prefs
		self.ls = ls or script.ls
		
		#prefix = ''
		#added = {}
		#uniques = new Map
		
		items = []
		resolve!
		
	get checker
		# should we choose configured project or?
		#checker ||= script.getTypeChecker!
		
	get triggerCharacter
		prefs.triggerCharacter
			
	def resolve
		ctx = script.doc.getContextAtOffset(pos)
		tok = ctx.token
		flags = ctx.suggest.flags
		util.log('resolveCompletions',self,ctx,tok)
		
		if tok.match('identifier')
			prefix = ctx.before.token

		prefixRegex = new RegExp("^{prefix}","i")
		
		if flags & CT.TagName
			util.log('resolveTagNames',ctx)
			add('tagnames',kind: 'tagname')
			
		if flags & CT.StyleModifier
			add checker.props('ImbaStyleModifiers',yes), kind: 'stylemod'
			
		if flags & CT.StyleSelector
			add checker.props('ImbaHTMLTags',yes), kind: 'stylesel'
		
		if flags & CT.StyleProp
			add checker.props('$cssrule$'), kind: 'styleprop'
		
		if triggerCharacter == '<' and ctx.after.character == '>'
			add completionForItem({
				commitCharacters: [' ','<','=']
				filterText: ''
				preselect: yes
				sortText: "0000"
				kind: 'snippet'
				textEdit: {start: pos, length: 1, newText: ''}
				label: {name: ' '}
			})
		self
		
	def tagnames o = {}
		let html = checker.props('HTMLElementTagNameMap')
		add(html,o)
		
	def completionForItem item, opts = {}
		if item isa Completion
			return item
		
		if item.#tsym
			item = item.#tsym

		let entry = #uniques.get(item)
		return entry if entry

		if item isa global.SymbolObject
			entry = new SymbolCompletion(item,self,opts)
		elif item.#symbolFile
			entry = new WorkspaceSymbolCompletion(item,self,opts)
		elif item isa Sym
			entry = new SymCompletion(item,self,opts)
		elif item.hasOwnProperty('exportKind')
			entry = new AutoImportCompletion(item,self,opts)
		elif item.label
			entry = new Completion(item,self,opts)

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
		
		util.log "called {type}",Date.now! - t

		if results isa Array
			for item in results
				add(completionForItem(item,options))
				# items.push(completionForItem(item))
			util.log "added {results.length} {type} in {Date.now! - t}ms"

		#added[type] = results or true
		return self

	def serialize
		let entries = []
		let stack = {}
		# util.time(&,'serializing') do
		for item in items
			let entry = item.serialize(self,stack)
			entries.push(entry) if entry

		# devlog 'serialized',entries,items
		return entries
		
	def find item
		items.find do $1.name == item