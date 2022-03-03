/**
 * master overmaps holder
 *
 * inits the zlevel and manges it
 */
/datum/overmap
	/// zlevel
	var/z
	/// width in tiles
	var/width
	/// height in tiles
	var/height
	/// zlevel datum
	var/datum/space_level/z_datum
	/// our area
	var/area/area

	/// objects
	var/list/atom/movable/overmap_object/entities
	/// processing objects
	var/list/atom/movable/overmap_object/processing

	/// unique id
	var/id
	/// next id
	var/static/id_next = 0

	var/datum/overmap_data/asteroid/ast
	var/datum/overmap_data/ion_storm/ios

/datum/overmap/New()
	id = ++id_next
	entities = list()
	processing = list()

/datum/overmap/Destroy(force)
	if(!force)
		return QDEL_HINT_LETMELIVE
	RemoveVisuals()
	Unregister()
	return ..()

/**
 * initialize
 */
/datum/overmap/proc/Initialize(width, height, seed)
	CreateLevel(width, height)
	Register()

/datum/overmap/proc/Register()
	SSovermaps.overmaps += src
	SSovermaps.overmap_lookup["[z]"] = src

/datum/overmap/proc/Unregister()
	SSovermaps.overmaps -= src
	SSovermaps.overmap_lookup -= "[z]"

/**
 * # InitializeLevel
 * creates our zlevel
 */
/datum/overmap/proc/CreateLevel(size_x, size_y)
	if(z || z_datum)
		CRASH("Duplicate InitializeLevel detected: [z] [z_datum]")
	z_datum = SSmapping.add_new_zlevel("Overmap [id]", list(ZTRAIT_LINKAGE = UNAFFECTED))
	z = z_datum.z_value
	size_x = min(size_x, world.maxx)
	size_y = min(size_y, world.maxy)
	width = size_x
	height = size_y

	// setup turfs
	area = new OVERMAPS_AREA_TYPE(null)
	var/list/turfs = block(locate(1, 1, z), locate(size_x, size_y, z))
	for(var/turf/T as anything in turfs)
		T.ChangeTurf(OVERMAPS_TURF_TYPE, flags = CHANGETURF_SKIP)
	area.contents += turfs

	// setup borders/etc
	MakeVisuals()

	// generate
	Generate()

/**
 * processing tick
 */
/datum/overmap/proc/Tick(ds, times_fired)
	for(var/atom/movable/overmap_object/entity/O as anything in processing)
		if(!O.Tick(ds, times_fired))
			O.StopProcessing()

/**
 * Add an object
 */
/datum/overmap/proc/AddEntity(atom/movable/overmap_object/entity/O)
	if(O.overmap != null)
		CRASH("Wrong overmap")
	O.overmap = src
	entities += O
	if(O.ShouldProcess())
		O.StartProcessing()

/**
 * Removes an object
 */
/datum/overmap/proc/RemoveEntity(atom/movable/overmap_object/entity/O)
	if(O.overmap != src)
		CRASH("Wrong overmap")
	if(O.datum_flags & DF_ISPROCESSING)
		O.StopProcessing()
	entities -= O
	processing -= O
	O.overmap = null

/**
 * Instantiates an object in us
 */
/datum/overmap/proc/InstantiateObject(path, x, y, step_x, step_y, angle, list/alist)
	if(!ispath(path, /atom/movable/overmap_object))
		CRASH("Wrong path")
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

/**
 * Resolves the turf a given real x/y value is on
 */
/datum/overmap/proc/GetTurf(x, y, bound_width, bound_height, bound_x, bound_y)
	x += bound_x
	y += bound_y
	#warn handle edge wraparound
	return locate(FLOOR(x / 32, 1) + 1, FLOOR(y / 32, 1) + 1, z)

/**
 * called after a subsystem hard reset, after entities are placed in here.
 */
/datum/overmap/proc/Recover()
	#warn redo turfs, areas, undo transitions, redo transitions

/**
 * make visual transitions
 */
/datum/overmap/proc/MakeVisuals()
	if(width < 15 || height < 15)
		// not worth bothering
		return
	// corners
	var/turf/NE = locate(width - 1, height - 1, z)
	var/turf/NW = locate(2, height - 1, z)
	var/turf/SE = locate(width - 1, 2, z)
	var/turf/SW = locate(2, 2, z)
	var/atom/movable/overmap_transition_holder/holder
	holder = new(NE)
	holder.vis_contents = block(locate(2, 2, z), locate(8, 8, z))
	holder = new(NW)
	holder.vis_contents = block(locate(width - 1, 2, z), locate(width - 7, 8, z))
	holder.pixel_x = world.icon_size * -6
	holder.pixel_y = 0
	holder = new(SE)
	holder.vis_contents = block(locate(2, height - 1, z), locate(8, height - 7, z))
	holder.pixel_x = 0
	holder.pixel_y = world.icon_size * -6
	holder = new(SW)
	holder.vis_contents = block(locate(width - 1, height - 1, z), locate(width - 7, height - 7, z))
	holder.pixel_x = world.icon_size * -6
	holder.pixel_y = world.icon_size * -6

	// cardinals
	for(var/i in 2 to width - 1)
		var/turf/N = locate(i, height - 1, z)
		var/turf/S = locate(i, 2, z)
		holder = new(N)
		holder.vis_contents = block(locate(i, 2, z), locate(i, 8, z))
		holder.pixel_x = 0
		holder.pixel_y = 0
		holder = new(S)
		holder.vis_contents = block(locate(i, height - 1, z), locate(i, height - 7, z))
		holder.pixel_x = 0
		holder.pixel_y = world.icon_size * -6
		CHECK_TICK

	for(var/i in 2 to height - 1)
		var/turf/E = locate(width - 1, i, z)
		var/turf/W = locate(2, i, z)
		holder = new(E)
		holder.vis_contents = block(locate(2, i, z), locate(8, i, z))
		holder.pixel_x = 0
		holder.pixel_y = 0
		holder = new(W)
		holder.vis_contents = block(locate(width - 7, i, z), locate(width - 1, i, z))
		holder.pixel_x = world.icon_size * -6
		holder.pixel_y = 0
		CHECK_TICK

/**
 * teardown visuals
 */
/datum/overmap/proc/RemoveVisuals()
	for(var/turf/T as anything in Turfs())
		T.vis_contents = null
		T.vis_locs = null

/**
 * get all turfs in us
 */
/datum/overmap/proc/Turfs()
	return block(
		locate(1, 1, z),
		locate(width, height, z)
	)

