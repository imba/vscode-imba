import {CompletionItemKind,SymbolKind,InsertTextFormat,CompletionItem} from 'vscode-languageserver-types'

// @ts-check
let x = 10;
let a = {
    a: 1,
    b: 2,
    d: null as CompletionItem
}

// @ts-ignore
let item = someItemHere;

let entry = {
    label: ':' + item.name.slice(2),
    sortText: item.name.slice(2),
    kind: 'value'
};

entry.detail = 'hello';


a.c = 3;
x = 'Hello';


let items:CompletionItem[] = [];

let entry2:CompletionItem;
let items2 = [];

for (let i = 0, keys = ['a','b','c'], l = keys.length, name; i < l; i++){
    name = keys[i];
    items.push({
        label: name.replace('_',':'),
        sortText: name,
        data: {resolved: true},
    });

    entry2 = {
        label: name.replace('_',':'),
        sortText: name,
        data: {resolved: true},
    };
    items2.push(entry2);
    
};

for (let item of items) {
    item.insertText = item.label + '$1>$0';
};

for (let item of items2) {
    
    item.insertText = item.label + '$1>$0';
};

for (let i = 0, len = items.length, item; i < len; i++) {
    item = items[i];
    items[i].insertText = item.label + '$1>$0';
};