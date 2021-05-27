import np from 'path'
import Compiler from './compiler'
import * as util from './util'

const compilerOptions = {
	checkJs: true # only check the imba js?!
}

export default class Service

	get ts
		global.ts
	
	def create info
		self.info = info
		self.project = info.project
		self.ps = project.projectService

		let opts = project.getCompilerOptions!
		self.project.setCompilerOptions {...opts, ...compilerOptions}
		
		setup! if ps.#patched =? yes

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
			if res.textSpan
				convertSpan(res.textSpan,ls,filename,'text')
			if res.contextSpan
				convertSpan(res.contextSpan,ls,filename,'context')
			if res.triggerSpan
				convertSpan(res.triggerSpan,ls,filename,'trigger')
			if res.textChanges
				for item in res.textChanges
					convertSpan(item.span,ls,filename,'edit')

		if res.definitions
			for item in res.definitions
				convertLocationsToImba(item,ls,item.fileName or item.file)

		return res
		
	def getFileContext filename, pos, ls
		let script = getImbaScript(filename)
		let opos = script ? script.d2o(pos,ls.getProgram!) : pos
		return {script: script, filename: filename, dpos: pos, opos: opos}
		
		
	def decorate ls
		let intercept = Object.create(null)
		
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
			let script = getImbaScript(filename)
			if util.isImba(filename)
				let convpos = script.d2o(pos,ls.getProgram!)
				util.log('getQuickInfo',filename,pos,convpos)
				pos = convpos

			let res = ls.getQuickInfoAtPosition(filename,pos)
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
		getScriptInfo(src).#imba
	
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