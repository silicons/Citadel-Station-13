/**
 * Asserts static vision is loaded
 */
/atom/movable/overmap_object/entity/proc/AssertStaticVision(range)
	// if(!static_vision || (!isnull(range) && (range != static_vision_range)))
	// 	SetStaticVision(static_vision_range)

/**
 * Gets everything viewable in a certain range
 */
/atom/movable/overmap_object/entity/proc/View(r = view_holder?.view_range)

/**
 * Sets static vision range to
 */
/atom/movable/overmap_object/entity/proc/SetStaticVision(range)
	#warn impl
