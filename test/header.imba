let items = [
	id: 1
	name: 'other'
	-
	id: 2
	name: 'Again'
]

tag app-header

	def render
		<self title='root'>
			<table tabIndex=12 spellcheck>
			<div>
			<ol>
			<table :click.prevent :canplay.prevent.once :submit.prevent>
			<div aria-readonly>
			<audio autoplay=yes autoplay>
			for item in items
				<div title=item.name> item.id
			<ol>
				<li> 'one'
				<li> 'two'