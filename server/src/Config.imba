# let config = {verbose: false}
export const config = {
	verbose: false
	suggest: { }
	implicitProjectConfig: { checkImba:yes }
}

export def get option
	return config[option]

export def update updates
	# console.log 'updating config',updates.settings.imba
	# config = updates.settings.imba
	Object.assign(config,updates)
	return config
	
