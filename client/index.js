'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var vscode = require('vscode');
var vscodeLanguageclient = require('vscode-languageclient');

function iter$(a){ return a ? (a.toIterable ? a.toIterable() : a) : []; }var path = require('path');

// TODO(scanf): handle workspace folder and multiple client connections

class ClientAdapter {
	
	uriToEditor(uri,version){
		for (let i = 0, items = iter$(vscode.window.visibleTextEditors), len = items.length, editor; i < len; i++) {
			editor = items[i];
			let doc = editor.document;
			if (doc && uri === doc.uri.toString()) {
				if (version && doc.version != version) {
					continue;
				}				return editor;
			}		}		return null;
	}
}
var adapter = new ClientAdapter();

function activate(context){
	var serverModule = context.asAbsolutePath(path.join('server','index.js'));
	var debugOptions = {execArgv: ['--nolazy','--inspect=6005']};
	
	console.log(serverModule,debugOptions); // , debugServerModule
	
	var serverOptions = {
		run: {module: serverModule,transport: vscodeLanguageclient.TransportKind.ipc,options: debugOptions},
		debug: {module: serverModule,transport: vscodeLanguageclient.TransportKind.ipc,options: debugOptions}
	};
	
	var clientOptions = {
		documentSelector: [{scheme: 'file',language: 'imba'}],
		synchronize: {configurationSection: ['imba']},
		revealOutputChannelOn: vscodeLanguageclient.RevealOutputChannelOn.Info,
		initializationOptions: {
			something: 1,
			other: 100
		}
	};
	
	var client = new vscodeLanguageclient.LanguageClient('imba','Imba Language Server',serverOptions,clientOptions);
	var disposable = client.start();
	
	var type = vscode.window.createTextEditorDecorationType({
		light: {color: '#509DB5'},
		dark: {color: '#dbdcb2'},
		rangeBehavior: 1
	});
	
	context.subscriptions.push(disposable);
	
	client.onReady().then(function() {
		return client.onNotification('entities',function(uri,version,markers) {
			let editor = adapter.uriToEditor(uri,version);
			
			if (!(editor)) { return }			
			var styles = {
				RootScope: ["#d6bdce","#509DB5"],
				"import": ['#91b7ea','#91b7ea']
			};
			
			let res = [];
			for (let i = 0, items = iter$(markers), len = items.length, marker; i < len; i++) {
				marker = items[i];
				let color = styles[marker.type] || styles[marker.scope];
				
				res.push({
					range: marker.range,
					hoverMessage: ("variable " + (marker.name)),
					renderOptions: color ? {dark: {color: color[0]},light: {color: color[1]},rangeBehavior: 1} : null
				});
			}			var decorations = res;
			
			return editor.setDecorations(type,decorations);
		});
	});
	
	
	// set language configuration
	return vscode.languages.setLanguageConfiguration('imba',{
		wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\$\-\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/g,
		onEnterRules: [{
			beforeText: /^\s*(?:export def|def|(export (default )?)?(static )?(def|get|set)|(export (default )?)?(class|tag)|for|if|elif|else|while|try|with|finally|except|async).*?$/,
			action: {indentAction: vscode.IndentAction.Indent}
		},{
			beforeText: /\s*(?:do)\s*(\|.*\|\s*)?$/,
			action: {indentAction: vscode.IndentAction.Indent}
		}]
	});
}

exports.activate = activate;
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VzIjpbInNyYy9pbmRleC5pbWJhIl0sInNvdXJjZXNDb250ZW50IjpbInZhciBwYXRoID0gcmVxdWlyZSAncGF0aCdcblxuaW1wb3J0IHt3aW5kb3csIGxhbmd1YWdlcywgSW5kZW50QWN0aW9ufSBmcm9tICd2c2NvZGUnXG5pbXBvcnQge0xhbmd1YWdlQ2xpZW50LCBUcmFuc3BvcnRLaW5kLCBSZXZlYWxPdXRwdXRDaGFubmVsT259IGZyb20gJ3ZzY29kZS1sYW5ndWFnZWNsaWVudCdcblxuIyBUT0RPKHNjYW5mKTogaGFuZGxlIHdvcmtzcGFjZSBmb2xkZXIgYW5kIG11bHRpcGxlIGNsaWVudCBjb25uZWN0aW9uc1xuXG5jbGFzcyBDbGllbnRBZGFwdGVyXG5cdFxuXHRkZWYgdXJpVG9FZGl0b3IgdXJpLCB2ZXJzaW9uXG5cdFx0Zm9yIGVkaXRvciBpbiB3aW5kb3cudmlzaWJsZVRleHRFZGl0b3JzXG5cdFx0XHRsZXQgZG9jID0gZWRpdG9yLmRvY3VtZW50XG5cdFx0XHRpZiBkb2MgJiYgdXJpID09PSBkb2MudXJpLnRvU3RyaW5nKClcblx0XHRcdFx0aWYgdmVyc2lvbiBhbmQgZG9jLnZlcnNpb24gIT0gdmVyc2lvblxuXHRcdFx0XHRcdGNvbnRpbnVlXG5cdFx0XHRcdHJldHVybiBlZGl0b3Jcblx0XHRyZXR1cm4gbnVsbFxuXG52YXIgYWRhcHRlciA9IENsaWVudEFkYXB0ZXIubmV3XG5cbmV4cG9ydCBkZWYgYWN0aXZhdGUgY29udGV4dFxuXHR2YXIgc2VydmVyTW9kdWxlID0gY29udGV4dC5hc0Fic29sdXRlUGF0aChwYXRoLmpvaW4oJ3NlcnZlcicsICdpbmRleC5qcycpKVxuXHR2YXIgZGVidWdPcHRpb25zID0geyBleGVjQXJndjogWyctLW5vbGF6eScsICctLWluc3BlY3Q9NjAwNSddIH1cblx0XG5cdGNvbnNvbGUubG9nIHNlcnZlck1vZHVsZSwgZGVidWdPcHRpb25zICMgLCBkZWJ1Z1NlcnZlck1vZHVsZVxuXHRcblx0dmFyIHNlcnZlck9wdGlvbnMgPSB7XG5cdFx0cnVuOiB7bW9kdWxlOiBzZXJ2ZXJNb2R1bGUsIHRyYW5zcG9ydDogVHJhbnNwb3J0S2luZC5pcGMsIG9wdGlvbnM6IGRlYnVnT3B0aW9ucyB9XG5cdFx0ZGVidWc6IHttb2R1bGU6IHNlcnZlck1vZHVsZSwgdHJhbnNwb3J0OiBUcmFuc3BvcnRLaW5kLmlwYywgb3B0aW9uczogZGVidWdPcHRpb25zIH1cblx0fVxuXHRcblx0dmFyIGNsaWVudE9wdGlvbnMgPSB7XG5cdFx0ZG9jdW1lbnRTZWxlY3RvcjogW3tzY2hlbWU6ICdmaWxlJywgbGFuZ3VhZ2U6ICdpbWJhJ31dXG5cdFx0c3luY2hyb25pemU6IHsgY29uZmlndXJhdGlvblNlY3Rpb246IFsnaW1iYSddIH1cblx0XHRyZXZlYWxPdXRwdXRDaGFubmVsT246IFJldmVhbE91dHB1dENoYW5uZWxPbi5JbmZvXG5cdFx0aW5pdGlhbGl6YXRpb25PcHRpb25zOiB7XG5cdFx0XHRzb21ldGhpbmc6IDFcblx0XHRcdG90aGVyOiAxMDBcblx0XHR9XG5cdH1cblx0XG5cdHZhciBjbGllbnQgPSBMYW5ndWFnZUNsaWVudC5uZXcoJ2ltYmEnLCAnSW1iYSBMYW5ndWFnZSBTZXJ2ZXInLCBzZXJ2ZXJPcHRpb25zLCBjbGllbnRPcHRpb25zKVxuXHR2YXIgZGlzcG9zYWJsZSA9IGNsaWVudC5zdGFydCgpXG5cdFxuXHR2YXIgdHlwZSA9IHdpbmRvdy5jcmVhdGVUZXh0RWRpdG9yRGVjb3JhdGlvblR5cGUoe1xuXHRcdGxpZ2h0OiB7Y29sb3I6ICcjNTA5REI1J30sXG5cdFx0ZGFyazoge2NvbG9yOiAnI2RiZGNiMid9LFxuXHRcdHJhbmdlQmVoYXZpb3I6IDFcblx0fSlcblxuXHRjb250ZXh0LnN1YnNjcmlwdGlvbnMucHVzaChkaXNwb3NhYmxlKVxuXHRcblx0Y2xpZW50Lm9uUmVhZHkoKS50aGVuIGRvXG5cdFx0Y2xpZW50Lm9uTm90aWZpY2F0aW9uKCdlbnRpdGllcycpIGRvIHx1cmksdmVyc2lvbixtYXJrZXJzfFxuXHRcdFx0bGV0IGVkaXRvciA9IGFkYXB0ZXIudXJpVG9FZGl0b3IodXJpLHZlcnNpb24pXG5cdFx0XHRcblx0XHRcdHJldHVybiB1bmxlc3MgZWRpdG9yXG5cblx0XHRcdHZhciBzdHlsZXMgPSB7XG5cdFx0XHRcdFJvb3RTY29wZTogW1wiI2Q2YmRjZVwiLFwiIzUwOURCNVwiXVxuXHRcdFx0XHRcImltcG9ydFwiOiBbJyM5MWI3ZWEnLCcjOTFiN2VhJ11cblx0XHRcdH1cblxuXHRcdFx0dmFyIGRlY29yYXRpb25zID0gZm9yIG1hcmtlciBpbiBtYXJrZXJzXG5cdFx0XHRcdGxldCBjb2xvciA9IHN0eWxlc1ttYXJrZXIudHlwZV0gb3Igc3R5bGVzW21hcmtlci5zY29wZV1cblx0XHRcdFx0XG5cdFx0XHRcdHtcblx0XHRcdFx0XHRyYW5nZTogbWFya2VyLnJhbmdlXG5cdFx0XHRcdFx0aG92ZXJNZXNzYWdlOiBcInZhcmlhYmxlIHttYXJrZXIubmFtZX1cIlxuXHRcdFx0XHRcdHJlbmRlck9wdGlvbnM6IGNvbG9yID8ge2Rhcms6IHtjb2xvcjogY29sb3JbMF19LCBsaWdodDoge2NvbG9yOiBjb2xvclsxXX0sIHJhbmdlQmVoYXZpb3I6IDF9IDogbnVsbFxuXHRcdFx0XHR9XG5cdFx0XHRcblx0XHRcdGVkaXRvci5zZXREZWNvcmF0aW9ucyh0eXBlLCBkZWNvcmF0aW9ucylcblx0XHRcdFxuXHRcblx0IyBzZXQgbGFuZ3VhZ2UgY29uZmlndXJhdGlvblxuXHRsYW5ndWFnZXMuc2V0TGFuZ3VhZ2VDb25maWd1cmF0aW9uKCdpbWJhJyx7XG5cdFx0d29yZFBhdHRlcm46IC8oLT9cXGQqXFwuXFxkXFx3Kil8KFteXFxgXFx+XFwhXFxAXFwjJVxcXlxcJlxcKlxcKFxcKVxcPVxcJFxcLVxcK1xcW1xce1xcXVxcfVxcXFxcXHxcXDtcXDpcXCdcXFwiXFwsXFwuXFw8XFw+XFwvXFw/XFxzXSspL2csXG5cdFx0b25FbnRlclJ1bGVzOiBbe1xuXHRcdFx0YmVmb3JlVGV4dDogL15cXHMqKD86ZXhwb3J0IGRlZnxkZWZ8KGV4cG9ydCAoZGVmYXVsdCApPyk/KHN0YXRpYyApPyhkZWZ8Z2V0fHNldCl8KGV4cG9ydCAoZGVmYXVsdCApPyk/KGNsYXNzfHRhZyl8Zm9yfGlmfGVsaWZ8ZWxzZXx3aGlsZXx0cnl8d2l0aHxmaW5hbGx5fGV4Y2VwdHxhc3luYykuKj8kLyxcblx0XHRcdGFjdGlvbjogeyBpbmRlbnRBY3Rpb246IEluZGVudEFjdGlvbi5JbmRlbnQgfVxuXHRcdH0se1xuXHRcdFx0YmVmb3JlVGV4dDogL1xccyooPzpkbylcXHMqKFxcfC4qXFx8XFxzKik/JC8sXG5cdFx0XHRhY3Rpb246IHsgaW5kZW50QWN0aW9uOiBJbmRlbnRBY3Rpb24uSW5kZW50IH1cblx0XHR9XVxuXHR9KSJdLCJuYW1lcyI6WyJ3aW5kb3ciLCJUcmFuc3BvcnRLaW5kIiwiUmV2ZWFsT3V0cHV0Q2hhbm5lbE9uIiwiTGFuZ3VhZ2VDbGllbnQiLCJsYW5ndWFnZXMiLCJJbmRlbnRBY3Rpb24iXSwibWFwcGluZ3MiOiI7Ozs7Ozs7eUVBQUksSUFBQSxJQUFJLEdBQVcsUUFBQSxNQUFNLENBQUE7Ozs7QUFPekIsTUFBTSxhQUFhOztDQUVkLFdBQVcsQ0FBQyxHQUFHLENBQUUsT0FBTztFQUMzQiw4QkFBY0EsYUFBTSxDQUFDLGtCQUFrQjs7R0FDbEMsSUFBQSxHQUFHLEdBQUcsTUFBTSxDQUFDLFFBQVE7R0FDekIsSUFBRyxHQUFHLElBQUksR0FBRyxLQUFLLEdBQUcsQ0FBQyxHQUFHLENBQUMsUUFBUSxFQUFFO0lBQ25DLElBQUcsT0FBTyxJQUFLLEdBQUcsQ0FBQyxPQUFPLElBQUksT0FBTzs7U0FFckMsT0FBTyxNQUFNO1NBQ2YsT0FBTyxJQUFJO0VBQUE7QUFBQTtBQUVULElBQUEsT0FBTyxHQUFpQixJQUFkLGFBQWEsRUFBSTs7QUFFeEIsU0FBSSxRQUFRLENBQUMsT0FBTztDQUN0QixJQUFBLFlBQVksR0FBRyxPQUFPLENBQUMsY0FBYyxDQUFDLElBQUksQ0FBQyxJQUFJLENBQUMsUUFBUSxDQUFFLFVBQVUs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
