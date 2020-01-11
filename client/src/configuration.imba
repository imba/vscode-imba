export var Configuration = {
	wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\$\-\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)|\w+(\-\w+)*/g,
	onEnterRules: [{
		beforeText: /^\s*(?:static def|export def|export default def|def|export class|export default class|extend class|class|export tag|extend tag|tag|for|if|elif|else|while|try|with|finally|except|async).*?$/,
		action: { indentAction: IndentAction.Indent }
	},{
		beforeText: /\s*(?:do)\s*(\|.*\|\s*)?$/,
		action: { indentAction: IndentAction.Indent }
	}]
}