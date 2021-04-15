import {Component} from './Component'
import np from 'path'
import * as ts from 'typescript'

class ResolutionHost

	def constructor host
		#host = host
		#ils = host.#ils
		#hit = null

	def #reset
		#hit = null

	def getCurrentDirectory
		#ils.rootPath

	def readFile fileName
		#host.readFile(fileName)

	def fileExists fileName
		if fileName.match(/\.ts$/)
			for ext in ['.imba','']
				let src = fileName.replace(/(\.imba)?\.ts$/,ext)
				if src.match(/\.(imba1?|svg|jpe?g|gif|png|html|txt|css)$/) and #host.fileExists(src)
					#hit = {resolvedFileName: src,extension: ".ts"}
					return true

		#host.fileExists(fileName)


export default class Host < Component

	def constructor ils, options
		super
		#ils = ils
		#options = options
		#resolver = new ResolutionHost(self)
		#cache = {}
		#snapshots = {}

	def getScriptFileNames
		#ils.rootFiles

	def getProjectVersion
		String(#ils.version)
	
	def getTypeRootsVersion
		0

	def getNewLine
		'\n'
	
	def useCaseSensitiveFileNames
		yes

	def getDirectories ...params
		#ils.getDirectories(...params)

	def getCurrentDirectory
		#ils.rootPath

	def readDirectory ...params
		#ils.readDirectory(...params)
	
	def fileExists path
		#ils.fileExists(path)

	def readFile path
		#ils.readFile(path)

	def getCompilationSettings
		#options

	def getDefaultLibFileName options
		devlog 'getDefaultLibFileName',options
		if $web$
			return "/types/lib.dom.d.ts"
		ts.getDefaultLibFilePath(options)

	def getScriptVersion fileName
		# console.log 'getScriptVersion',fileName
		let version = #ils.files[fileName] ? String(#ils.files[fileName].version.toString()) : "1"
		return version

	def getScriptSnapshot fileName
		let ext = np.extname(fileName) or ''
		# console.log 'getScriptSnapshot',fileName
		# return undefined

		if ext.match(/\.(imba1?|svg|css|png|jpe?g)$/)
			# should be a rich file
			let file = #ils.getRichFile(fileName,yes)
			return file.getScriptSnapshot! if file
			return undefined

		if !fileExists(fileName)
			return undefined

		let snapshot = #snapshots[fileName] ||= ts.ScriptSnapshot.fromString(readFile(fileName).toString())
		return snapshot

	def getScriptKind fileName
		let file = #ils.files[fileName]

		if file
			return ts.ScriptKind.JS
		else
			return ts.getScriptKindFromFileName(fileName)
	
	def resolveModuleNames moduleNames,containingFile
		let results = []

		devlog 'resolving',moduleNames,containingFile,$0

		# let cached = #cache[containingFile]
		let dir = np.dirname(containingFile)

		# if cached
		# 	return cached

		results = for name of moduleNames
			#resolver.#reset!

			if name == 'imba/index' and $web$
				continue undefined
			
			if name.indexOf('data:text/asset') == 0
				continue undefined

			let key = "{dir}:{name}"
			if #cache.hasOwnProperty(key)
				continue #cache[key]

			# try to use standard resolution			
			name = name.replace(/\.imba$/,'').replace(/\?.+$/,'')
			let ext = np.extname(name)
			let result = ts.resolveModuleName(name, containingFile, #options, #resolver)
			let hit = #resolver.#hit || result.resolvedModule || undefined
			#cache[key] = hit

			# console.log 'tested',moduleName,context,result
			# if let hit = #resolver.#hit
			# 	{resolvedFileName: hit,extension: ".ts"}
			# else
			# 	result.resolvedModule || undefined

		devlog 'resolved',moduleNames,results
		return results