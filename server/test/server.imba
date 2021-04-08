import np from 'path'
import fs from 'fs'
import express from 'express'

const app = express!
const dir = np.resolve(__realname,'..','projects')
console.log dir

def getFiles root,dir = root,state = {}
	let entries = fs.readdirSync(dir,withFileTypes: yes)
	console.log entries
	for entry in entries
		let path = np.resolve(dir,entry.name)
		if entry.isFile!
			state[np.relative(root,path)] = fs.readFileSync(path,'utf8')
		elif entry.isDirectory!
			console.log 'getFiles nested',root,path
			getFiles(root,path,state)
	return state

app.get('/files') do(req,res)
	return res.json getFiles(dir)

app.get('/') do(req,res)
	res.send String <html>
		<head>
			<meta charset="UTF-8">
			<title> "Imba - The friendly full-stack language!"
			<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
			<meta name="description" content="Imba is a programming language for building web applications with insane performance. You can use it both for the server and client.">
		<body>
			<script type="module" src="./index">

app.get('/monaco.html') do(req,res)
	res.send String <html>
		<head>
			<meta charset="UTF-8">
		<body>
			<div id='container'>
			<script type="module" src="./monaco">
# pass through imba serve to automatically
# serve assets in an optimised manner

imba.serve app.listen(process.env.PORT or 5000)