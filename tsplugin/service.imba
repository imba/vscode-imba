import np from 'path'
import Compiler from './compiler'
import * as util from './util'
import Bridge from './bridge'
import ipc from 'node-ipc'

let libDir = np.resolve(__realname,'..','..','..','lib')

global.dirPaths = [__dirname,__filename,__realname]
global.libDir = libDir



export default class Service
	setups = []
	bridge = null
	ipcid
	
	get ts
		global.ts
	
	get configuredProjects
		Array.from(ps.configuredProjects.values())
		
	get cp
		configuredProjects[0]
		
	get ip
		ps.inferredProjects[0]
		
	def i i
		let d = m.im.doc
		let t = m.im.getTypeChecker!
		return {
			i: i
			d: d
			t: t
			c: d.getContextAtOffset(i)
			x: t.getMappedLocation(i)
		}
		
	def getCompletions file,pos,ctx
		let script = getImbaScript(file)
		util.log('ipc_getCompletions',file,pos,ctx,script)
		let res = #lastCompletions = script.getCompletions(pos,ctx)
		return res.serialize!
		
	def resolveCompletionItem item, data
		util.log('resolveCompletionItem',item,data)
		if let ctx = #lastCompletions
			if let item = ctx.items[data.nr]
				item.resolve!
				return item.serialize!
		return 
		
		
	def handleRequest {id,data}
		util.log('handleRequest',data)
		bridge ||= new Bridge(id)
		bridge.handle(data)
		# 	ipcid = id

		# if data.type == 'event'
		# 	util.log('event_' + data.event,data.body)
		# 	if data.event == 'ready'
		# 		connectToBridge!
		# 		yes
		# 		# ipc.connectTo
	
	# def connectToBridge
	# 	ipc.connectTo(ipcid) do
	# 		util.log('ipc','connected!')
	# 		ipc.of[ipcid].on('hello') do
	# 			util.log('ipc','hello!!',arguments)

	def create info
		util.log('create',info)
		setups.push(info)

		self.info = info
		self.project = info.project
		self.ps = project.projectService
		
		let proj = info.project
		
		let inferred = proj isa ts.server.InferredProject
		# intercept options for inferred project
	
		if proj
			let opts = proj.getCompilerOptions!
			let libs = opts.lib or ["esnext","dom","dom.iterable"]

			# opts = {
			# 	...opts,
			# 	lib: libs.concat([np.resolve(libDir,'imba.d.ts')])
			# }
			
			opts.lib =  libs.concat([np.resolve(libDir,'imba.d.ts')])
			
			if inferred
				opts.checkJs = true

			for lib,i in opts.lib
				let mapped = ts.libMap.get(lib)
				if mapped
					opts.lib[i] = mapped

			proj.setCompilerOptions(opts)
			util.log('compilerOptions',proj,opts)
			
		setup! if ps.#patched =? yes
			
		info.ls = info.languageService
		# for debugging
		global.m = self.m

		return decorate(info.languageService)
		
	def convertSpan span, ls, filename, kind = null
		if util.isImba(filename) and span.#ostart == undefined
			span.#ostart = span.start
			span.#olength = span.length
			let mapper = ls.getProgram!.getSourceFile(filename)
			let [start,end] = mapper.o2d(span)
			span.start = start
			span.length = end - start
		return span
		
		
	def convertLocationsToImba res, ls, filename
		if res isa Array
			for item in res
				convertLocationsToImba(item,ls,item.fileName)
		
		if !res
			return res

		if util.isImba(filename)
			for key in ['text','context','trigger','applicable']
				if let span = res[key + 'Span']
					convertSpan(span,ls,filename,key)
			# if res.textSpan
			# 	convertSpan(res.textSpan,ls,filename,'text')
			# if res.contextSpan
			# 	convertSpan(res.contextSpan,ls,filename,'context')
			# if res.triggerSpan
			# 	convertSpan(res.triggerSpan,ls,filename,'trigger')
			# if res.applicableSpan
			# 	convertSpan(res.applicableSpan,ls,filename,'trigger')
			if res.textChanges
				for item in res.textChanges
					convertSpan(item.span,ls,filename,'edit')
		
		if res.changes
			convertLocationsToImba(res.changes, ls,filename)
			
		if res.definitions
			for item in res.definitions
				convertLocationsToImba(item,ls,item.fileName or item.file)

		return res
		
	def getFileContext filename, pos, ls
		let script = getImbaScript(filename)
		let opos = script ? script.d2o(pos,ls.getProgram!) : pos
		return {script: script, filename: filename, dpos: pos, opos: opos}
		
		
	def decorate ls
		if ls.#proxied
			return ls

		let intercept = Object.create(null)
		ls.#proxied = yes
		# no need to recreate this for every new languageservice?!
		
		intercept.getEncodedSemanticClassifications = do(filename,span,format)
			if util.isImba(filename)
				let script = getImbaScript(filename)
				let spans = script.getSemanticTokens!
				return {spans: spans, endOfLineState: ts.EndOfLineState.None}

			return ls.getEncodedSemanticClassifications(filename,span,format)
		
		intercept.getEncodedSyntacticClassifications = do(filename,span)
			return ls.getEncodedSyntacticClassifications(filename,span)
			
		intercept.getQuickInfoAtPosition = do(filename,pos)
			let {script,dpos,opos} = getFileContext(filename,pos,ls)
			if script
				# let convpos = script.d2o(pos,ls.getProgram!)
				let out = script.getQuickInfo(dpos,ls)
				util.log('getQuickInfo',filename,dpos,opos,out)
				if out
					return out
				
				# pos = convpos

			let res = ls.getQuickInfoAtPosition(filename,opos)
			return convertLocationsToImba(res,ls,filename)
			
		intercept.getDefinitionAndBoundSpan = do(filename,pos)
			let {script,dpos,opos} = getFileContext(filename,pos,ls)
			let res = ls.getDefinitionAndBoundSpan(filename,opos)
			res = convertLocationsToImba(res,ls,filename)
			util.log('getDefinitionAndBoundSpan',script,dpos,opos,filename,res)
			return res
			
		intercept.getDocumentHighlights = do(filename,pos,filesToSearch)
			return if util.isImba(filename)
			return ls.getDocumentHighlights(filename,pos,filesToSearch)
			
			
		intercept.getRenameInfo = do(file, pos, o = {})
			# { allowRenameOfImportPath: this.getPreferences(file).allowRenameOfImportPath }
			let {script,dpos,opos} = getFileContext(file,pos,ls)
			let res = convertLocationsToImba(ls.getRenameInfo(file,opos,o),ls,file)
			
			return res
			
		intercept.findRenameLocations = do(file,pos,findInStrings,findInComments,prefs)
			let {script,dpos,opos} = getFileContext(file,pos,ls)
			let res = ls.findRenameLocations(file,opos,findInStrings,findInComments,prefs)
			res = convertLocationsToImba(res,ls)
			return res
			# (location.fileName, location.pos, findInStrings, findInComments, hostPreferences.providePrefixAndSuffixTextForRename)
		
		intercept.getEditsForFileRename = do(oldPath, newPath, fmt, prefs)
			let res = ls.getEditsForFileRename(oldPath, newPath, fmt, prefs)
			res = convertLocationsToImba(res,ls)
			return res
		
		intercept.getSignatureHelpItems = do(file, pos, args)
			let {script,dpos,opos} = getFileContext(file,pos,ls)
			let res = ls.getSignatureHelpItems(file,opos,args)
			res = convertLocationsToImba(res,ls,file)
			return res
		
		intercept.getCompletionsAtPosition = do(file,pos,prefs)
			let {script,dpos,opos} = getFileContext(file,pos,ls)
			
			if script
				let res = script.getCompletionsAtPosition(ls,[dpos,opos],prefs)
				return res

			let res = ls.getCompletionsAtPosition(file,opos,prefs)
			return res
		
		# (
		#     fileName: string,
		#     position: number,
		#     entryName: string,
		#     formatOptions: FormatCodeOptions | FormatCodeSettings | undefined,
		#     source: string | undefined,
		#     preferences: UserPreferences | undefined,
		#     data: CompletionEntryData | undefined,
		# )
		
		intercept.getCompletionEntryDetails = do(file,pos,name,fmt,source,prefs,data)
			let {script,dpos,opos} = getFileContext(file,pos,ls)
			
			
			let res = ls.getCompletionEntryDetails(file,opos,name,fmt,source,prefs,data)
			return res


		intercept.getCodeFixesAtPosition = do(file,start,end,code,fmt,prefs)
			let {script,dpos,opos} = getFileContext(file,start,ls)
			let {opos: endopos} = getFileContext(file,end,ls)

			let res = ls.getCodeFixesAtPosition(file,opos,endopos,code,fmt,prefs)
			res = convertLocationsToImba(res,ls,file)
			return res

		if true
			for own k,v of intercept
				let orig = v
				intercept[k] = do
					try
						let res = v.apply(intercept,arguments)
						util.log(k,arguments,res)
						return res
					catch e
						util.log('error',k,e)

		
		return new Proxy(ls, {get: do(target,key) return intercept[key] || target[key]})
	
	def rewriteInboundMessage msg
		msg
		
	def setup
		for script in imbaScripts
			script.wake!
		self
	
	def getScriptInfo src
		ps.getScriptInfo(resolvePath(src))
		
	def getImbaScript src
		getScriptInfo(src)..im
	
	def getSourceFile src
		let info = getScriptInfo(src)
		info..cacheSourceFile..sourceFile
		
	get scripts
		Array.from(ps.filenameToScriptInfo.values())
		
	get imbaScripts
		# scripts.filter(do(script) util.isImba(script.fileName)).map(do(script) script.imba)
		scripts.map(do $1.#imba).filter(do $1)

	get cwd
		#cwd ||= normalizePath(process.env.VSCODE_CWD or process.env.IMBASERVER_CWD)
	
	get m
		getScriptInfo('main.tsimba')
			
	get u
		getScriptInfo('util.tsimba')
	
	def getExt src
		src.substr(src.lastIndexOf("."))

	def normalizePath src
		src.split(np.sep).join(np.posix.sep)
		
	def resolvePath src
		normalizePath(np.resolve(cwd,src || '__.js'))