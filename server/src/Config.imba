# let config = {verbose: false}
export const config = {
	verbose: true
	checkImba:yes
	suggest: { }
}

export def get option
	return config[option]

export def update updates
	# console.log 'updating config',updates.settings.imba
	# config = updates.settings.imba
	Object.assign(config,updates)
	return config
	
