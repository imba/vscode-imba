import * as monarch from '../vendor/monarch'
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
	escapes: /\\(?:[abfnrtv\\"'`$]|x[0-9A-Fa-f]{1,4}|u[0-9A-Fa-f]{4}|U[0-9A-Fa-f]{8})/,
	postaccess: /(:(?=\w))?/
	ivar: /\@[a-zA-Z_]\w*/
	constant: /[A-Z][A-Za-z\d\-\_]*/
	className: /[A-Z][A-Za-z\d\-\_]*|[A-Za-z\d\-\_]+/
	methodName: /[A-Za-z\_][A-Za-z\d\-\_]*\=?/
	identifier: /[a-z_][A-Za-z\d\-\_]*/
	anyIdentifier: /[A-Za-z_\$][A-Za-z\d\-\_\$]*/
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
			[/for( own)? /, 'keyword.for', '@forin_var_decl']
		]

		def_statement: [
			[/(def|set|get)(\s)(@identifier)(\s)(?=\{|\w|\[|\.\.\.)/, [{token: 'keyword.$1'},'white.propname',{token: 'identifier.$1.name'},{token: 'white.params', next: '@var_decl.param'}]],
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
			[/\@(@anyIdentifier)?/, 'decorator'],
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
			[/\@(@tagIdentifier)/,token: 'tag.reference']
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

export const lexer = monarch.getLexer('imba')