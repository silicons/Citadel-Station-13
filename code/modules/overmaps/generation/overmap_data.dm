/**
 * data required to generate an overmap
 */
/datum/overmap_data
	/* asteroid tgen */
	/// terrain gen data
	var/string_gen
	///Chance of cells starting closed - we want more open cells
	var/initial_closed_chance = 15
	///Amount of smoothing iterations - might lower this, more clumps of space rocks.
	var/smoothing_iterations = 15
	///How much neighbours does a dead cell need to become alive - higher as we want small clumps
	var/birth_limit = 5
	///How little neighbours does a alive cell need to die - ditto
	var/death_limit = 2

	var/hazard_type = /atom/movable/overmap_object/hazard

/datum/overmap_data/proc/generate(datum/overmap/overmap)
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[overmap.width]", "[overmap.height]") //Generate the raw CA data
	var/turf/A = get_turf(locate(0, 0, overmap.z))
	var/turf/B = get_turf(locate(overmap.width, overmap.height, overmap.z))
	var/block = block(A, B)
	for(var/t in block)
		var/turf/T = t
		var/closed = text2num(string_gen[overmap.width * (T.y - 1) + T.x])
		if (closed)
			overmap.InstantiatePOIObject(hazard_type, T.loc.x, T.loc.y, 0, 0, 0)

/datum/overmap_data/asteroid
	// same as default
	initial_closed_chance = 15
	smoothing_iterations = 20
	birth_limit = 5
	death_limit = 2

	hazard_type = /atom/movable/overmap_object/hazard/asteroid

/datum/overmap_data/ion_storm
	// different numbers here TODO
	initial_closed_chance = 15
	smoothing_iterations = 12
	birth_limit = 4
	death_limit = 2

	hazard_type = /atom/movable/overmap_object/hazard/ion_storm
