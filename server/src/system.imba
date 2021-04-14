import fs from 'fs'

export def readFile path, encoding\string = 'utf8'
	fs.readFileSync(path,{encoding: encoding})

export class System
	def readFile path, encoding\string = 'utf8'
		fs.readFileSync(path,{encoding: encoding})

	def fileExists path
		fs.existsSync(path)

	def getDirectories dir
		let items = fs.readdirSync(dir,withFileTypes: true)
		console.log 'getDirectories!',dir
		let dirs = items.filter do $1.isDirectory!
		return dirs.map do $1.name

	def readDirectory dir,...params
		let [extensions,exclude,include,depth] = params
		console.log 'will read dir!',dir,params
		let matches = []
		let read = do(dir)
			let files = fs.readdirSync(dir)
			console.log 'found files',files
			return files

		# let res = ts.sys.readDirectory(dir,...params)
		console.log 'read dir?!',dir,params,res
		return read(dir)

export default new System