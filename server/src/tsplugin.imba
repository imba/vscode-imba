let ts = null
let initial = yes
let plugin = null
let lg = null
let logging = no

setTimeout(&,5000) do logging = yes

# console.info 'tsplugin.load'

def log ...params
	console.info(...params)

const globalCompilerOptions = {
	allowNonTsExtensions: true
	allowJs: true
}


const userPrefs = {
	includeCompletionsForModuleExports:true
	importModuleSpecifierPreference: "shortest"
	importModuleSpecifierEnding: "minimal"
	includePackageJsonAutoImports:"on"
	includeAutomaticOptionalChainCompletions:false
}

import np from 'path'

class PatchedHost
	
	def getScriptKind fileName
		
		if fileName.match(/\.tsimba/)
			console.log "get script kind {fileName} {ts.ScriptKind.TS}"
			return ts.ScriptKind.TS

		return ___getScriptKind(fileName)
		

	def getCompilationSettings
		let res = ___getCompilationSettings!
		console.log 'getCompilationSettings' + JSON.stringify(res)
		return { ...res, ...globalCompilerOptions }

class PatchedSystem
	
	# def getSupportedExtensions ...args
	# 	let res = ___getSupportedExtensions(...args)
	# 	console.log "supported?! {String(res)}"
	# 	return [".imba",...res]
		
	def fileExists path
		# lg.info("fileExists {path}")
		let res = ___fileExists(path)
		return res
		
	def readFile path,...args
		if path.match(/\log.imba$/)
			yes
		return ___readFile(path,...args)


def patchKind klass, target
	let keys = Object.getOwnPropertyNames(klass)
	console.log "PATCH KIND!!!",Object.keys(klass)
	console.log String(keys)
	
	for k in keys
		
		
		continue if k == 'constructor'
		# console.log "patching {k}"
		let orig = target[k]
		let patched = target["___{k}"]

		continue if patched
		
		if orig isa Function
			target["___{k}"] = orig
			target[k] = klass[k]
	return target
#
#		 = () => {
#    const projectConfig = getCompilationSettings.call(host);
#    const compilationSettings = { ...projectConfig, ...globalCompilerOptions };
#    return compilationSettings;
#  }

def patchLanguageServiceHost ts, host, log
	patchKind(PatchedHost.prototype,host)
	
def patchSystem ts, target, log
	patchKind(PatchedSystem.prototype,target)
	
def unquote str
	if str[0] == '"' and str[str.length - 1] == '"'
		return str.slice(1,-1)
	return str
	
let mainInfo = null

class Plugin
	infos = []
	changes = []
	
	constructor
		setup!
		
	def setup
		self
		
		
	def emit ev, data, ref = null
		let json = {type: 'event', event: ev, body: data, responseRef: ref}
		process.stdout.write(JSON.stringify(json) + '\r\n','utf-8')
		yes
		
	get project
		#info.project
		
	get service
		project.projectService
		
	get logger
		service.logger
		
	get program
		project.program
		
	get checker
		program.getTypeChecker!
		
	get ts
		ts
		
	get np
		np
		
	get host
		#info.languageServiceHost
		
	get languageService
		#info.languageService
		
	get serverHost
		#info.serverHost
	
	def log ...params
		logger.info(...params)
		
	def checkAutoImports
		yes
		
	get prefs
		userPrefs
		
	get cwd
		#cwd ||= normalizePath(process.env.VSCODE_CWD or process.env.IMBASERVER_CWD)
	
	def normalizePath src
		src.split(np.sep).join(np.posix.sep)
		
	def resolvePath src
		normalizePath(np.resolve(cwd,src || '__.js'))
		
	def getPackageJsonsVisibleToFile src = null
		service.getPackageJsonsVisibleToFile(resolvePath(src))
	
	def getVisiblePackages src = null
		let jsons = getPackageJsonsVisibleToFile(src)
		let packages = {}
		while let pkg = jsons.pop!
			let deps = Object.fromEntries(pkg.dependencies)
			let devDeps = Object.fromEntries(pkg.devDependencies or new Map)
			Object.assign(packages,deps,devDeps)
		return packages
		
	def discoverAutoImportPackages
		service.host.readDirectory(cwd,['.json'],['**/node_modules/**'],['**/package.json'],4)
		
	def getContext src = null, base = null
		src = resolvePath(src)
		# root should at least be the cwd
		base ||= host.getNearestAncestorDirectoryWithPackageJson(src)
		
		let path = src
		# see if file is already opened
		let project = service.getDefaultProjectForFile(path)
		unless project
			console.info "open file {path} in root {base}"
			service.openClientFile(path,"\n",ts.ScriptKind.JS,base)
			project = service.getDefaultProjectForFile(path,true)
		trackProject(project)

		{path: path, project: project, program: project.program, file: project.program.getSourceFile(path)}
		
	def resolveModuleName moduleName, src = null
		let {path,project} = getContext(src)
		let res = project.resolveModuleNames([moduleName],path)
		return res[0]
		
	def resolveModuleNames moduleNames, src = null, checkReal = no
		let {path,project} = getContext(src)
		# should be possible to look at the last cached cached imports for this root?
		let res = project.resolveModuleNames(moduleNames,path)
		if checkReal
			let real = project.autoImportProviderHost.resolveModuleNames(moduleNames,path)
			for item,i in real
				if res[i]
					res[i].autoImportMatch = item or false
			# console.info 'checked real',res,real
		return res
		
	def getAutoImports src = null
		let {project,program,file} = getContext(src)
		let entries = project.languageService.getCompletionsAtPosition(file.path,0,userPrefs).entries.filter do $1.source
		return entries
	
	def getSymbolToExportInfoMap src = null
		let {project,program,file} = getContext(src)
		let map = ts.codefix.getSymbolToExportInfoMap(file,project,program)
		return map
		
	def getModuleSpecifierForBestExportInfo info,file,program,project
		ts.codefix.getModuleSpecifierForBestExportInfo(info,file,program,project,prefs)
		
	def getResolvePathForExportInfo info
		if let ms = info.moduleSymbol
			let path = ms.valueDeclaration..fileName
			path ||= unquote(ms.escapedName or '')
			return path
		return null
		
	def getImportMap src = null, includeBuiltins = no, packageFilter = null
		let {project,program,file} = getContext(src)
		let map = getSymbolToExportInfoMap(src)

		let items = []
		let paths = items.paths = Object.create(null)
		let tree = items.tree = Object.create(null)
		for [key,info] of map
			let [name,ref,ns] = key.split('|')
			continue if ns != '/' and !includeBuiltins
			# let name = key.substring(0, key.indexOf("|"))			
			let best = getModuleSpecifierForBestExportInfo(info,file,program,project)
			best.ns = ns
			best.importName = name
			best.exportKind = best.exportInfo.exportKind
			best.exportIsTypeOnly = best.exportInfo.exportedSymbolIsTypeOnly
			best.isFromPackageJson = best.exportInfo.isFromPackageJson
			
			if packageFilter and !packageFilter[best.moduleSpecifier]
				continue	
			
			let path = "{best.moduleSpecifier}.{name}"
			paths[path] = best
			items.push(best)
			
			let group = tree[best.moduleSpecifier] ||= {
				resolved: ns == '/' ? getResolvePathForExportInfo(best.exportInfo) : null
				exports: {}
			}
			
			group.exports[name] = {
				name: name,
				importKind: best.importKind,
				exportKind: best.exportKind,
				isTypeOnly: best.exportIsTypeOnly
				isFromPackageJson: best.isFromPackageJson
			}

		return items
		
	def getAutoImportTree
		let items = getImportMap(null,true)
		return items.tree
		
		
	def getAutoImportsForFile src = null
		let packages = getVisiblePackages(src)
		let imports = getImportMap(src, no, packages)
		return imports
		
	def trackProject project
		return if project.#tracked
		project.#tracked = yes
		
		let marker = project.markAutoImportProviderAsDirty
		
		# only for this project
		project.setCompilerOptions({
			allowSyntheticDefaultImports: true,
			target: ts.ScriptTarget.ES2020,
			maxNodeModuleJsDepth: 3,
			moduleResolution: ts.ModuleResolutionKind.NodeJs,
			module: ts.ModuleKind.ESNext
		})
		
		let onPluginConfigurationChanged = project.onPluginConfigurationChanged

		project.onPluginConfigurationChanged = do(name, data)
			if name == 'imba'
				console.info "plugin update / communicate!",data
				if data.#handled =? yes
					handleRequest(data)
			else
				onPluginConfigurationChanged.apply(project,arguments)
		
		project.markAutoImportProviderAsDirty = do
			dirtyAutoImports(project)
			return marker.call(project)
			
		project.getPackageJsonsForAutoImport = do(rootDir = null)
			const added = {}
			const packageJsons = []
			
			for file in project.rootFiles
				let hits = project.getPackageJsonsVisibleToFile(file.fileName)
				for hit in hits
					if added[hit.fileName] =? yes
						packageJsons.push(hit)
		 
			this.packageJsonsForAutoImport = new Set(Object.keys(added))
			return packageJsons
		
	
	def dirtyAutoImports project
		# log "autoimports dirty!!", project
		changes.push(project)
		
	def handleRequest event
		# console.info 'handling request',event
		# respond with the same
		let res = {}
		
		if event.type == 'ping'
			res.pong = yes
		
		if self[event.type] isa Function
			res = self[event.type].apply(self,event.params or [])
		
		if event.requestRef
			emit('response',res,event.requestRef)
		
	
	def create info
		#info = info
		infos.push(info)
		trackProject(info.project)
		
		# mainInfo ||= info
		# console.log "TSIMBA.CREATE {mainInfo.project == info.project} {mainInfo.project.projectService == info.project.projectService}"
		# logger.info("tsimba.create")
		# logger.info JSON.stringify(process.env,null,2)
		const tls = info.languageService
		
		return tls
		
		const proxy = Object.create(null)
		
		# return tls unless process.env['IMBASERVER_CWD']
		
		for own k,v of tls
			# console.info "proxy {k}"
			# TODO fix actual proxy for this
			proxy[k] = do(...args)
				console.info "calling {k}",args
				# if k == 'getCompletionsAtPosition'
				# 	console.info JSON.stringify(arguments)
				return v.apply(tls,args)
				
		proxy.get

		return proxy

global.initingtls = yes

def init modules = {}
	ts = modules.typescript
	patchSystem(ts,ts.sys)
	# console.info 'tsplugin.init'
	global.gothere = yes
	global.ts = ts
	plugin ||= new Plugin
	global.ils = plugin
	return plugin

module.exports = init