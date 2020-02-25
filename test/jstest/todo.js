import {CompletionItemKind,DiagnosticSeverity} from 'vscode-languageserver-types';

var ts = require('typescript');

var imbac = require('imba/dist/compiler.js');
var sm = require("source-map");

var imbaOptions = {
	target: 'tsc',
	imbaPath: null,
	sourceMap: {}
};

export class File {
	// @param {ts.LanguageService} service
	constructor(program,path,service){
		console.log(("created file " + path));
		this.program = program;
		this.ls = service;
		
		this.jsPath = path.replace(/\.(imba|js|ts)/,'.js');
		this.tsPath = path.replace(/\.(imba|js|ts)$/,'.ts');
		this.imbaPath = path.replace(/\.(imba|js|ts)$/,'.imba');
		this.lsPath = this.tsPath;
		this.lsPath = this.jsPath;
		
		this.version = 1;
		this.diagnostics = [];
		this.invalidate();
		if (!program.rootFiles.includes(this.lsPath)) {
			program.files[this.lsPath] = this;
			// program.files[@tsPath] = self
			program.files[this.imbaPath] = this;
			program.rootFiles.push(this.lsPath);
			program.version++;
			// let snapshot = ts.ScriptSnapshot.fromString("")
			// @jsDoc = program.acquireDocument(@lsPath,snapshot,@version)
			this.emitFile();
		};
		this;
	}
	
	
	get document(){
		let uri = 'file://' + this.imbaPath;
		console.log(("get " + uri));
		return this.program.documents.get(uri);
	}
	
	get uri(){
		return 'file://' + this.imbaPath;
	}
	
	didOpen(doc){
		this.doc = doc;
		return this.content = doc.getText();
	}
	
	didChange(doc){
		this.doc = doc;
		if (doc.version != this.version) {
			console.log('did change!',this.version,doc.version);
			this.version = doc.version;
			this.content = doc.getText();
			this.dirty = true;
			this.program.version++;
			this.invalidate();
			return this.compile();
		};
	}
	
	
	didSave(doc){
		this.content = doc.getText();
		// if @dirty
		// 	@dirty = no
		this.program.version++;
		this.invalidate();
		return this.ls.getEmitOutput(this.lsPath);
	}
	
	
	emitFile(){
		return this.ls.getEmitOutput(this.lsPath);
	}
	
	emitDiagnostics(){
		var self = this;
		var diagnostics = this.ls.getSemanticDiagnostics(this.lsPath);
		
		if (diagnostics.length) {
			this.diagnostics = diagnostics.map(function(entry) {
				let lstart = self.originalLocFor(entry.start);
				/** @type {?}*/
				let msg = entry.messageText;
				console.log('converting diagnostic',lstart,entry.start,entry.length,entry.messageText);
				return {
					severity: DiagnosticSeverity.Warning,
					message: msg.messageText || msg,
					range: {
						start: self.positionAt(lstart),
						end: self.positionAt(self.originalLocFor(entry.start + entry.length) || (lstart + entry.length))
					}
				};
			});
			console.log("ts diagnostics",this.diagnostics.map(function(_0) { return [_0.severity,_0.message,_0.range.start,_0.range.end]; }));
			return this.sendDiagnostics();
		} else {
			// @diagnostics.length
			// just remove the ts-related diagnostics
			this.diagnostics = [];
			return this.sendDiagnostics();
		};
	}
	
	updateDiagnostics(entries,group){
		return this;
	}
	
	sendDiagnostics(){
		// console.log "sending diagnostics",@diagnostics.map do [$1.severity,$1.message,$1.range.start,$1.range.end]
		return this.program.connection.sendDiagnostics({uri: this.uri,diagnostics: this.diagnostics});
	}
	
	positionAt(offset){
		if (this.doc) {
			return this.doc.positionAt(offset);
		};
		
		let loc = this.locs && this.locs.map[offset];
		return loc && {line: loc[0],character: loc[1]};
		// @document && @document.positionAt(offset)
	}
	
	getSourceContent(){
		return this.content || (this.content = ts.sys.readFile(this.imbaPath));
	}
	
	
	offsetAt(position){
		return this.document && this.document.offsetAt(position);
	}
	
	// remove compiled output etc
	invalidate(){
		this.result = null;
		this.cache = {
			srclocs: {},
			genlocs: {}
		};
		return this;
	}
	
	compile(){
		var self = this;
		if (!this.result) {
			var body = this.content || ts.sys.readFile(this.imbaPath);
			try {
				var res = imbac.compile(body,imbaOptions);
			} catch (e) {
				let loc = e.loc && e.loc();
				let range = loc && {
					start: this.positionAt(loc[0]),
					end: this.positionAt(loc[1])
				};
				
				let err = {
					severity: DiagnosticSeverity.Error,
					message: e.message,
					range: range
				};
				// console.log 'compile error',err
				this.diagnostics = [err];
				this.sendDiagnostics();
				this.result = {error: err};
				return this;
			};
			
			this.result = res;
			this.locs = res.locs;
			this.js = res.js.replace('$CARET$','valueOf');
			setTimeout(function() { return self.emitDiagnostics(); },0);
		};
		return this;
	}
	
	originalRangesFor(jsloc){
		return this.locs.spans.filter(function(pair) {
			return jsloc >= pair[0] && pair[1] >= jsloc;
		});
	}
	
	// need a better converter
	originalLocFor(jsloc){
		var span;
		let val = this.cache.srclocs[jsloc];
		if (val != undefined) {
			return val;
		};
		
		let spans = this.originalRangesFor(jsloc);
		val;;
		if (span = spans[0]) {
			let into = (jsloc - span[0]) / (span[1] - span[0]);
			let offset = Math.floor(into * (span[3] - span[2]));
			// console.log 'found originalLocFor',jsloc,spans
			if (span[0] == jsloc) {
				val = span[2];
			} else if (span[1] == jsloc) {
				val = span[3];
			} else {
				val = span[2] + offset;
			};
		};
		
		return this.cache.srclocs[jsloc] = val;
	}
	
	generatedRangesFor(loc){
		return this.locs.spans.filter(function(pair) {
			return loc >= pair[2] && pair[3] >= loc;
		});
	}
	
	generatedLocFor(loc){
		var span;
		let spans = this.generatedRangesFor(loc);
		if (span = spans[0]) {
			let into = (loc - span[2]) / (span[3] - span[2]);
			let offset = Math.floor(into * (span[1] - span[0]));
			// console.log 'found generatedLocFor',loc,spans
			if (loc == span[2]) {
				return span[0];
			} else if (loc == span[3]) {
				return span[1];
			} else {
				return span[0] + offset;
			};
		};
		return null;
	}
	
	textSpanToRange(span){
		let start = this.originalLocFor(span.start);
		let end = this.originalLocFor(span.start + span.length);
		// console.log 'textSpanToRange',span,start,end,@locs and @locs.generated
		return {start: this.positionAt(start),end: this.positionAt(end)};
	}
	
	textSpanToText(span){
		let start = this.originalLocFor(span.start);
		let end = this.originalLocFor(span.start + span.length);
		let content = this.getSourceContent();
		return content.slice(start,end);
	}
};