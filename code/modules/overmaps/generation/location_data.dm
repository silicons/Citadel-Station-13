/**
 * holds location data - used when an object is created to generate, if available
 */
/datum/overmap_location_data
	/// name of destination
	var/name = "???"
	/// location type - see [__DEFINES/overmaps/overmaps.dm]
	var/location_type

/datum/overmap_location_data/proc/generate(atom/movable/overmap_object/object)
