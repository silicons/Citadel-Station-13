/**
 * master superclass of overmap vision/view objects
 */
/atom/movable/overmap_hud
	/// parent view
	var/datum/overmap_view/parent
	/// default screen loc
	var/default_screen_loc = "CENTER"

/atom/movable/overmap_hud/Initialize(mapoad, datum/overmap_view/creator)
	. = ..()
	if(!istype(creator))
		CRASH("Invalid creator view")
	parent = creator
	if(default_screen_loc)
		screen_loc = "[parent.screen]:[default_screen_loc]"
