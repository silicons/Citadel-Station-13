/datum/game_master/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src)
	if(!ui)
		ui = new(user, src, "AdminGameMaster")
		ui.open()

/datum/game_master/ui_static_data(mob/user)
	. = ..()

/datum/game_master/ui_data(mob/user)
	. = ..()

/datum/game_master/ui_state(mob/user)
	. = ..()
	return GLOB.admin_state
