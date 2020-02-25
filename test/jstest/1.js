// @ts-check

import {CompletionItemKind,SymbolKind,InsertTextFormat,CompletionItem} from 'vscode-languageserver-types'

let x = 10;
let a = {
    a: 1,
    b: 2
}

export class Other {
    /**
     * 
     * @param {import("./item").Item} parent 
     */
    constructor(parent,stuff){
        this.parent = parent;
        /** @type {(CompletionItem | {})} */
        this.stuff = stuff;
    }

    setup(){
        this.stuff.insertText;
    }
}

/** @type CompletionItem */
let entry;
// @ts-ignore
let item = someItemHere;
let items2 = [];

if (item.name.match(/^on\w+/)) {
    entry = {
        label: ':' + item.name.slice(2),
        sortText: item.name.slice(2),
        kind: CompletionItemKind.Event
    };
    items2.push(entry);

} else {
    entry = {
        label: item.name
    };
};

entry.detail = 'test';

for(let item of items2){
    item.sortText
}

a.c = 3;
x = 'Hello';

/** @type CompletionItem[] */
let items = [];

for (let ctor, i = 0, keys = Object.keys(window.STUFF), l = keys.length, name; i < l; i++){
    name = keys[i];
    ctor = window.STUFF[name];
    items.push({
        label: name.replace('_',':'),
        sortText: name,
        data: {resolved: true},
    });
};

for (let i = 0, len = items.length, item; i < len; i++) {
    item = items[i];
    item.insertText = item.label + '$1>$0';
};