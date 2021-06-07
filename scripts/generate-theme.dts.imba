import data from '../tsplugin/css/data.json'
import {aliases,StyleTheme} from 'imba/src/compiler/styler'
import * as theme from 'imba/src/compiler/theme'
import fs from 'fs'
import {Dts} from './util'

import {reference,parser,propertyReference} from './css-syntax-parser'

# https://github.com/gauthier-scano/CSSFormalSyntaxParser/blob/main/src/reference.js

const styles = new StyleTheme({})
const colorDescs = {
	current: 'The current color'
	transparent: 'Clear'
	clear: 'Clear'
}

def run
	let dts = new Dts
	
	dts.ind 'declare module "imba_css"' do
		
		# add colors first
		dts.ind 'interface css$color' do
			for own name,value of styles.palette
				continue if name.match(/^grey\d/)
				
				if colorDescs[name]
					dts.w "/** {colorDescs[name]} */"
					dts.w "{name}: '{name}';"
				else
					let hsla = "hsla({parseInt(value.h)},{parseInt(value.s)}%,{parseInt(value.l)}%,{parseFloat(value.a) / 100})"
					dts.w "/** @color {hsla} */"
					dts.w "{name}: '{hsla}';"
	
		dts.ind "interface css$font_size" do
			for own name,value of theme.variants.fontSize
				continue unless name.match(/[a-z]/)
				let size = value isa Array ? value[0] : value
				dts.w "/** {size} */"
				dts.w "'{name}': '{size}';"
	
	fs.writeFileSync('../lib/imba.css.theme.d.ts',String(dts))

	
run!