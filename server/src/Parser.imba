import * as monarch from '../vendor/monarch'
import { Component } from './Component'

const newline = String.fromCharCode(172)
const Token = monarch.Token

var names = 
	access: 'delimiter.access'
	ivar: 'variable.instance'
	constant: 'identifier.const'

# var eolpop = [/@newline/, token: '@rematch', next: '@pop']
var eolpop = [/^/, token: '@rematch', next: '@pop']

export var grammar = {
	defaultToken: 'white',
	ignoreCase: false,
	tokenPostfix: '',
	brackets: [
		{ open: '{', close: '}', token: 'delimiter.curly' },
		{ open: '[', close: ']', token: 'delimiter.square' },
		{ open: '(', close: ')', token: 'delimiter.parenthesis' }
	],
	keywords: [
		'def', 'and', 'or', 'is', 'isnt', 'not', 'on', 'yes', '@', 'no', 'off',
		'true', 'false', 'null', 'this', 'self',
		'new', 'delete', 'typeof', 'in', 'instanceof',
		'return', 'throw', 'break', 'continue', 'debugger',
		'if', 'elif', 'else', 'switch', 'for', 'while', 'do', 'try', 'catch', 'finally',
		'class', 'extends', 'super',
		'undefined', 'then', 'unless', 'until', 'loop', 'of', 'by', 'when',
		'tag', 'prop', 'export', 'import', 'extend',
		'var', 'let', 'const', 'require', 'isa', 'await'
	],
	boolean: ['true','false','yes','no','undefined']
	contextual_keywords: [
		'from', 'global', 'attr'
	],
	operators: [
		'=', '!', '~', '?', ':','!!',
		'&', '|', '^', '%', '<<',
		'>>', '>>>', '+=', '-=', '*=', '/=', '&=', '|=', '?=',
		'^=', '%=', '<<=', '>>=', '>>>=','..','...'
	],
	logic: [
		'>', '<', '==', '<=', '>=', '!=', '&&', '||','===','!=='
	],
	ranges: ['..','...'],
	dot: ['.'],
	math: [
		'+', '-', '*', '/', '++', '--'
	],

	# we include these common regular expressions
	symbols: /[=><!~?&%|+\-*\/\^\.,\:]+/,
	escapes: /\\(?:[abfnrtv\\"'$]|x[0-9A-Fa-f]{1,4}|u[0-9A-Fa-f]{4}|U[0-9A-Fa-f]{8})/,
	postaccess: /(:(?=\w))?/
	ivar: /\@[a-zA-Z_]\w*/
	constant: /[A-Z][A-Za-z\d\-\_]*/
	className: /[A-Z][A-Za-z\d\-\_]*|[A-Za-z\d\-\_]+/
	methodName: /[A-Za-z\_][A-Za-z\d\-\_]*\=?/
	identifier: /[a-z_][A-Za-z\d\-\_]*/
	variable: /[\w\$]+(?:-[\w\$]*)*/
	varKeyword: /var|let|const/
	newline: RegExp.new(newline)
	tagIdentifier: /-*[a-zA-Z][\w\-]*/
	
	regEx: /\/(?!\/\/)(?:[^\/\\]|\\.)*\/[igm]*/,
	
	regexpctl: /[(){}\[\]\$\^|\-*+?\.]/,
	regexpesc: /\\(?:[bBdDfnrstvwWn0\\\/]|@regexpctl|c[A-Z]|x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4})/,

	# The main tokenizer for our languages
	tokenizer: {
		root: [
			{ include: '@body' }
		],

		common: [
			{ include: '@whitespace' }
		]

		indents: [
			[/^(\t)(?!$)/,{
				cases: {

				}
			}]
		]

		expression: [
			{ include: 'do' }
			{ include: 'identifiers' }
			{ include: 'tag_start' },
			{ include: 'string_start' }
			{ include: 'regexp_start' }
			{ include: 'object_start' }
			{ include: 'array_start' }
			{ include: 'number' }
			{ include: 'comments' }
			{ include: 'common' }
			{ include: 'operators' }
			
			[/\(/, 'delimiter.parens.open', '@parens']
		]

		do: [
			[/(do)(\()/, [{token: 'keyword.$1'},{token: 'params.param.open', next: '@var_parens.param'}]],
		]

		scopes: [
			[/(def|get|set|if|unless|while|for|class|tag|do) /,token: '@rematch',next: 'scope.$1']
		]

		identifiers: [
			[/\$\w+\$/, 'identifier.env']
			[/\$\d+/, 'identifier.special']
			[/(@constant)/, 'identifier.constant']
			[/(@identifier)/,cases: {
				'this': 'variable.predefined.this',
				'self': 'variable.predefined.self',
				'$1@boolean': {token: 'boolean.$1'},
				'$1@keywords': {token: 'keyword.$1'},
				'@default': 'identifier'
			}],
			{include: 'type_start'}
		]

		type_start: [
			[/\\/, 'type.start','@type.0']
		]

		type: [
			eolpop
			[/\[/,'type','@type.]']
			[/\(/,'type','@type.)']
			[/\{/,'type','@type.}']
			[/\</,'type','@type.>']
			[/\,|\s/,{
				cases: {
					'$S2==0': { token: '@rematch', next: '@pop' }
					'@default': 'type'
				}
			}]
			[/[\]\}\)\>]/,{
				cases: {
					'$1==$S2': { token: 'type', next: '@pop' }
					'@default': { token: '@rematch', next: '@pop' }
				}
			}]
			[/[\w\-\$]+/,'type']
		]

		parens: [
			[/\)/, 'delimiter.parens.close', '@pop']
			{include: 'var_expr'}
			{include: 'expression'}
			[/\,/, 'delimiter']
		]

		statements: [
			{ include: 'var_statement' }
			{ include: 'forin_statement' }
			{ include: 'def_statement' }
			{ include: 'class_statement' }
			{ include: 'expression'}
		]

		var_statement: [
			[/(@varKeyword)(?=\s)/, 'keyword.$1', '@var_decl.$1']
		]

		var_expr: [
			[/(@varKeyword)(?=\s)/, 'keyword.$1', '@single_var_decl.$1']
		]

		var_parens: [
			[/\)/, 'params.$S2.close', '@pop']
			{include: 'var_decl'}
		]

		forin_statement: [
			[/for( own)? /, 'keyword', '@forin_var_decl']
		]

		def_statement: [
			[/(def|set|get)(\s)(@identifier)(\s)(?=\{|\w|\[)/, [{token: 'keyword.$1'},'white.propname',{token: 'identifier.$1.name'},{token: 'white.params', next: '@var_decl.param'}]],
			[/(def|set|get)(\s)(@identifier)(\()/, [{token: 'keyword.$1'},'white.propname',{token: 'identifier.$1.name'},{token: 'params.param.open', next: '@var_parens.param'}]],
		]

		class_statement: [
			[/(class)(\s)(@identifier)/, [{token: 'keyword.$1'},'white.classname',{token: 'identifier.$1.name'}]],
		]
		tag_statement: [
			[/(tag)(\s)(@identifier)(\s)(?=\{|\w|\[)/, [{token: 'keyword.$1'},'white.classname',{token: 'identifier.$1.name'}]],
		]

		object: [
			[/\{/, 'delimiter.bracket.open', '@object']
			[/\}/, 'delimiter.bracket.close', '@pop']
			[/(@identifier)/, 'identifier']
			{ include: 'common' }
			{ include: 'string_start' }
			{ include: 'comments' }
			[/:/,'delimiter.object.value','@object_value']
			[/,/,'delimiter']
		]

		object_start: [
			[/\{/, 'delimiter.bracket.open', '@object']
		]

		array_start: [
			[/\[/, 'array.open', '@array']
		]

		array: [
			[/\]/, 'array.close', '@pop']
			[/\,/, 'delimiter']
			{include: 'expression'}
		]

		expressions: [
			[/\,/, 'delimiter']
			{include: 'expression'}
			
		]

		var_object: [
			[/\{/, 'object.open', '@var_object']
			[/\}/, 'object.close', '@pop']
			[/(@identifier)/, token: 'variable.$S2']
			{ include: 'common' }
			[/,/,'delimiter']
		]

		var_array: [
			[/\{/, 'object.open', '@var_object']
			[/\}/, 'object.close', '@pop']
			[/\[/, 'array.open', '@var_array']
			[/\]/, 'array.close', '@pop']
			[/(@identifier)/, token: 'variable.$S2']
			{ include: 'common' }
			[/,/,'delimiter']
		]		

		object_value: [
			eolpop
			[/(?=,|\})/, 'delimiter', '@pop']
			{ include: 'expression' }
		]

		var_value: [
			eolpop
			[/(?=,|@newline|\))/, 'delimiter', '@pop']
			{ include: 'expression' }
		]

		var_decl: [
			eolpop
			[/(@variable)/,token: 'variable.$S2']
			[/\s*(=)\s*/,'operator','@var_value']
			[/\{/,'object.open','@var_object.$S2']
			[/\[/,'array.open','@var_array.$S2']
			[/,/,'delimiter']
			[/(,)(@newline)/,['delimiter','newline']]
			[/@newline/, token: '@rematch', next: '@pop']
			[/(?=\n)/,'delimiter','@pop']
			{ include: 'common' }
			{ include: 'type_start' }
			{ include: 'comments' }
		]

		var_params: [
			{ include: 'var_decl' }
		]

		single_var_decl: [
			[/(?=[,\)\]\n]|@newline)/, 'delimiter', '@pop']
			{include: 'var_decl'}
		]

		forin_var_decl: [
			[/\s(in|of)/,'keyword','@pop']
			{include: 'var_decl'}
		]
		
		body: [
			{include: 'statements'}
			[/@newline/,'newline']
			[/(class|tag)(?=\s)/, { token: 'keyword.$1', next: '@declstart.$1'}],
			[/(def|get|set)(?=\s)/, { token: 'keyword.$1', next: '@defstart.$1'}],
			[/(prop|attr)(?=\s)/, { token: 'keyword.$1', next: '@propstart.$1'}],
			[/(import)(?=\s)/, { token: 'keyword.$1', next: '@importstart.$1'}],

			[/([a-z]\w*)(:?(?!\w))/, {
				cases: {
					'$2': ['key.identifier','delimiter'],
					'this': 'variable.predefined.this',
					'self': 'variable.predefined.self',
					'$1@boolean': { token: 'boolean.$0' },
					'$1@keywords': { token: 'keyword.$0' },
					'$1@contextual_keywords': { token: 'identifier.$0' },
					'@default': ['identifier','delimiter']
				}
			}],

			# identifiers and keywords
			[/\@[a-zA-Z_]\w*/, 'variable.instance'],
			[/\$\w+\$/, 'identifier.env'],
			[/\$\d+/, 'identifier.special'],
			[/\$[a-zA-Z_]\w*/, 'identifier.sys'],
			[/[A-Z][A-Za-z\d\-\_]*/, token: 'identifier.const'],
			[/[a-z_][A-Za-z\d\-\_]*/, token: 'identifier'],

			[/\(/, { token: 'paren.open', next: '@parens' }],
			
			# whitespace
			{ include: '@whitespace' },
			
			# Comments
			[/### (javascript|compiles to)\:/, { token: 'comment', next: '@js_comment', nextEmbedded: 'text/javascript' }]

			{ include: '@comments' },
			[/(\:)([\@\w\-\_]+)/, ['symbol.start','symbol']],
			[/\$\d+/, 'entity.special.arg'],
			[/\&/, 'operator'],

			# regular expressions
			[/\/(?!\ )(?=([^\\\/]|\\.)+\/)/, { token: 'regexp.slash', bracket: '@open', next: '@regexp'}],

			[/}/, { cases: {
						'$S2==interpolatedstring': { token: 'string.bracket.close', next: '@pop' },
						'@default': '@brackets' } }],
			[/[\{\}\(\)\[\]]/, '@brackets'],
			{ include: '@operators' },
			
			# numbers
			{ include: '@number' },
			# delimiter: after number because of .\d floats
			[/\,/, 'delimiter.comma'],
			[/\./, 'delimiter.dot']
		],
		js_comment: [
			[/###/, token: 'comment', next: '@pop', nextEmbedded: '@pop']
		]

		string_start: [
			[/"""/, 'string', '@herestring."""'],
			[/'''/, 'string', '@herestring.\'\'\''],
			[/"/, { token: 'string.open', next: '@string."' }],
			[/'/, { token: 'string.open', next: '@string.\'' }],
			[/\`/, { token: 'string.open', next: '@string.\`' }],
		],
		unspaced_expr: [
			[/([a-z]\w*)(\:)(?=\w)/, {
				cases: {
					'this:': ['variable.predefined.this','delimiter.access'],
					'self:': ['variable.predefined.self','delimiter.access'],
					'@default': ['identifier','delimiter.access']
				}
			}]
			[/(@ivar)(\:)(?=\w)/, [names.ivar,names.access]]
			[/(@constant)(\:)(?=\w)/, [names.constant,names.access]]

		], 
		number: [
			[/\d+[eE]([\-+]?\d+)?/, 'number.float'],
			[/\d+\.\d+([eE][\-+]?\d+)?/, 'number.float'],
			[/0[xX][0-9a-fA-F]+/, 'number.hex'],
			[/0[0-7]+(?!\d)/, 'number.octal'],
			[/\d+/, 'number'],
		],
		operators: [
			[/@symbols/, { cases: {
						'@operators': 'operator',
						'@math': 'operator.math',
						'@logic': 'operator.logic',
						'@dot': 'operator.dot',
						'@default': 'delimiter'
					} }],
			[/\&\b/, 'operator']
		],
		whitespace: [
			[/[ \t\r\n]+/, 'white'],
		],

		comments: [
			[/###\s(css)/, {token: 'style.$1.open'}, '@style.$1'],
			[/###/, {token: 'comment.block.open'}, '@comment.block'],
			[/#(\s[^@newline]*)?$/, 'comment'],
			[/\/\/([^@newline]*)?$/, 'comment'],
		],

		comment: [
			[/[^#]+/, 'comment',]
			[/###/, {token: 'comment.$S2.close'}, '@pop']
			[/#/, 'comment']
		]

		style: [
			[/###/, {token: 'style.$S2.close'}, '@pop']
		]

		tag_start: [
			[/(<)(?=\.)/, 'tag.open','@tag.flag'],
			[/(<)(?=\w|\{|>)/,'tag.open','@tag.name']
		]

		tag: [
			[/>/,'tag.close','@pop']
			[/(@tagIdentifier)/,{token: 'tag.$S2'}]
			[/\./,{ cases: {
				'$S2==event': {token: 'tag.modifier.start', switchTo: 'tag.modifier'}
				'$S2==modifier': {token: 'tag.modifier.start', switchTo: 'tag.modifier'}
				'@default': {token: 'tag.flag.start', switchTo: 'tag.flag'}
			}}]
			[/(\s*\=\s*)/,token: 'tag.operator.equals', next: 'tag_value']
			[/\:/,token: 'tag.event.start', switchTo: 'tag.event']
			[/\{/,token: 'tag.$S2.braces.open', next: '@tag_interpolation.$S2']
			[/\[/,token: 'tag.data.open', next: '@tag_data']
			[/\s+/,token: 'white', switchTo: 'tag.attr']
		]
		
		tag_interpolation: [
			[/\}/,token: 'tag.$S2.braces.close', next: '@pop']
			{include: 'expression'}
			[/\)|\]/,token: 'invalid']
		]

		tag_data: [
			[/\]/,token: 'tag.data.close', next: '@pop']
			{include: 'expression'}
			[/\)|\]|\}/,token: 'invalid']
		]

		tag2: [
			[/\<\>/, { token: 'tag.empty' }],
			[/(<)([a-z][a-z\-\d]*(?:\:[A-Za-z\-\d]+)?)/, ['tag.open',{token: 'tag.name.tag-$2', next: '@tag_start'}]],
			[/(<)([A-Z][A-Za-z\-\d]*)/,['tag.open',{token: 'tag.name.local', next: '@tag_start'}]],
			[/(<)(?=[a-z\d\#\.\{\@])/, { token: 'tag.open', next: '@tag_start' }],
		],
		tag_singleton_ref: [
			[/\#(-*[a-zA-Z][\w\-]*)+/, 'tag.singleton.ref']
		],
		tag_parts: [
			[/\#(-*[a-zA-Z][\w\-]*)/, 'tag.id'],
			[/\.(-*[a-zA-Z][\w\-]*)/, 'tag.class'],
			[/\@(-*[a-zA-Z][\w\-]*)/, 'tag.iref'],
			[/[\#\.\@]\{/, { token: 'tag.interpolated.open', next: '@tag_inter' }],
		],
		tag_start2: [
			[/[ \t\r\n]+/, { token: 'white', switchTo: '@tag_content' }],
			{ include: 'tag_parts' },
			[/\[/, { token: 'tag.data.open', next: '@tag_data' }],
			[/[\=\-]?\>/, { token: 'tag.close', next: '@pop' }],
		],
		tag_inter: [
			['}', { token: 'tag.interpolated.close', next: '@pop' }],
			{ include: 'body' }
		],
		tag_data2: [
			[']', { token: 'tag.data.close', next: '@pop' }],
			{ include: 'body' }
		],
		tag_value: [
			[/(?=(\:?[\w]+\=))/, { token: '', next: '@pop' }],
			[/(?=(\>|\s))/, { token: '', next: '@pop' }],
			{include: 'expression'}
		]
		tag_content: [
			# [/(\:[a-zA-Z][\w\-]*)((?:\.[a-zA-Z][\w\-]*)+|)\s*(\=)\s*/, ['tag.attribute.listener','tag.attribute.modifier','tag.attribute'], '@tag_attr_value'],
			[/(\:[a-zA-Z][\w\-]*)((?:\.[a-zA-Z][\w\-]*)+)/,['tag.attribute.listener','tag.attribute.modifier']],
			
			[/(\:[a-zA-Z][\w\-]*)/, { token: 'tag.attribute.listener'}],
			# [/(\.[a-zA-Z\-][\w\-]*)/, { token: 'tag.class.conditional'}],
			[/([a-zA-Z\-][\w\-]*(\:[a-zA-Z][\w\-]*)?)/, { token: 'tag.attribute.name'}],
			# [/([\:][a-zA-Z][\w\-]*([\:\.][a-zA-Z][\w\-]*)*)\s*(\=)\s*/, { token: 'tag.attribute.listener', next: '@tag_attr_value' }],
			# [/([@\.]?[a-zA-Z][\w\-]*([\:\.][a-zA-Z][\w\-]*)*)\s*(\=)\s*/, { token: 'tag.attribute', next: '@tag_attr_value' }],
			
			{ include: 'tag_parts' },
			{ include: '@whitespace' },
			# ['>', { token: 'tag.close', next: '@pop' }],
			[/[\=\-]?\>/, { token: 'tag.close', next: '@pop' }],
			# [/\s*\=\s*(?!\>)/, { token: 'tag.attribute.operator', next: '@tag_attr_value' }],
			[/(\=)\s*/, { token: 'delimiter.eq.tag', next: '@tag_attr_value' }], # switch to rather?
			[/\(/, { token: 'paren.open.tag', next: '@tag_parens' }]
		],
		tag_attr_value: [
			[/(?=(\:?[\w]+\=))/, { token: '', next: '@pop' }],
			[/(?=(\>|\s))/, { token: '', next: '@pop' }],
			[/\(/, { token: 'paren.open', next: '@parens' }],
			[/\{/, { token: 'brace.open', next: '@braces' }]
			[/\[/, { token: 'bracket.open', next: '@brackets' }]
			{ include: 'body' },
			# { include: 'unspaced_expr'},
			# [/\(/, { token: 'paren.open', next: '@parens' }],
			# [/\{/, { token: 'brace.open', next: '@braces' }]
		],
		tag_parens: [
			[/\)/, { token: 'paren.close.tag', next: '@pop' }],
			[/(\))(\:?)/, ['paren.close.tag','delimiter.colon'], '@pop' ],
			{ include: 'body' }
		],
		importstart: [
			[/^./, token: '@rematch', next: '@pop'],
			[/(from|as)/, { token: 'keyword.$1'}],
			[/[\{\}\,]/, { token: 'keyword'}],
			[/"""/, 'string', '@herestring."""'],
			[/'''/, 'string', '@herestring.\'\'\''],
			[/"/, { token: 'string', next: '@string."' }],
			[/'/, { token: 'string', next: '@string.\'' }],
			[/[a-z_A-Z][A-Za-z\d\-\_]*/, token: 'identifier.import']
		]

		braces: [
			['}', { token: 'brace.close', next: '@pop' }],
			{ include: 'body' }
		],
		brackets: [
			[']', { token: 'bracket.close', next: '@pop' }],
			{ include: 'body' }
		],

		declstart: [
			[/^./, token: '@rematch', next: '@pop'],
			[/[A-Z][A-Za-z\d\-\_]*/, token: 'identifier.decl.$S2'],
			[/\./, token: 'delimiter.dot'],
			[/[a-z_][A-Za-z\d\-\_]*/, token: 'identifier.decl.$S2'],
			[/[ \t\<\>]+/, 'operator.inherits string']
		],

		defstart: [
			[/(self)\./, token: 'identifier.decl.def.self'],
			[/@methodName/, token: 'identifier.decl.def', next: '@pop'],
			[/^./, token: '@rematch', next: '@pop'],
		],

		propstart: [
			[/@identifier/, token: 'identifier.decl.$S2', next: '@pop'],
			[/^./, token: '@rematch', next: '@pop'],
		],
		
		string: [
			[/[^"'\`\{\\]+/, 'string'],
			[/@escapes/, 'string.escape'],
			[/\./, 'string.escape.invalid'],
			[/\./, 'string.escape.invalid'],
			[/\{/, { cases: {
				'$S2=="': { token: 'string.bracket.open', next: 'root.interpolatedstring' },
				'@default': 'string'
			}}],
			[/["'`]/, { cases: { '$#==$S2': { token: 'string.close', next: '@pop' }, '@default': 'string' } }],
			[/#/, 'string']
		],
		herestring: [
			[/("""|''')/, { cases: { '$1==$S2': { token: 'string', next: '@pop' }, '@default': 'string' } }],
			[/[^#\\'"\{]+/, 'string'],
			[/['"]+/, 'string'],
			[/@escapes/, 'string.escape'],
			[/\./, 'string.escape.invalid'],
			[/\{/, { cases: { '$S2=="""': { token: 'string', next: 'root.interpolatedstring' }, '@default': 'string' } }],
			[/#/, 'string']
		],
		
		hereregexp: [
			[/[^\\\/#]/, 'regexp'],
			[/\\./, 'regexp'],
			[/#.*$/, 'comment'],
			['///[igm]*', { token: 'regexp', next: '@pop' }],
			[/\//, 'regexp'],
		],

		regexp_start: [
			[/\/(?!\ )(?=([^\\\/]|\\.)+\/)/, { token: 'regexp.slash.open', bracket: '@open', next: '@regexp'}]
		]
		
		regexp: [
			[/(\{)(\d+(?:,\d*)?)(\})/, ['regexp.escape.control', 'regexp.escape.control', 'regexp.escape.control'] ],
			[/(\[)(\^?)(?=(?:[^\]\\\/]|\\.)+)/, ['regexp.escape.control',{ token: 'regexp.escape.control', next: '@regexrange'}]],
			[/(\()(\?:|\?=|\?!)/, ['regexp.escape.control','regexp.escape.control'] ],
			[/[()]/,        'regexp.escape.control'],
			[/@regexpctl/,  'regexp.escape.control'],
			[/[^\\\/]/,     'regexp' ],
			[/@regexpesc/,  'regexp.escape' ],
			[/\\\./,        'regexp.invalid' ],
			['/',           { token: 'regexp.slash.close', bracket: '@close'}, '@pop' ],
		],

		regexrange: [
			[/-/,     'regexp.escape.control'],
			[/\^/,    'regexp.invalid'],
			[/@regexpesc/, 'regexp.escape'],
			[/[^\]]/, 'regexp'],
			[/\]/,    'regexp.escape.control', '@pop'],
		],
	}
}

monarch.register('imba',grammar)

const ScopeTypes = {
	def:   {closure: yes, matcher: /(static)?\s*def ([\w\-\$]+\??)/}
	get:   {closure: yes, matcher: /(static)?\s*get ([\w\-\$]+\??)/}
	set:   {closure: yes, matcher: /(static)?\s*set ([\w\-\$]+\??)/}
	prop:  {closure: yes, matcher: /(static)?\s*prop ([\w\-\$]+\??)/}
	class: {closure: yes, matcher: /class ([\w\-]+)/ }
	tag:   {closure: yes, matcher: /tag ([\w\-]+)/ }
	do:    {closure: no}
	flow:  {closure: no}
	root:  {closure: yes}
	element: {closure: no}
	style: {closure: yes}
}

const TokenScopeTypes = {
	'tag.open': 'element',
	'style.css.open': 'style'
}

const TokenContextRules = [
	[/(def|set) [\w\$]+[\s\(]/,'params']
	[/(class) ([\w\-\:]+) <\s?([\w\-]*)$/,'superclass']
	[/(tag) ([\w\-\:]+) <\s?([\w\-]*)$/,'supertag']
	[/(def|set|get|prop|attr|class|tag) ([\w\-]*)$/,'naming']
	[/\<([\w\-\:]*)$/,'tagname']
	[/\\([\w\-\:]*)$/,'type']
	# [/\.([\w\-\$]*)$/,'access']
]

class TokenScope
	def constructor {parent,token,type,line}
		type = type
		indent = line.indent
		start = token.offset
		token = token
		parent = parent
		end = null
		endIndex = null

		if token.type.match(/(\w+)\.open/)
			pair = token.type.replace('open','close')

		if let m = (meta.matcher and line.lineContent.match(meta.matcher))
			name = m[m.length - 1]
			for mod in m.slice(1,-1)
				self[mod] = true if mod
		return self
		# token: tok, start: tok.offset, indent: indent, type: m[1]
	
	get meta
		ScopeTypes[type] or ScopeTypes.flow

	def sub token,type,line
		TokenScope.new(parent: self, token: token, type: type, line: line)

	get chain
		let items = [self]
		let scope = self
		while scope = scope.parent
			items.unshift(scope)
		return items
	
	def closest match = null
		let scope = self
		while scope
			let typ = scope.meta
			if typeof match == 'string'
				return scope if typ[match] or scope.type == match
			scope = scope.parent
		return null

	get closure
		closest('closure')
				

export class TokenizedDocument < Component
	def constructor document
		super
		doc = document
		lineTokens = []
		tokens = []
		lexer = monarch.getLexer('imba')
		rootScope = TokenScope.new(token: {offset: 0, type: 'root'}, type: 'root', line: {indent: -1}, parent: null)
		head = start = {
			index: 0
			line: 0
			offset: 0
			type: 'line'
			state: lexer.getInitialState!
			scopes: []
			context: rootScope
			match: Token.prototype.match
		}
	
	# Remove tokens etc from memory
	def prune
		self

	def invalidateFromLine line
		if head.line >= line
			let state = lineTokens[Math.max(line - 1,0)] or start
			if state
				tokens.length = state.index
				head = state

		self
	
	def applyEdit change,version,changes
		invalidateFromLine(change.range.start.line)

	def after token
		let idx = tokens.indexOf(token)
		return tokens[idx + 1]

	def matchToken token, match
		if match isa RegExp
			return token.type.match(match)
		elif typeof match == 'string'
			return token.type == match
		return false
	
	def before token, match, flat
		let idx = tokens.indexOf(token)
		if match
			while idx > 0
				let tok = tokens[--idx]
				if matchToken(tok,match)
					return tok
		return tokens[idx - 1]

	def getTokenRange token
		{start: doc.positionAt(token.offset), end: doc.positionAt(token.offset + token.value.length)}

	def getTokenAtOffset offset
		let pos = doc.positionAt(offset)
		getTokens(pos) # ensure that we have tokenized all the way here
		let line = lineTokens[pos.line]
		let idx = line.index
		let token
		let prev
		# find the token
		while token = tokens[idx++]
			break if token.offset >= offset
			prev = token
		return prev or token

	def getContextAtOffset offset
		let pos = doc.positionAt(offset)
		let token = getTokenAtOffset(offset)
		let index = tokens.indexOf(token)
		let line = lineTokens[pos.line]
		let prev = tokens[index - 1]
		let next = tokens[index + 1]

		let context = {
			offset: offset
			position: pos
			token: token
			line: line.lineContent
			textBefore: line.lineContent.slice(0,offset - line.offset)
			textAfter: line.lineContent.slice(offset - line.offset)
			mode: token.stack ? token.stack.state : ''
			scope: line.context
		}

		let scope = context.scope
		let mode = context.mode
		let indent = context.indent = context.textBefore.match(/^\t*/)[0].length

		let m
		if m = token.type.match(/regexp|string|comment/)
			mode = m[0]
			context.nested = yes
		elif mode.match(/style/) or mode.match(/tag\.(\w+)/)
			yes
		else
			while scope.indent >= indent and !scope.pair
				scope = scope.parent

			if mode.match(/(\.(var|let|const|param))/)
				mode = 'varname'
			elif m = token.type.match(/white\.(\w+)/)
				mode = m[1]
			else
				for rule in TokenContextRules
					if context.textBefore.match(rule[0])
						break mode = rule[1]
		
		if mode == 'string' and context.textBefore.match(/import |from |require(\(|\s)/)
			mode = 'filepath'

		let vars = context.vars = []
		
		// Start from the first scope and collect variables up to this token
		if let start = line.context.closure # line.scopes[line.scopes.length - 1]
			let i = Math.max(tokens.indexOf(start.token),0)
			while i <= index
				let tok = tokens[i++]
				if let scop = tok.scope
					if scop.endIndex != null and scop.endIndex < index
						i = scop.endIndex
						continue
					scope = scop

				if tok.type.match(/variable/)
					vars.push(tok)
		
		if !context.nested
			while scope.indent >= indent and !scope.pair and (scope.start < line.offset)
				scope = scope.parent

			

		if scope.type == 'element'
			# not inside anywhere special?
			context.tagName = after(scope.token)

		context.scope = scope
		context.mode = mode
		return context
		

	def getTokens range
		var codelines = doc.content.split('\n')

		var tokens = tokens
		var t = Date.now!
		var toLine = range ? range.line : (doc.lineCount - 1)
		var added = 0
		var lineCount = doc.lineCount

		console.log 'get tokens!!',toLine

		while head.line <= toLine
			let i = head.line
			let offset = head.offset
			let code = codelines[head.line]

			let indent = 0
			while code[indent] === '\t'
				indent++

			let lineToken = lineTokens[i] = {
				offset: offset
				state: head.state
				stack: head.state.stack
				line: i
				indent: indent
				type: 'line'
				meta: head.state.stack
				lineContent: code
				match: Token.prototype.match
				value: i ? '\n' : ''
				index: tokens.length
				context: head.context
			}

			let scope = head.context

			if (code[indent] or i == lineCount) and !lineToken.stack.state.match(/string|regexp/)
				# Need to track parens etc as well
				while scope
					if scope.indent >= indent and !scope.pair
						scope.end = offset
						scope.endIndex = lineToken.index
						scope = scope.parent
					else
						break

			tokens.push(lineToken)

			let lexed = lexer.tokenize(code + newline,head.state,offset)

			for tok,i in lexed.tokens
				continue if tok.type == 'newline'
				# continue if tok.type == 'lookahead.imba'
				let next = lexed.tokens[i + 1]
				let to = next ? (next.offset - offset) : 1000000
				let match
				if match = tok.type.match(/keyword\.(class|def|set|get|prop|tag|if|for|while|do|elif)/)
					tok.scope = scope = scope.sub(tok,match[1],lineToken)
				elif TokenScopeTypes[tok.type]
					tok.scope = scope = scope.sub(tok,TokenScopeTypes[tok.type],lineToken)
				elif tok.type == scope.pair
					scope.end = tok.offset
					scope.endIndex = tokens.length
					scope = scope.parent

				tok.value = code.slice(tok.offset - offset,to)
				tokens.push(tok)
				added++

			head.context = scope
			head.line++
			head.offset += code.length + 1
			head.state = lexed.endState

		var elapsed = Date.now! - t
		# if tokens.length < 50
		#	console.log tokens
		console.log 'tokenized',elapsed,added
		return tokens

export def parse code,prev
	var lexer = monarch.getLexer('imba')
	var state = lexer.getInitialState!
	var codelines = code.split('\n')
	var t = Date.now!
	var loc = 0
	var tokens = []
	var res = {}

	var lines = [] // {offset,raw,tokens}

	for line,i in codelines
		let lexline = [loc,line,[]]
		let lexed = lexer.tokenize(line,state,loc)

		for tok,i in lexed.tokens
			let next = lexed.tokens[i + 1]
			let to = next ? next.offset : code.length
			lexline[2].push(tok)
			tok.value = line.slice(tok.offset - loc,to - loc)
			tokens.push(tok)
			
		state = lexed.endState
		loc += line.length + 1

		if lexed.endState.stack.parent
			lexline[3] = lexed.endState
		lines.push(lexline)

	var elapsed = Date.now! - t
	var str = ""
	var vars = res.variables = []
	console.log 'parsed',code.length,'in',elapsed
	var stackname = do |stack|
		let val = [stack.state]
		while stack = stack.parent
			val.push(stack.state)
		return val

	for line in lines
		console.log line[0],line[1],line[2].map(do [$1.type,$1.value,$1.offset,stackname($1.stack)]),line[3] && line[3].stack.state

	return {}
