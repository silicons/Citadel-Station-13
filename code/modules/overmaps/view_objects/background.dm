/**
 * holds the background of the view
 */
/atom/movable/overmap_hud/background
	name = "helm holographics"
	icon = 'icons/overmaps/turfs.dmi'
	icon_state = "background"
	plane = OVERMAP_BACKGROUND_PLANE

/atom/movable/overmap_hud/background/Initialize(mapoad, datum/overmap_view/creator)
	. = ..()
	Update()

/atom/movable/overmap_hud/background/proc/Update()
	screen_loc = "[parent.screen]:1,1 to [parent.view_range * 2 + 1],[parent.view_range * 2 + 1]"
