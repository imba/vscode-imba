export const SemanticTokenTypes = [
	'variable'
]

export const SemanticTokenModifiers = [
	'root'
	'class'
	'method'
	'flow'
]

###
tokenTypesLegend.forEach((tokenType, index) => tokenTypes.set(tokenType, index));

const tokenModifiersLegend = [
	'declaration', 'documentation', 'readonly', 'static', 'abstract', 'deprecated',
	'modification', 'async'
];
tokenModifiersLegend.forEach((tokenModifier, index) => tokenModifiers.set(tokenModifier, index));
###