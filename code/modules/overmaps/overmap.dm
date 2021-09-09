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
 * creates our zlevel
 */
/datum/overmap/proc/InitializeLevel()
	if(z || z_datum)
		CRASH("Duplicate InitializeLevel detected: [z] [z_datum]")
	z_datum = SSmapping.add_new_zlevel("Overmap_[id]", list(ZTRAIT_LINKAGE = UNAFFECTED))
	z = z_datum.z_value

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

