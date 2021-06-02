import * as util from './util'

const userPrefs = {
	includeCompletionsForModuleExports:true
	importModuleSpecifierPreference: "shortest"
	importModuleSpecifierEnding: "minimal"
	includePackageJsonAutoImports:"on"
	includeAutomaticOptionalChainCompletions:false
}

const ambientMap = {
	fs: 'fs'
	child_process: 'cp'
	os: 'os'
	crypto: 'crypto'
}

export default class AutoImportContext
	
	constructor c
		checker = c
		script = c.script
		self
		
	get ts
		global.ts
		
	get ils
		global.ils
		
	get ps
		global.ils.ps
		
	get exportInfoMap
		#exportInfoMap ||= ts.codefix.getSymbolToExportInfoMap(checker.sourceFile,checker.project,checker.program)
	
	get exportInfoEntries
		return #exportInfoEntries if #exportInfoEntries
		let map = exportInfoMap
		let out = #exportInfoEntries = []
		for [key,[info]] of map
			let [name,ref,ns] = key.split('|')
			continue if ns.match(/^imba_/)
			let path = getResolvePathForExportInfo(info) or ns
			info.modulePath = path
			info.packageName = getPackageNameForPath(path)
			info.#key = key
			info.exportName = name
			out.push(info)
		return out
			
	def getPackageNameForPath path
		let m
		if m = path.match(/\@types\/([\w\.\-]+)\/index\.d\.ts/)
			return m[1]
			
		if m = path.match(/\node_modules\/([\w\.\-]+)\//)
			return m[1]
		
		return path
		
	def getPackageJsonsVisibleToFile
		ps.getPackageJsonsVisibleToFile(script.fileName)
	
	def getVisiblePackages
		let jsons = getPackageJsonsVisibleToFile(script.fileName)
		let packages = {}
		while let pkg = jsons.pop!
			let deps = Object.fromEntries(pkg.dependencies)
			let devDeps = Object.fromEntries(pkg.devDependencies or new Map)
			Object.assign(packages,deps,devDeps)
		return packages
		
	def getModuleSpecifierForBestExportInfo info
		let result = ts.codefix.getModuleSpecifierForBestExportInfo(info,checker.sourceFile,checker.program,checker.project,userPrefs)
		return result
		
	def getResolvePathForExportInfo info
		if let ms = info.moduleSymbol
			let path = ms.valueDeclaration..fileName
			path ||= util.unquote(ms.escapedName or '')
			return path
		return null
		
	def getImportMap includeBuiltins = no, packageFilter = null
		let map = exportInfoMap

		let items = []
		let paths = items.paths = Object.create(null)
		let tree = items.tree = Object.create(null)
		for [key,info] of map
			let [name,ref,ns] = key.split('|')
			continue if ns != '/' and !includeBuiltins
			continue if ns.match(/^imba_/)
			# let name = key.substring(0, key.indexOf("|"))			
			let best = getModuleSpecifierForBestExportInfo(info)
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