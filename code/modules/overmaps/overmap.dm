GLOBAL_DATUM(overmap, datum/overmap)

/proc/BuildOvermap()
	if(GLOB.overmap)
		return
	GLOB.overmap = New()
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

/datum/overmap/New()
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
		if(O.IsMoving())
			moving +=  O

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
	z = z_datum.z

/**
 * processing tick
 */
/datum/overmap/proc/Tick(seconds, times_fired)
	for(var/atom/movable/overmap_object/O as anything in processing)
		O.Tick(seconds, times_fired)
