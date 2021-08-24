/**
 * Overmaps turfs
 *
 * Special snowflake moment
 */
/turf/overmap
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	blocks_air = TRUE
	baseturfs = /turf/baseturf_bottom

	/// don't yell at me please - for if someone in the future thinks reallocating overmaps is necessary
	var/allow_destroy = FALSE

/turf/overmap/Initialize(mapload)
	flags_1 |= INITIALIZED_1

/turf/overmap/Initalize_Atmos()
	return		// no

/turf/overmap/ChangeTurf()
	return FALSE		// no
