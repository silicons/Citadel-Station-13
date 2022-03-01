/**
 * CORE PROC: Returns the overmap object we're on, if any
 */
/atom/proc/GetOvermapObject()
	if(!isturf(src))
		var/turf/T = get_turf(src)
		return T?.GetOvermapObject()
	CRASH("Why did root atom get called on a turf??")

/area/GetOvermapObject()



/turf/GetOvermapObject()
	// return loc.GetOvermapObject() || SSovermaps.GetOvermapObject(z)


/**
 * represents the location an overmap object corrosponds to
 */
/datum/overmap_location
	/// parent object
	var/atom/movable/overmap_object/parent

