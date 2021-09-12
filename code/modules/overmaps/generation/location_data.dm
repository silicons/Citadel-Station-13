/**
 * holds location data - used when an object is created to generate, if available
 */
/datum/overmap_location_data
	/// name of destination
	var/name = "???"
	/// location type - see [__DEFINES/overmaps/overmaps.dm]
	var/location_type
	/// used for terrain generation. Seed is this + the overmap's seed.
	var/map_location = "0,0"
	/// lazyload - don't generate until someone tries to land/dock/etc
	var/lazyload = TRUE

/// used for future dynamic planet landing systems (see, a toggleable shieldgen to block ships from entering)
/datum/overmap_location_data/proc/can_land()
	return FALSE

/datum/overmap_location_data/proc/generate(atom/movable/overmap_object/object)
