import * as monaco from 'monaco-editor-core'

import {
	MonacoLanguageClient, MessageConnection, CloseAction, ErrorAction,
	MonacoServices, createConnection
} from 'monaco-languageclient'

monaco.languages.register({
	id: 'json',
	extensions: ['.json', '.bowerrc', '.jshintrc', '.jscsrc', '.eslintrc', '.babelrc'],
	aliases: ['JSON', 'json'],
	mimetypes: ['application/json'],
})

monaco.editor.create(document.getElementById("container"), {
	model: monaco.editor.createModel('# hello', 'json', monaco.Uri.parse('inmemory://model.json')),
	glyphMargin: true,
	lightbulb: {
		enabled: true
	}
})