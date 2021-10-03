/datum/game_master/CanProcCall(procname)
	if(procname == "LoadConfig")
		to_chat(usr, "LoadConfig() blocked - use GM debug verb")
		return FALSE
	if(procname == "LoadConfigJSON")
		to_chat(usr, "LoadConfigJSON() blocked - use GM debug verb")
		return FALSE
	return ..()

/datum/game_master/proc/LoadConfig()
	if(!fexists("config/game_master.txt"))
		log_dynamic("INIT: Failed to load config/game_master.txt"))
		return
	log_dynamic("INIT: Loading GameMaster configuration.")
	LoadConfigJSON(file2text(file("config/game_master.txt")))

/datum/game_master/proc/LoadConfigJSON(jsontext)
	// jsontext is an overrides list
	// prevent it from changing anything it shouldn't
	var/datum/D = new
	var/list/banned = list()
	for(var/i in D.vars)
		banned[i] = TRUE
	banned["abstract_type"] = TRUE
	var/list/loaded = safe_json_decode(jsontext)
	if(!loaded)
		log_dynamic("INIT: Failed to parse GameMaster configuration.")
		return

	var/list/loaded_action = loaded["actions"]
	loaded -= "actions"
	var/list/loaded_storyteller = loaded["storytellers"]
	loaded -= "storytellers"

	for(var/key in loaded)
		if(banned[key])
			log_dynamic("INIT: Skipping banned variable [key] in configuration")
			continue
		if(vars.Find(key))
			vars[key] = loaded[key]
		else
			log_dyanmic("INIT: Skipping invalid variable [key] on [type] in configuration")
			continue

	for(var/textpath in loaded_action)
		path = text2path(textpath)
		if(!path)
			log_dynamic("INIT: Skipping invalid path [textpath] on configuration")
			continue
		var/datum/gm_action/action = locate(path) in actions
		if(!action)
			log_dynamic("INIT: Skipping [textpath] - could not find in actions list")
			continue
		var/list/settings = loaded_action[textpath]
		for(var/key in settings)
			if(banned[key])
				log_dynamic("INIT: Skipping banned variable [key] in configuration")
				continue
			if(action.vars.Find(key))
				action.vars[key] = settings[key]
			else
				log_dynamic("INIT: Skipping invalid variable [key] on [action.type] in configuration")
				continue

	for(var/textpath in loaded_storyteller)
		path = text2path(textpath)
		if(!path)
			log_dynamic("INIT: Skipping invalid path [textpath] on configuration")
			continue
		var/datum/gm_mode/mode = locate(path) in storytellers
		if(!mode)
			log_dynamic("INIT: Skipping [textpath] - could not find in storytellers list")
			continue
		var/list/settings = loaded_storyteller[textpath]
		for(var/key in settings)
			if(banned[key])
				log_dynamic("INIT: Skipping banned variable [key] in configuration")
				continue
			if(storyteller.vars.Find(key))
				storyteller.vars[key] = settings[key]
			else
				log_dynamic("INIT: Skipping invalid variable [key] on [storyteller.type] in configuration")
				continue
