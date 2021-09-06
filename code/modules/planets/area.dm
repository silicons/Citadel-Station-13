/area
	/// Are we considered an exterior area
	var/exterior = FALSE

/**
 * Are we considered an exterior area for planetary purposes
 */
/area/proc/IsExterior()



/**
 * PLANETGEN AREA: For attempting to instantiate a planet with an existing zlevel set, this marks an area as free-to-use for generation
 */
/area/planetgen_marker
	name = "Planetary Seeded"
	desc = "You shouldn't see this; The area should be replaced by planetgen ASAP."
