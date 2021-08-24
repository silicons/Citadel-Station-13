/**
 * base class of all overmap objects
 *
 * goal: subtype this as little as possible, use comopsition vs inheritance (i.e. locations, etc)
 */
/atom/movable/overmap_object
	name = "overmap object"
	icon = 'icons/overmap/32x32.dmi'
	icon_state = "unknown"

	/// the location we corrospond to. if null, we are completely virtual.
	var/datum/overmap_location/location
	/// view datum, used for rendering.
	var/datum/overmap_view/view
	/// location data - if a path, will be created and used to generate ourselves on init
	var/datum/overmap_location_data/location_data
	/// unique id
	var/id
	/// next id
	var/static/id_next = 0
	/// associated ship datum, if any. if set to path, will be made on init.
	var/datum/ship/ship

/atom/movable/overmap_object/Initialize(mapload)
	. = ..()
	id = ++id_next
	view = new(src)
	if(ispath(location_data, /datum/overmap_location_data))
		location_data = new location_data
		if(!(flags_1 & ADMIN_SPAWNED_1) && !IsAdminAdvancedProcCall())
			location_data.generate(src)
		else
			log_overmap("Skipping location instantiation of [id] [location_data.type]")
			message_admins("Overmaps: [id] location instantiation skipped due to being admin-spawned (safety). If you mean to instantiate it, call the proc manually.")
	if(ispath(ship))
		ship = new ship(src)
