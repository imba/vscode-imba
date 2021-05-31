import data from '../tsplugin/css/data.json'
import {aliases,StyleTheme} from 'imba/src/compiler/styler'
import * as theme from 'imba/src/compiler/theme'
import fs from 'fs'

import {reference,parser,propertyReference} from './css-syntax-parser'

# https://github.com/gauthier-scano/CSSFormalSyntaxParser/blob/main/src/reference.js

const styles = new StyleTheme({})
const colorDescs = {
	current: 'The current color'
	transparent: 'Clear'
	clear: 'Clear'
}
const formatCache = {}
def getType format
	let parsed = parser.prototype.parseSyntax(format)
	parsed = parsed.as[0] if parsed.name == ' '
	
	formatCache[format] ||= if true
		let parsed = parser.prototype.parseSyntax(format)
		parsed = parsed.as[0] if parsed.name == ' '

		{
			maxlen: (parsed.quantity or [1,1])[1]
			desc: format
		}

def run
	let pdeep = do(val)
		if val isa Array
			for v in val
				pdeep(v)
			return
		console.log(val.name,val.quantity,val.isRequired,val.value)
		if val.as
			pdeep(val.as)

	let p = do(val)
		let parsed = parser.prototype.parseSyntax(val)
		if parsed.name == ' '
			parsed = parsed.as[0]
			
		

		console.log val, parsed, getType(val)
		# ,parsed,parsed.as[0]
		# pdeep(parsed)
		
	let safeid = do(val)
		if val.indexOf('-') >= 0 or val.match(/^\d|[\ \-\+]/)
			"'{val}'"
		else
			val
	
	console.log safeid 'first baseline'
	# return
	# console.log parser.prototype.parseSyntax('<length> | <percentage> | auto')
	# console.log JSON.stringify(parser.prototype.parseSyntax(propertyReference.outline))
	p '[ otcolor || otstyle || otwidth ]{1,2}'
	p "bgsize#"
	p "cola | numa"
	p '[cola | numa]{1,3}'
	p "cola || numa"
	# return
	# return
	# return
	let out = ""
	let props = []
	let types = {}
	let pre = ''
	
	let manualdts = fs.readFileSync('../lib/imba.css.types.d.ts','utf8')
	let manualexports = {}
	manualdts.replace(/interface ([^\ ]+)/g) do(m,name)
		manualexports[name] = yes
		''
	
	
	
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
		return yes if item.skip
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
	
	
	let patterns = [
		[/^(box-(align|direction|flex|flex-group|orient|lines|pack))$/,skip: yes]
		[/^border-.+-width/,kind: 'BorderWidth']
		[/-(right|left|top|bottom|end|start)$/,side: yes]
		[/(padding|margin)/,{}]
	]
	
	let signgroups = {}
	
	for item in data.properties
		let signature = item.sign = propertyReference[item.name]
		
		if signature and signature != item.syntax
			console.log("signature {item.name} {signature} ||| {item.syntax}")
			
		item.type = try getType(item.sign or item.syntax)
		
		let group = signgroups[item.sign] ||= []
		group.push(item.name)
		
		for [pat,options] in patterns
			if pat.test(item.name)
				Object.assign(item,options)
	
	console.log "groups {Object.keys(signgroups).length}"

	for item in data.properties
		continue if skip(item)
		let id = idify(item.name)
		let typ = item.id = 'css$enum$' + idify(item.name)
		let pid = item.propid = 'css$prop$' + idify(item.name)

		let types = item.restrictions
		
		let argtypes = new Set
		
		if item.values..length
			argtypes.add(item.id)
		
		for entry in item.restrictions
			if entry == 'enum'
				argtypes.add(item.id)
			else
				let id = entry.split('(')[0]
				argtypes.add('css$' + idify(id))
				
		let alltypes = Array.from(argtypes)
		
		let sign = "val:{alltypes.join('|') or 'any'}"
		# if types.contains('enum')
		if item.values..length and !manualexports[typ]
			push("interface {typ}")
			for {name,description} in item.values
				continue if name.match(/['",]/)
				if description
					w("/** {description} */")
				w("{safeid name}: '{name}'\n")
			pop!
			
		let len = Math.min(item.type..maxlen or 1,4)
		let nr = 1
		
		while nr < len
			sign += ", arg{nr++}: any"

		# w("type csstype${id} = ")
		if !manualexports[item.propid]
			push("interface {item.propid} extends css$prop")
			w("/* {item.sign} */")
			w("set({sign}): void\n")
			pop!

	
	push("interface css$rule")
	for item in data.properties
		continue if skip(item)
		w('/**')
		w(item.description)
		w("@alias {item.alias}") if item.alias
		w('*/')
		w("{safeid item.name}:{item.propid};")

		if item.alias
			w("/** @proxy {item.name} */")
			w "{safeid item.alias}:{item.propid};"
		
	pop!
	pop!
	console.log out
	fs.writeFileSync('../lib/css.d.ts',out)
	
	for item in data.properties
		console.log item.name, item.syntax
	
run!