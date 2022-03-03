/datum/overmap/proc/Generate()
	// "TERRAIN" PHASE - ASTEROIDS & ION STORMS (TO BE IMPLEMENTED)
	ast = new /datum/overmap_data/asteroid()
	ast.generate(src)

	CHECK_TICK

	ios = new /datum/overmap_data/ion_storm()
	ios.generate(src)

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

/**
 * Creates a new POI with respect on it's banned spawn places
 */
/datum/overmap/proc/InstantiatePOIObject(path, x, y, angle, step_x, step_y, list/alist)
	// implement me
	var/turf/t = locate(x, y, z)
	if (t.contents)
		return; // n o

	var/atom/movable/overmap_object/entity/O = path
	var/turf/where = GetTurf(x, y, initial(O.bound_height), initial(O.bound_width), initial(O.bound_x), initial(O.bound_y))
	if(alist)
		alist.Insert(1, where)
		O = new O(arglist(alist))
	else
		O = new(where)
	O.angle = angle
	O.forceMove(O.loc, step_x, step_y)
	return O

