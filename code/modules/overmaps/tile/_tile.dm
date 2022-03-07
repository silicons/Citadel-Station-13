/**
 * tile objects
 */
/atom/movable/overmap_object/tile
	icon = 'icons/modules/overmaps/tile.dmi'
	icon_state = "unknown"

/atom/movable/overmap_object/tile/Initialize(mapload)
	. = ..()
	add_bounding_box_overlay()

/atom/movable/overmap_object/tile/get_bounding_box_overlay()
	// we want to smooth with others like us
	// manual smoothing, sue me
	var/dirs = NONE
	for(var/dir in GLOB.cardinals)
		if(locate(type) in get_step(src, dir))
			dirs |= dir
	return get_smooth_bounding_box_visual(bound_width, bound_height, bound_x, bound_y, dirs)
