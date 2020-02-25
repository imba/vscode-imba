import {CompletionItemKind,SymbolKind} from 'vscode-languageserver-types'
import {URI} from 'vscode-uri'

export def uriToPath uri
	return uri if uri[0] == '/' or uri.indexOf('://') == -1
	URI.parse(uri).path

export def pathToUri path
	'file://' + path

export def rangeFromTextSpan span
	rangeFromLocations(span.start,span.end)

export def textSpanToRange span, filename, service
	let start = service.toLineColumnOffset(filename,span.start)
	let end = service.toLineColumnOffset(filename,span.start + span.length)
	return {start: start, end: end}
	
export def rangeFromLocations start, end
	return
		start:
			line: Math.max(0, start.line - 1),
			character: Math.max(start.offset - 1, 0)
		end:
			line: Math.max(0, end.line - 1)
			character: Math.max(0, end.offset - 1)

const COMPLETION_KIND_MAP = {
	property: CompletionItemKind.Field
	method: CompletionItemKind.Method
	text: CompletionItemKind.Text
	operator: CompletionItemKind.Operator
	class: CompletionItemKind.Class
	var: CompletionItemKind.Variable
	function: CompletionItemKind.Function
	const: CompletionItemKind.Constant
	module: CompletionItemKind.Module
	keyword: CompletionItemKind.Keyword
	alias: CompletionItemKind.Variable
	warning: CompletionItemKind.Text
	getter: CompletionItemKind.Field
	enum: CompletionItemKind.Enum
	value: CompletionItemKind.Value
	export: CompletionItemKind.Field
}

export def convertCompletionKind kind, entry
	return COMPLETION_KIND_MAP[kind] or CompletionItemKind.Method


const SYMBOL_KIND_MAP = {
	property: SymbolKind.Field
	method: SymbolKind.Method
	class: SymbolKind.Class
	"local class": SymbolKind.Class
	var: SymbolKind.Variable
	let: SymbolKind.Variable
	function: SymbolKind.Function
	const: SymbolKind.Constant
	module: SymbolKind.Module
	alias: SymbolKind.Variable
	getter: SymbolKind.Field
}

export def convertSymbolKind kind, entry
	return SYMBOL_KIND_MAP[kind] or SymbolKind.Field

###

export declare namespace SymbolKind {
    const File: 1;
    const Module: 2;
    const Namespace: 3;
    const Package: 4;
    const Class: 5;
    const Method: 6;
    const Property: 7;
    const Field: 8;
    const Constructor: 9;
    const Enum: 10;
    const Interface: 11;
    const Function: 12;
    const Variable: 13;
    const Constant: 14;
    const String: 15;
    const Number: 16;
    const Boolean: 17;
    const Array: 18;
    const Object: 19;
    const Key: 20;
    const Null: 21;
    const EnumMember: 22;
    const Struct: 23;
    const Event: 24;
    const Operator: 25;
    const TypeParameter: 26;
}
###