import * as util from './util'
import {Sym as ImbaSymbol,Node as ImbaNode, Token as ImbaToken, SymbolFlags as ImbaSymbolFlags} from '../document'

const Globals = "global imba module window document exports console process parseInt parseFloat setTimeout setInterval setImmediate clearTimeout clearInterval clearImmediate globalThis isNaN isFinite __dirname __filename".split(' ')

const Keywords = "and await begin break by case catch class const continue css debugger def get set delete do elif else export extends false finally for if import in instanceof is isa isnt let loop module nil no not null of or require return self static super switch tag then this throw true try typeof undefined unless until var when while yes".split(' ')

extend class ImbaSymbol

	get tsFlags
		let f = 0
		let F = global.ts.SymbolFlags
		if parameter?
			f |= F.FunctionScopedVariable
		elif varaible?
			f |= F.BlockScopedVariable
		if member?
			f |= F.Property
		if flags & ImbaSymbolFlags.Class
			f |= F.Class

		return f

	def toSymbolObject checker
		checker.createSymbol(tsFlags,name)


class ImbaMappedLocation
	constructor context, dpos, opos
		dpos = dpos
		opos = opos
		context = context
		otoken = global.ts.findPrecedingToken(opos,context.sourceFile)
		
		# 
	
	get thisType
		return #thisType if #thisType
		let node = global.ts.getThisContainer(otoken)
		while node and node.symbol.escapedName == '__function'
			node = global.ts.getThisContainer(node)
		if node and node.body
			return #thisType = context.checker.tryGetThisTypeAt(node.body)

		return null
		
		while !#thisType and node and !(node isa global.SourceFile)
			let typ = context.checker.tryGetThisTypeAt(node)
			if typ.intrinsicName == 'undefined'
				node = global.ts.getThisContainer(otoken)
			else
				return #thisType = typ
		return #thisType
		
	def valueOf
		dpos
		
	
export default class ImbaTypeChecker
	
	constructor project, program, checker, script
		project = project
		program = program
		checker = checker
		script = script
		mapper = script.getMapper(program)
		#typecache = {}
	
	get sourceFile
		#sourceFile ||= program.getSourceFile(script.fileName)
	
	get ts
		global.ts

	get basetypes
		#basetypes ||= {
			string: checker.getStringType!
			number: checker.getNumberType!
			any: checker.getAnyType!
			void: checker.getVoidType!
			"undefined": checker.getUndefinedType!
		}
	
	get cssmodule
		checker.tryFindAmbientModule('imba_css')
		
	get snippets
		checker.tryFindAmbientModule('imba_snippets')
		
	get cssrule
		#cssrule ||= checker.getDeclaredTypeOfSymbol(cssmodule.exports.get('css$rule'))
		# #cssrule ||= checker.getTypeOfSymbolAtLocation(cssmodule.exports.get('s'),cssmodule.valueDeclaration)
	
	get csstypes
		#csstypes ||= checker.getDeclaredTypeOfSymbol(cssmodule.exports.get('css$types'))
	
	get cssmodifiers
		props(type('$cssmodule$.css$modifiers'))
		
	get globals
		#globals ||= props('globalThis').slice(0).filter do $1.pascal? or Globals.indexOf($1.escapedName) >= 0
		
	def getMappedLocation dpos
		let res = {dpos: dpos}
		# if we are just at the start of an indent -- look up
		# to the previously declared 
		let opos = res.opos = script.d2o(dpos,program)
		let tok = res.tok = ts.findPrecedingToken(opos,sourceFile)
		
		res.stmt = ts.findAncestor(res.tok,ts.isStatement)
		res.container = ts.getThisContainer(res.tok)
		return res
		
	def getLocation dpos, opos = null
		opos ??= script.d2o(dpos,program)
		new ImbaMappedLocation(self,dpos,opos)
	
	def findClosestContext dpos
		self
	
	def getSymbolDetails symbol
		ts.Completions.createCompletionDetailsForSymbol(sym(symbol),checker,sourceFile,sourceFile)
		
	def getStyleValueTypes propName, index = 0
		let target = type([cssrule,propName,'set'])

		# if let alias = target.doctag('proxy')
		# 	target = member(cssrule,alias)
			
		let signatures = checker.getSignaturesOfType(type(target),0)
		
		let types = []
		for entry in signatures
			let params = entry.getParameters()
			let param = params[index]
			types.push(type(param))

		return types
		
	def getStyleValues propName, index = 0
		let symbols = []
		let types = getStyleValueTypes(propName,index)
		for typ in types
			let props = allprops(typ).filter do
				$1.parent and $1.parent.escapedName.indexOf('css$') == 0
			symbols.push(...props)
		
		if index == 0
			symbols.push(...self.props('$cssmodule$.css$globals'))

		return symbols.filter do(item,i,arr) arr.indexOf(item) == i
		
	def getStyleProps
		props(cssrule)
		
	def getLocalTagsInScope
		let symbols = checker.getSymbolsInScope(sourceFile,32)
		for s in symbols
			type(s)
		symbols = symbols.filter do(s)
			let key = type([s,'prototype'])
			key and key.getProperty('suspend')
		return symbols

	def getSymbolInfo symbol
		symbol = sym(symbol)
		let out = ts.SymbolDisplay.getSymbolDisplayPartsDocumentationAndSymbolKind(checker,symbol,sourceFile,sourceFile,sourceFile)
		if out
			out.kindModifiers = ts.SymbolDisplay.getSymbolModifiers(checker, symbol)
			out.kind = out.symbolKind
		return out
		
	def getSymbolKind symbol
		{
			kind: ts.SymbolDisplay.getSymbolKind(checker,symbol,sourceFile)
			kindModifiers: ts.SymbolDisplay.getSymbolModifiers(checker,symbol,sourceFile)
		}
		
	
	def getTagSymbol name
		let symbol
		if util.isPascal(name)
			symbol = local(name)
		else
			# check in global html types
			symbol = sym("HTMLElementTagNameMap.{name}")
			
			unless symbol
				let key = name.replace(/\-/g,'_') + '$$TAG$$'
				symbol = sym("globalThis.{key}")

		return symbol
		

	def arraytype inner
		checker.createArrayType(inner or basetypes.any)

	def resolve name,types = ts.SymbolFlags.All, location = null
		if (/^\$\w+\$$/).test(name)
			return self[name.slice(1,-1)]

		let sym = checker.resolveName(name,location or sourceFile,symbolFlags(types),false)
		return sym
		
	def symToPath sym
		let pre = ''
		if sym.parent
			pre = symToPath(sym.parent) + '.'
		return pre + checker.symbolToString(sym,undefined,0,0)
	
	def pathToSym path
		if path[0] == '"'
			let end = path.indexOf('"',1)
			let src = path.slice(1,end)
			let abs = ts.pathIsAbsolute(src)
			let mod = abs ? program.getSourceFile(src).symbol : checker.tryFindAmbientModule(src)
			return sym([mod].concat(path.slice(end + 2).split('.')))
		return sym(path)
		
	def parseType string, token, returnAst = no
		string = string.slice(1) if string[0] == '\\'
		if let cached = #typecache[string]
			return cached
		
		let ast
		try
			ast = ts.parseJSDocTypeExpressionForTests(string,0,string.length).jsDocTypeExpression.type
			ast.resolved = resolveTypeExpression(ast,{text: string},token)
			return ast if returnAst
			return #typecache[string] = ast.resolved
		catch e
			yes
			# console.log 'parseType error',e,ast
			
	def collectLocalExports
		let exports = {}
		let files = program.getSourceFiles!
		for file in files
			continue if file.path.indexOf('node_modules') >= 0
			let sym = file.symbol
			exports[file.path] = {}
		console.log 'exports!',exports
		return exports
			
	
	def resolveTypeExpression expr, source, ctx
		let val = expr.getText(source)
		
		if expr.elements
			let types = expr.elements.map do resolveTypeExpression($1,source,ctx)
			return checker.createArrayType(types[0])
		
		if expr.elementType
			let type = resolveTypeExpression(expr.elementType,source,ctx)
			return checker.createArrayType(type)
		
		if expr.types
			let types = expr.types.map do resolveTypeExpression($1,source,ctx)
			# console.log 'type unions',types
			return checker.getUnionType(types)
		if expr.typeName
			let typ = local(expr.typeName.escapedText,#file,'Type')
			if typ
				return checker.getDeclaredTypeOfSymbol(typ)
				# return type(typ)
		elif basetypes[val]
			return basetypes[val]


	def local name, target = sourceFile, types = ts.SymbolFlags.All
		let sym = checker.resolveName(name,loc(target),symbolFlags(types),false)
		return sym

	def symbolFlags val
		if typeof val == 'string'
			val = ts.SymbolFlags[val]
		return val

	def signature item
		let typ = type(item)
		let signatures = checker.getSignaturesOfType(typ,0)
		return signatures[0]

	def string item
		let parts
		if item isa Signature
			parts = ts.signatureToDisplayParts(checker,item)
		
		if parts isa Array
			return util.displayPartsToString(parts)
		return ''

	def fileRef value
		return undefined unless value
		
		if value.fileName
			value = value.fileName

		if typeof value == 'string'
			program.getSourceFile(value)
		else
			value
			
	set location value
		let item = loc(value)
		#location = item
	
	get location
		#location

	def loc item, backup
		return undefined unless item
		
		if item isa global.Token
			return item
		if item isa global.NodeObject
			return item
		if item isa global.SymbolObject
			return item.valueDeclaration or loc(backup)
		if item isa ImbaMappedLocation
			return item.otoken

		if typeof item == 'number'
			return ts.findPrecedingToken(item,sourceFile)
		if item.fileName
			return program.getSourceFile(item.fileName)
		
		return item


	def type item
		if typeof item == 'string'
			if item.indexOf('.') >= 0
				item = item.split('.')
			else
				item = resolve(item)

		if item isa Array
			let base = type(item[0])
			for entry,i in item when i > 0
				base = type(member(base,entry))
			item = base

		if item isa SymbolObject
			# console.log 'get the declared type of the symbol',item,item.flags
			if item.flags & ts.SymbolFlags.Interface
				item.instanceType_ ||= checker.getDeclaredTypeOfSymbol(item)
				
				unless item.flags & ts.SymbolFlags.Value
					return item.instanceType_
			
			item.type_ ||= checker.getTypeOfSymbolAtLocation(item,loc(item) or loc(script))
			return item.type_

		if item isa TypeObject
			return item

		if item isa Signature
			return item.getReturnType!

	def sym item
		if typeof item == 'string'
			if item.indexOf('.') >= 0
				item = item.split('.')
			else
				item = resolve(item)

		if item isa Array
			let base = sym(item[0])
			for entry,i in item when i > 0
				base = sym(member(base,entry))
			item = base
		
		if item isa SourceFile
			item.symbol

		if item isa SymbolObject
			return item

		if item isa TypeObject and item.symbol
			return item.symbol

	def locals source = #file
		let file = fileRef(source)
		let locals = file.locals.values!
		return Array.from(locals)
	
	def props item, withTypes = no
		let typ = type(item)
		return [] unless typ

		let props = typ.getApparentProperties!
		if withTypes
			for item in props
				type(item)
		return props
		
	def allprops item, withTypes = no
		let typ = type(item)
		return [] unless typ

		let props = typ.types ? checker.getAllPossiblePropertiesOfTypes(typ.types) : typ.getApparentProperties!

		if withTypes
			for item in props
				type(item)
		return props
	
	def statics item, withTypes = no
		yes

	def propnames item
		let values = type(item).getApparentProperties!
		values.map do $1.escapedName
	
	def getSelf loc = #location
		yes
		
		# checker.getSymbolAtLocation(f0.checker.loc(25))

	def member item, name
		return unless item

		if typeof name == 'number'
			name = String(name)

		# if name isa Array
		#	console.log 'access the signature of this type!!',item,name

		# console.log 'member',item,name
		let key = name.replace(/\!$/,'')
		let typ = type(item)
		unless typ and typ.getProperty isa Function
			console.warn 'tried getting type',item,key,typ

		let sym = typ.getProperty(key)
		
		if key == '__@iterable'
			# console.log "CHECK TYPE",item,name
			
			let resolvedType = checker.getApparentType(typ)
			util.log('get type of iterable',typ,resolvedType)

			return null unless resolvedType.members
			let members = Array.from(resolvedType.members.values())
			sym = members.find do $1.escapedName.indexOf('__@iterator') == 0
			# sym = resolvedType.members.get('__@iterator')
			util.log('resolving Type',members,sym)
			
			return type(signature(sym)).resolvedTypeArguments[0]
			#  iter.getCallSignatures()[0].getReturnType()
			
		if sym == undefined
			let resolvedType = checker.getApparentType(typ)
			return null unless resolvedType.members
			sym = resolvedType.members.get(name)
			
			if name.match(/^\d+$/)
				sym ||= typ.getNumberIndexType!
			else
				sym ||= typ.getStringIndexType!

		if key !== name
			sym = signature(sym)
		return sym
		

	def inferType tok, doc, loc = null
		util.log('infer',tok)
		if tok isa Array
			return tok.map do inferType($1,doc)
		
		if typeof tok == 'number' or typeof tok == 'string'
			
			if typeof tok == 'string' and tok[0] == '\\'
				return parseType(tok,null)

			return tok

		if tok isa ImbaNode
			let node = tok
			if tok.type == 'type'
				let val = String(tok)
				return parseType(val,tok)
				# console.log 'DATATYPE',tok.datatype,val
				# we do need to resolve the type to
				# if basetypes[val.slice(1)]
				#	return basetypes[val.slice(1)]
			
			if tok.match('value') or tok.match('parens')
				let end = tok.end.prev
				while end and end.match('br')
					end = end.prev
				# end = end.prev if end.match('br')
				tok = end
				let typ = inferType(tok,doc,tok)
				# console.log 'resolved type',typ
				if node.start.next.match('keyword.new')
					typ = [typ,'prototype']
				return typ
				
			# console.log 'checking imba node!!!',tok
		
		let sym = tok.symbol
		let typ = tok.type
		
		# is an imported variable

		if tok isa ImbaSymbol
			let typ = tok.datatype

			if typ and typ.exportName
				return resolveImportInfo(typ)

			if typ
				return inferType(typ,doc)
				
			# now try to calculate the previous position of this
			# try to find the matching location / symbol in typescript
			let opos = mapper.d2o(tok.node.endOffset)
			let otoken = ts.findPrecedingToken(opos,sourceFile)

			try
				# must be the same type of item and the pos should not have moved?
				typ = checker.getTypeAtLocation(otoken)
				tok.node.#otyp = typ
				return typ if typ
		
			if tok.body
				# doesnt make sense
				return resolveType(tok.body,doc)
				
			return basetypes.any

		let value = tok.pops

		if value
			if value.match('index')
				return [inferType(value.start.prev),'0']

			if value.match('args')
				let res = type(signature(inferType(value.start.prev)))
				return res

			if value.match('array')
				# console.log 'found array!!!',tok.pops
				return arraytype(basetypes.any)
				
			if value.match('parens')
				return inferType(value,doc,tok)

		if tok.match('tag.event.start')
			return 'ImbaEvents'

		if tok.match('tag.event.name')
			# maybe prefix makes sense to keep after all now?
			return ['ImbaEvents',tok.value]

		if tok.match('tag.event-modifier.start')
			# maybe prefix makes sense to keep after all now?
			return [['ImbaEvents',tok.context.name],'MODIFIERS']
			# return ['ImbaEvents',tok.value]
		
		# if this is a call
		if typ == ')' and tok.start
			return [inferType(tok.start.prev),'!']

		if tok.match('number')
			return basetypes.number

		elif tok.match('string')
			return basetypes.string

		if tok.match('operator.access')
			# devlog 'resolve before operator.oacecss',tok.prev
			return inferType(tok.prev,doc)

		if tok.type == 'self'
			# what if the selfPath doesnt work?
			return tok.context.selfScope.selfPath
		
		if tok.match('identifier.special')
			let argIndex = tok.value.match(/^\$\d+$/) and parseInt(tok.value.slice(1)) - 1
			let container = getThisContainer(tok)
			# console.warn "found arg index!!!",argIndex,container
			if argIndex == -1
				return resolve('arguments',container)

			return checker.getContextualTypeForArgumentAtIndex(container,argIndex)
			

		if tok.match('identifier')
			# what if it is inside an object that is flagged as an assignment?			
			if tok.value == 'global'
				return 'globalThis'
				
				
			if !sym or !sym.desc..datatype
				# check if sym and sym has datatype(!)
				let otok = tok.#otok = findExactLocationForToken(tok)
				util.log('found exact token for identifier?!',tok,otok)
				
				if otok
					return tok.#otyp = checker.getTypeAtLocation(otok)

			if !sym
				let scope = tok.context.selfScope

				if tok.value == 'self'
					return scope.selfPath

				let accessor = tok.value[0] == tok.value[0].toLowerCase!
				if accessor
					util.log('selfPath?',scope.selfPath)
					return [scope.selfPath,tok.value]
				else
					# need to resolve locally though
					return type(self.local(tok.value))
			
			# type should be resolved at the location it is in(!)
			
			return resolveType(sym,doc,tok)

		if tok.match('accessor')
			# let lft = tok.prev.prev
			return [inferType(tok.prev,doc),tok.value]
			

	def resolveType tok, doc, ctx = null
		let paths = inferType(tok,doc,ctx)
		return type(paths)
		
	def findExactLocationForToken token
		if typeof token == 'number'
			token = script.doc.tokenAtOffset(token)
		try
			# see if it has moved since before
			let dpos = token.endOffset
			let ipos = mapper.d2i(dpos)
			let opos = mapper.i2o(ipos)
			let otok = ts.findPrecedingToken(opos,sourceFile)

			if ipos == dpos and otok
				# util.log 'location has not changed',dpos,ipos,opos,otok
				return otok
				# see if it is the same type as well
			return null
					
	def findExactSymbolForToken dtok
		let otok = findExactLocationForToken(dtok)
		if otok
			return checker.getSymbolAtLocation(otok)
		return null
	
	# type at imba location	
	def typeAtLocation offset
		let tok = script.doc.tokenAtOffset(offset)
		# let ctx = script.doc.getContextAtOffset(offset)
		util.log('typeAtLocation',offset,tok)
		# let loc = getLocation(offset)
		let inferred = inferType(tok,script.doc,tok)
		return inferred