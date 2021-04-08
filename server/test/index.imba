const p = console.log.bind(console)
import {Buffer} from 'buffer'
global.BUF = Buffer

# import Program from '../src/bundler/program'
import FileSystem from 'imba/src/bundler/fs'
import Cache from 'imba/src/bundler/cache'
import Program from 'imba/src/program/program'
import {LanguageServer} from '../src/LanguageServer'
# import {Volume} from 'memfs'
import memfs from 'fs'

global.ass = require('assert')

# import Runner from '../src/bundler/runner'
# import Bundler from '../src/bundler/bundle'
# import Cache from '../src/bundler/cache'
const base = "/project"

let ils = null

const conn = {
	sendDiagnostics: do yes
}

const vfs = {
	'./app.imba': 'import hello from "./other"'
	'./other.imba': 'export default 1000'
	'./arrow.svg': '<svg width="36px" height="36px" viewBox="0 0 36 36"><path></path></svg>'
}

def run
	const fs = memfs # Volume.fromJSON(vfs,base)
	global.fs = fs

	let res = await global.fetch('/files')
	let files = await res.json!

	console.log files

	if $web$
		fs.vol.fromJSON(files,base)

	const program = new Program({
		cwd: base
		cachedir: "/.imba-lsp-cache3"
		volume: fs
	})

	global.ils = ils = new LanguageServer(conn,null,{
		rootUri: 'file://' + base
		rootFiles: []
		debug: true
	})
	ils.config.update(verbose: yes)
	ils.start(ts: {
		lib: ['lib.dom.d.ts']
	})
	imba.mount <program data=ils>


tag program

	<self>
		<div>
			<h1 @click=render> "Files"
			<ul> for file in data.allFiles
				<li> file.imbaPath

tag code-file
	<self> <code innerHTML=JSON.stringify(data)>

run!