let keyword2easing = {
	'linear': '0,0,1,1',
	'ease': '0.25,0.1,0.25,1',
	'ease-in': '0.42,0,1,1',
	'ease-out': '0,0,0.58,1',
	'ease-in-out': '0.42,0,0.58,1'
}

let cached = {}

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

let types = {
	'easing': easing
	'color': color
}

export def uri input
	input = input.split("\n").map(do $1.trim!).join('')
	return 'data:image/svg+xml;utf8,' + global.encodeURIComponent(input)

export def md type,...params
	if types[type]
		return uri(types[type](...params))
	return ""
