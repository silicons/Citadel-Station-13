/datum/overmap/proc/Generate()
/*

	// "TERRAIN" PHASE - ASTEROIDS & ION STORMS (TO BE IMPLEMENTED)
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]") //Generate the raw CA data
	var/turf/A = get_turf(locate(0, 0, z))
	var/turf/B = get_turf(locate(world.maxx, world.maxx, z))
	var/block = block(A, B)
	for(var/t in block)
		var/turf/T = t
		var/closed = text2num(string_gen[world.maxx * (T.y - 1) + T.x])
		if (closed)
			InstantiateObject(/atom/movable/overmap_object/hazard, T.loc.x, T.loc.y)

	CHECK_TICK

	// POI(1) PHASE - STATIONS & PLANETS
	// for (var/i in max_ruins) => place POIs at random places.

	// POI(2) PHASE - SHIPS
	// for (var/i in max_ruins) => place POIs at random places.

	CHECK_TICK

	// DECORATE PHASE
	// then finally place the ship & other static things
	// place it on center: we have to do some check to see if it a: issn't stuck in rocks or b: isn't trapped in rocks (pocketed)
	// place somewhre on the map: random, if rock then we go againe, probably will not place the ship in rock pockets right? <- clueless
*/

/**
 * Creates a new POI with respect on it's banned spawn places
 */
/datum/overmap/proc/InstantiatePOIObject(atom/movable/overmap_object/thing, x, y, angle, list/alist)
	// implement me
	return InstantiateObject(thing, x, y, angle, alist)
