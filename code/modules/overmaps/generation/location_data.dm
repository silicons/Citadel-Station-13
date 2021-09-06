/**
 * holds location data - used when an object is created to generate, if available
 */
/datum/overmap_location_data
	/// name of destination
	var/name = "???"
	/// location type - see [__DEFINES/overmaps/overmaps.dm]
	var/location_type
	/// lazyload - don't generate until someone tries to land/dock/etc
	var/lazyload = TRUE

/datum/overmap_location_data/proc/generate(atom/movable/overmap_object/object)
