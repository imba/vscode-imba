var path = require 'path'
var fs = require 'fs'

export var snippets = [
	
]

console.log 'snippets?',fs.readdirSync(path.resolve(__dirname,'snippets'))
let dir = path.resolve(__dirname,'snippets')
for file in fs.readdirSync(dir)
	
	let src = path.resolve(dir,file)
	let body = fs.readFileSync(src,'utf8')
	let parts = file.replace('.imba','').split('.')
	let name = parts.shift()
	let scopes = parts.filter(do $1[0] != '-')
	let exclude = parts.filter(do $1[0] == '-').map(do $1.slice(1))
	snippets.push({name: name, body: body, scopes: scopes, excludes: exclude})

console.log 'snippets',snippets