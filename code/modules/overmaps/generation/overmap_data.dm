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

	/// How many POI should we place?
	var/poi_count = 100
