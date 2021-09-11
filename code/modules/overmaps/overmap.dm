GLOBAL_DATUM(overmap, /datum/overmap)

/proc/BuildOvermap()
	if(GLOB.overmap)
		return
	GLOB.overmap = new()
	GLOB.overmap.Initialize()


/**
 * master overmaps holder
 *
 * inits the zlevel and manges it
 */
/datum/overmap
	/// zlevel
	var/z
	/// zlevel datum
	var/datum/space_level/z_datum

	/// objects
	var/list/atom/movable/overmap_object/objects
	/// processing objects
	var/list/atom/movable/overmap_object/processing

	/* tgen */
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
	///prob of spawning a station
	var/station_prob = 20

	/// unique id
	var/id
	/// next id
	var/static/id_next = 0

/datum/overmap/New()
	id = ++id_next
	objects = list()
	processing = list()

/**
 * when an admin fucks up
 */
/datum/overmap/proc/Recover()
	if(!z)
		CRASH("No Z")
	objects = list()
	processing = list()
	for(var/atom/movable/overmap_object/O in Z_TURFS(z))
		objects += O
		O.overmap = src
		// if(O.IsMoving())
		// 	O.moving +=  O

/**
 * initialize
 */
/datum/overmap/proc/Initialize()
	InitializeLevel()

/**
 * # InitializeLevel
 * creates our zlevel
 *
 * ### crab related (see `rustg_cnoise_generate`)
 * ![funny crab](https://cdn.discordapp.com/emojis/839067599496675348.png?v=1)
 */
/datum/overmap/proc/InitializeLevel()
	if(z || z_datum)
		CRASH("Duplicate InitializeLevel detected: [z] [z_datum]")
	z_datum = SSmapping.add_new_zlevel("Overmap_[id]", list(ZTRAIT_LINKAGE = UNAFFECTED))
	z = z_datum.z_value

	// BEGIN generation (SPACE ASTEROID TGEN)
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]") //Generate the raw CA data
	var/turf/A = get_turf(locate(0, 0, z))
	var/turf/B = get_turf(locate(world.maxx, world.maxx, z))
	var/block = block(A, B)
	for(var/t in block)
		var/turf/T = t
		var/closed = text2num(string_gen[world.maxx * (T.y - 1) + T.x])
		// if it's closed, asteroid or emp. prob70 asteroid else emp
		// TODO: hazard here
		if (closed)
			if(prob(80))
				new /atom/movable/overmap_object/hazard(T.loc)
			else
				new /atom/movable/overmap_object/hazard(T.loc)
		else
			// station
			if(prob(20))
				new /atom/movable/overmap_object/preset/generated(T.loc)
			continue


/**
 * processing tick
 */
/datum/overmap/proc/Tick(ds, times_fired)
	for(var/atom/movable/overmap_object/O as anything in processing)
		O.Tick(ds, times_fired)

/**
 * Add an object
 */
/datum/overmap/proc/AddObject(atom/movable/overmap_object/O)
	if(O.overmap != null)
		CRASH("Wrong overmap")
	O.overmap = src
	objects += O
	if(O.ShouldProcess())
		processing += O

/**
 * Removes an object
 */
/datum/overmap/proc/RemoveObject(atom/movable/overmap_object/O)
	if(O.overmap != src)
		CRASH("Wrong overmap")
	O.overmap = null
	objects -= O
	processing -= O

/**
 * Instantiates an object in us
 */
/datum/overmap/proc/InstantiateObject(path, x, y, angle, list/alist)
	if(!ispath(path, /atom/movable/overmap_object))
		CRASH("Wrong path")
	var/atom/movable/overmap_object/O = path
	var/turf/where = GetTurf(x, y, initial(O.bound_height), initial(O.bound_width), initial(O.bound_x), initial(O.bound_y))
	O = new O(alist? where : arglist(list(where) + alist))
	O.real_x = x
	O.real_y = y
	O.angle = angle
	O.MoveToOffsets()

/**
 * Resolves the turf a given real x/y value is on
 */
/datum/overmap/proc/GetTurf(x, y, bound_width, bound_height, bound_x, bound_y)
	x += bound_x
	y += bound_y
	return locate(FLOOR(x / 32, 1) + 1, FLOOR(y / 32, 1) + 1, z)

