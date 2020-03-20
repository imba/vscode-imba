var config = {
	verbose: false
}

export def get option
	return config[option]

export def update updates
	config = updates.settings.imba
	return config
	
