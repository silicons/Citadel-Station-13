GLOBAL_LIST_EMPTY(bounds_icon_cache)

/**
 * get raw, un-offset overlay box for a bound, on sides that aren't smoothed
 */
/proc/get_bounding_box_icon(bound_width, bound_height, dirs)
	ASSERT(bound_width > 0 && bound_height > 0)
	ASSERT(bound_width <= 480 && bound_height <= 480)
	var/key = "[bound_width]x[bound_height][dirs? "_[dirs]" : ""]"
	if(GLOB.bounds_icon_cache[key])
		return GLOB.bounds_icon_cache[key]
	var/icon/generated = icon()
	generated.Scale(bound_width, bound_height)
	generated.DrawBox("#ffffff80", 1, 1, bound_width, bound_height)
	if(bound_width > 1 && bound_height > 1)
		generated.DrawBox("#ffffff00", (dirs & WEST)? 1 : 2, (dirs & SOUTH)? 1 : 2, (dirs & EAST)? bound_width : (bound_width - 1), (dirs & NORTH)? bound_height : (bound_height - 1))
	GLOB.bounds_icon_cache[key] = . = generated

/**
 * gets an offset mutable appearance for a bound
 */
/proc/get_bounding_box_visual(bound_width, bound_height, bound_x, bound_y)
	var/mutable_appearance/MA = new
	MA.icon = get_bounding_box_icon(bound_width, bound_height)
	MA.pixel_x = bound_x
	MA.pixel_y = bound_y
	return MA

/**
 * gets an offset mutable appearance for a bound, on non smoothed sides
 */
/proc/get_smooth_bounding_box_visual(bound_width, bound_height, bound_x, bound_y, dirs)
	var/mutable_appearance/MA = new
	MA.icon = get_bounding_box_icon(bound_width, bound_height, dirs)
	MA.pixel_x = bound_x
	MA.pixel_y = bound_y
	return MA

/**
 * gets our bounding box overlay, there's 3 procs in this file chained like this for overrides
 */
/atom/movable/proc/get_bounding_box_overlay()
	var/mutable_appearance/MA = . = get_bounding_box_visual(bound_width, bound_height, bound_x, bound_y)
	MA.plane = FLOAT_PLANE
	MA.layer = FLOAT_LAYER

/**
 * adds/updates a bounding box overlay to ourselves
 */
/atom/movable/proc/add_bounding_box_overlay()
	if(bounding_box_overlay)
		cut_overlay(bounding_box_overlay)
	bounding_box_overlay = get_bounding_box_overlay()
	add_overlay(bounding_box_overlay)

/**
 * clears our bounding box overlay if any
 */
/atom/movable/proc/clear_bounding_box_overlay()
	if(!bounding_box_overlay)
		return
	cut_overlay(bounding_box_overlay)
	bounding_box_overlay = null

