/**
 * Overmaps turfs
 *
 * Special snowflake moment
 */
/turf/overmap
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	icon = 'icons/overmap/turfs.dmi'
	blocks_air = TRUE
	density = FALSE
	opacity = FALSE
	plane = OVERMAP_BASE_PLANE
	baseturfs = /turf/baseturf_bottom

	/// don't yell at me please - for if someone in the future thinks reallocating overmaps is necessary
	var/allow_destroy = FALSE
	/// static lighting we're lit by
	var/list/atom/movable/overmap_lighting/lit_by

/turf/overmap/ChangeTurf(path, list/new_baseturfs, flags)
	return allow_destroy? ..() : FALSE

/turf/overmap/proc/UpdateLighting()
	if(length(lit_by))
		luminosity = 1
	else
		luminosity =
