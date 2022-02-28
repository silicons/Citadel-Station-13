/**
 * All areas on a shuttle must be an /area/shuttle.
 */
/area/shuttle
	name = "unknown shuttle"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED	// always simulate shuttle lighting
	always_unpowered = FALSE					// always allow shuttle power
	area_flags = NO_ALERTS						// don't have shuttle alerts show up; someday we'll rework alerts and area power, someday..
	icon_state = "shuttle"
	flags_1 = CAN_BE_DIRTY_1					// allow dirtying shuttles
	sound_environment = SOUND_ENVIRONMENT_ROOM	// citadel main sound stuff

	/// tracks if we defaulted our smothing for areas.
	var/defaulted_can_smooth = FALSE
	/// the shuttle we belong to, when fully registered
	var/atom/movable/shuttle/shuttle

/area/shuttle/Initialize()
	// by default, smooth with only ourselves
	if(!canSmoothWithAreas)
		canSmoothWithAreas = type
		defaulted_can_smooth = TRUE
	return ..()

/area/shuttle/PlaceOnTopReact(list/new_baseturfs, turf/fake_turf_type, flags)
	. = ..()
	// this proc will usually catch player construction attempts, and ensure they're "caught" on the shuttle properly
	if(length(new_baseturfs) > 1 || fake_turf_type)
		// smart guesstimate: if this passes, it's probably not a player building on us
		return
	if(ispath(new_baseturfs[1], /turf/open/floor/plating))
		// this'll probably need to be reworked later but assume player is plating over the base turf of the zlevel
		// inject baseturf skipover so we actually steal the turf when we take off!
		new_baseturfs.Insert(1, /turf/baseturf_skipover/shuttle)
