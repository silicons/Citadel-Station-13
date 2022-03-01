/**
 * Overmaps turfs
 *
 * Special snowflake moment
 */
/turf/overmap
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	icon = 'icons/modules/overmaps/tile.dmi'
	icon_state = "turf"
	blocks_air = TRUE
	density = FALSE
	opacity = FALSE
	plane = OVERMAP_BASE_PLANE
	baseturfs = /turf/baseturf_bottom

	/// don't yell at me please - for if someone in the future thinks reallocating overmaps is necessary
	var/allow_destroy = FALSE

/turf/overmap/ChangeTurf(path, list/new_baseturfs, flags)
	return allow_destroy? ..() : FALSE
