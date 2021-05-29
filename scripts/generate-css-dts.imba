import data from '../tsplugin/css/data.json'
import {aliases} from 'imba/src/compiler/styler'
import * as theme from 'imba/src/compiler/theme'


import fs from 'fs'

def run
	let out = ""
	let props = []
	let types = {}
	let pre = ''
	
	
	let w = do(ln)
		out += pre + ln + '\n'
	
	let idify = do(str)
		str.replace(/\-/g,'_')
	
	let ind = do(wrap,cb)
		w(wrap + ' {') if wrap
		pre += '\t'
		cb()
		pre = pre.slice(0,-1)
		w('}') if wrap
		
	let push = do(wrap)
		w(wrap + ' {') if wrap
		pre += '\t'
	
	let pop = do(wrap)
		pre = pre.slice(0,-1)
		w('}\n')
		
	let skip = do(item)
		return yes if item.name.match(/^-(ms|moz|webkit|o)-/)
		return no
		
	let propmap = {}
	for item in data.properties
		propmap[item.name] = item
		
	for own alias,to of aliases
		let target = propmap[to]
		if target
			target.alias = alias
		
	push 'declare module "imba_css"'
	for item in data.properties
		continue if skip(item)
		let typ = item.id = idify(item.name)
		push("interface {typ}")
		for {name,description} in item.values
			continue if name.match(/['",]/)
			if description
				w("/** {description} */")
			w("'{name}': {typ}\n")
		pop!
		
		# push("interface prop_{typ}")
		# w("'{name}': {typ}\n")
	
	push("interface css$rule")
	for item in data.properties
		continue if skip(item)
		w('/**')
		w(item.description)
		
		if item.alias
			w "@alias {item.alias}"
		w('*/')
		w("'{item.name}'():void;")
		if item.alias
			w("/** @alias {item.name} */")
			w "'{item.alias}'():void;"
		
	pop!
	pop!
	console.log out
	fs.writeFileSync('../lib/css.d.ts',out)
	
run!