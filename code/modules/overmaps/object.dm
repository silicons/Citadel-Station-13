/**
 * base class of all overmap objects
 *
 * goal: subtype this as little as possible, use comopsition vs inheritance (i.e. locations, etc)
 */
/atom/movable/overmap_object
	name = "overmap object"
	plane = OVERMAP_OBJECT_PLANE
	icon = 'icons/overmap/32x32.dmi'
	icon_state = "unknown"
	appearance_flags = NONE
	bound_width = 32
	bound_height = 32
	step_size = OVERMAPS_MAX_SPEED_PIXELS

	/// the location we corrospond to. if null, we are completely virtual.
	var/datum/overmap_location/location
	/// view datum, used for rendering.
	var/datum/overmap_view/view_holder
	/// location data - if a path, will be created and used to generate ourselves on init
	var/datum/overmap_location_data/location_data
	/// unique id
	var/id
	/// next id
	var/static/id_next = 0
	/// associated ship datum, if any. if set to path, will be made on init.
	var/datum/ship/ship
	/// reference to master overmap
	var/datum/overmap/overmap

	/* physics */

	/// angle clockwise from north
	var/angle = 0
	/// current transform angle
	var/transform_angle = 0
	/// real step x
	var/real_x
	/// real step y
	var/real_y
	/// velocity x in overmap units/second
	var/velocity_x = 0
	/// velocity y in overmap units/second
	var/velocity_y = 0
	/// angular velocity in degrees/second clockwise
	var/velocity_angle = 0
	/// we're moving
	var/moving = FALSE

	/// active hazards

	/// static vision
	var/static_vision_range = 1
	/// static vision image - lazyloaded
	var/atom/movable/overmap_hud/light/static_vision
	// IFF's are only on the ship datums!

/atom/movable/overmap_object/New()
	id = ++id_next
	CheckOvermap()
	return ..()

/atom/movable/overmap_object/Destroy()
	if(istype(location_data))
		QDEL_NULL(location_data)
	if(istype(view_holder))
		QDEL_NULL(view_holder)
	#warn decide what to do with ship and location because we can't always just wipe it
	// just qdel the ship then?
	if (ship)
		warning("attempted to qdel ship!")
	return ..()

/atom/movable/overmap_object/Initialize(mapload)
	. = ..()
	if(SSovermaps.initialized)
		OvermapInitialize(mapload)

/atom/movable/overmap_object/proc/OvermapInitialize(mapload)
	view_holder = new(src)
	LocationInitialize(mapload)
	ShipInitialize(mapload)

/atom/movable/overmap_object/proc/LocationInitialize(mapload)
	if(ispath(location_data, /datum/overmap_location_data))
		location_data = new location_data
		if(location_data.lazyload)
			return
		if(!(flags_1 & ADMIN_SPAWNED_1) && !IsAdminAdvancedProcCall())
			location_data.generate(src)
		else
			log_overmap("Skipping location instantiation of [id] [location_data.type]")
			message_admins("Overmaps: [id] location instantiation skipped due to being admin-spawned (safety). If you mean to instantiate it, call the proc manually.")

/atom/movable/overmap_object/proc/ShipInitialize(mapload)
	if(ispath(ship))
		ship = new ship(src)
