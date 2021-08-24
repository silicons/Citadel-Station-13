/**
 * CORE PROC: Returns the overmap object we're on, if any
 */
/atom/proc/GetOvermapObject()
	if(!isturf(src))
		return get_turf(src).GetOvermapObject()

/area/GetOvermapObject()

/turf/GetOvermapObject()


/**
 * represents the location an overmap object corrosponds to
 */
/datum/overmap_location
