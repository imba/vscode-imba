let keyword2easing = {
	'linear': '0,0,1,1',
	'ease': '0.25,0.1,0.25,1',
	'ease-in': '0.42,0,1,1',
	'ease-out': '0,0,0.58,1',
	'ease-in-out': '0.42,0,0.58,1'
}

let cached = {}

const types = {}

def types.rd input
	let rd = parseInt(input)
	let svg = `<svg width="120" height="120" viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect width="120" height="120" fill="rgba(0,0,0,0)"/>
<rect x="10" y="10" width="100" height="100" rx="{rd}" fill="#868686" fill-opacity="0.3"/>
</svg>`
	return svg

def types.fs value
	return `<svg width="120" height="120" viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect x="10" y="10" width="100" height="100" rx="10" fill="#868686" fill-opacity="0.1"/>
<text fill="#8AB9FF" xml:space="preserve" style="white-space: pre" font-family="Arial" font-size="{parseInt(value)}" font-weight="500" letter-spacing="0em" text-anchor="middle" dominant-baseline="middle"><tspan x="50%" y="50%">Aa</tspan></text>
</svg>
`

def types.bxs value
	return `<svg width="316" height="120" viewBox="0 0 316 120" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect x="8" y="8" width="300" height="104" rx="4" fill="#e2e8f0" fill-opacity="1" style=""/>
<foreignObject xmlns="http://www.w3.org/2000/svg" x="30" y="30" width="256" height="60" style="&#10;    overflow: visible;&#10;    display: block;&#10;    background: #FFF;border-radius: 10px;&#10;box-shadow: {value};&#10;&#10;">
    <div></div>
</foreignObject>
</svg>`

export def color input
	let key = String(input)
	if cached[key]
		return cached[key]

	let o = {
		w: 120
		h: 120
		p: 10
	}

	let markup = `<svg width="240" height="120" viewBox="0 0 240 120" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect width="240" height="120" fill="white"/>
<rect width="120" height="120" fill="black"/>
<rect x="120" width="120" height="120" fill="white"/>
<rect x="135" y="15" width="90" height="53" fill="#FF0000"/>
<rect x="15" y="15" width="90" height="53" fill="#FF0000"/>
<text fill="#FF0000" xml:space="preserve" style="white-space: pre" font-family="Roboto" font-size="24" font-weight="500" letter-spacing="0em"><tspan x="165" y="99.2031">Aa</tspan></text>
<text fill="#FF0000" xml:space="preserve" style="white-space: pre" font-family="Roboto" font-size="24" font-weight="500" letter-spacing="0em"><tspan x="45" y="99.2031">Aa</tspan></text>
</svg>`
	markup = markup.replace(/#FF0000/g,key)
	markup = markup.replace(/Roboto/g,"Arial")
	return cached[key] = markup



/* Returns code for the cubic-bezier preview (as an SVG image) */
export def easing input
	if cached[input]
		return cached[input]

	let o = {
		w: 120
		h: 120
		p: 10
	}

	let easingFunction = input.toLowerCase!.trim!.replace(';','').replace(':','')
	let curvePoints = keyword2easing[easingFunction] || easingFunction.replace('cubic-bezier(', '')
	let curve = curvePoints.split(',')

	let ps = 100
	let points = curve.map(do parseFloat($1) * ps)
	let x1 = points[0]
	let y1 = ps - points[1]
	let x2 = points[2]
	let y2 = ps - points[3]

	o.path = `M0,{ps} C{x1},{y1} {x2},{y2} {ps},0`

	let markup = `
		<svg version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" viewBox="0 0 (o.w) (o.h)" width="(o.w)px" height="(o.h)px">
		<style type="text/css">
			svg \{
				background-color: transparent;
				color: red;
			}
			path \{
				fill: none;
				stroke: #63B3ED;
				stroke-width: 2;
				stroke-miterlimit: 10;
			}
			rect \{
				stroke: rgba(255,255,255,0.2);
				stroke-width: 1;
				fill:rgba(255,255,255,0.005);
			}
		</style>
		<g transform="translate(10,10)">
			<rect width="{ps}" height="{ps}"/>
			<path class="st0" d="{o.path}"/>
		</g>
	</svg>`

	markup = markup.replace(/\(o\.(\w+)\)/g) do o[$2]
	return cached[input] = markup

types.easing = easing
types.color = color

export def uri input
	input = input.split("\n").map(do $1.trim!).join('')
	return 'data:image/svg+xml;utf8,' + global.encodeURIComponent(input)

export def md type,...params
	if types[type]
		return uri(types[type](...params))
	return ""
