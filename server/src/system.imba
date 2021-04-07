import fs from 'fs'

export def readFile path, encoding\string = 'utf8'
	fs.readFileSync(path,{encoding: encoding})

export class System
	def readFile path, encoding\string = 'utf8'
		fs.readFileSync(path,{encoding: encoding})

	def fileExists path
		fs.existsSync(path)

export default new System