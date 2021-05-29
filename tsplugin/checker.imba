export default class ImbaTypeChecker
	
	constructor program, checker, script
		program = program
		checker = checker
		script = script
	
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
		
	get cssrule
		#cssrule ||= checker.getDeclaredTypeOfSymbol(cssmodule.exports.get('css$rule'))
		# #cssrule ||= checker.getTypeOfSymbolAtLocation(cssmodule.exports.get('s'),cssmodule.valueDeclaration)
	
	get csstypes
		#csstypes ||= checker.getTypeOfSymbolAtLocation(cssmodule.exports.get('css$types'),cssmodule.valueDeclaration)
		
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
		return out
	
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

	def resolve name,types = ts.SymbolFlags.All
		if (/^\$\w+\$$/).test(name)
			return self[name.slice(1,-1)]

		let sym = checker.resolveName(name,#location or loc(#file),symbolFlags(types),false)
		return sym
		
	def parseType string, token, returnAst = no
		
		string = string.slice(1) if string[0] == '\\'
		if let cached = #typeCache[string]
			return cached
		
		let ast
		try
			ast = ts.parseJSDocTypeExpressionForTests(string,0,string.length).jsDocTypeExpression.type
			ast.resolved = resolveTypeExpression(ast,{text: string},token)
			return ast if returnAst
			return #typeCache[string] = ast.resolved
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
		
		
	

	def local name, target = #location, types = ts.SymbolFlags.All
		let sym = checker.resolveName(name,loc(target or #file),symbolFlags(types),false)
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

	def loc item
		return undefined unless item
		if typeof item == 'number'
			return ts.findPrecedingToken(item,loc(#file))
		if item.fileName
			return program.getSourceFile(item.fileName)
		if item isa SymbolObject
			return item.valueDeclaration
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
				item.#instanceType ||= checker.getDeclaredTypeOfSymbol(item)
				
				unless item.flags & ts.SymbolFlags.Value
					return item.#instanceType

			item.#type ||= checker.getTypeOfSymbolAtLocation(item,item.valueDeclaration or loc(#file or #blank))
			return item.#type

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
			return null unless resolvedType.members
			sym = resolvedType.members.get('__@iterator')
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