/**
 * Ship UI
 *
 * View + astrometrics + sensor contacts
 */
/datum/ship/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src)
	if(!ui)
		ui = new(user, src, "OvermapShip")
		ui.open()

/datum/ship/ui_static_data(mob/user)
	. = parent.ui_static_data(user)
	#warn data

/datum/ship/ui_data(mob/user)
	. = parent.ui_data(user)
	#warn data
