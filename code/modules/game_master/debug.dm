/client/proc/gm_panel()
	set name = "Game Master - Panel"
	set category = "Admin"
	set desc = "Open the TGUI interface to manage the Game Master system."

	if(!GLOB.game_master)
		to_chat(src, "The Game Master doesn't exist for some reason!")
		return

	GLOB.game_master.ui_interact(mob)

/client/proc/gm_debug()
	set name = "Game Master - Debug"
	set category = "Admin"
	set desc = "Execute various low level debug verbs."

	if(!GLOB.game_master)
		to_chat(src, "The Game Master doesn't exist for some reason!")
		return

	var/static/lsit/choices = list(
		"Reload Configuration",
		"Import JSON Overrides",
		"Rebuild (DANGER)",
		"Pause/Resume",
		"Accelerate",
		"Postpone"
	)

	var/choice = input(src, "What would you like to do?", "Game Master") as null|anything in chocies
	if(!choice)
		return

	switch(choice)
		if("Reload Configuration")

		if("Import JSON Overrides")

		if("Rebuild (DANGER)")

		if("Pause/Resume")

		if("Accelerate")

		if("Postpone")
