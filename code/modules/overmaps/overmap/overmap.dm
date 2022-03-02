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
	// setup turfs
	area = new OVERMAPS_AREA_TYPE(null)
	for(var/turf/T as anything in block(locate(1, 1, z), locate(size_x, size_y, z)))
		area.contents.Add(T)
		T.ChangeTurf(OVERMAPS_TURF_TYPE)
	// setup borders/etc
	MakeVisuals()

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
/datum/overmap/proc/InstantiateObject(path, x, y, angle, list/alist)
	if(!ispath(path, /atom/movable/overmap_object))
		CRASH("Wrong path")
	var/atom/movable/overmap_object/entity/O = path
	var/turf/where = GetTurf(x, y, initial(O.bound_height), initial(O.bound_width), initial(O.bound_x), initial(O.bound_y))
	if(alist)
		alist.Insert(1, where)
		O = new O(arglist(alist))
	else
		O = new(where)
	O.real_x = x
	O.real_y = y
	O.angle = angle
	O.MoveToOffsets()
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
	if(width < 7 || height < 7)
		// not worth bothering
		return
	// corners
	var/turf/NE = locate(width, height, z)
	var/turf/NW = locate(1, height, z)
	var/turf/SE = locate(width, 1, z)
	var/turf/SW = locate(1, 1, z)
	var/atom/movable/overmap_transition_holder/holder
	holder = new(null)
	NE.vis_contents += holder
	holder.vis_contents = block(locate(1, 1, z), locate(7, 7, z))
	holder.pixel_x = 32
	holder.pixel_y = 32
	holder = new(null)
	NW.vis_contents += holder
	holder.vis_contents = block(locate(width, 1, z), locate(width - 6, 7, z))
	holder.pixel_x = world.icon_size * -7
	holder.pixel_y = 32
	holder = new(null)
	SE.vis_contents += holder
	holder.vis_contents = block(locate(1, height, z), locate(7, height - 6, z))
	holder.pixel_x = world.icon_size
	holder.pixel_y = world.icon_size * -7
	holder = new(null)
	SW.vis_contents += holder
	holder.vis_contents = block(locate(width, height, z), locate(width - 6, height - 6, z))
	holder.pixel_x = world.icon_size * -7
	holder.pixel_y = world.icon_size * -7

	// cardinals
	for(var/i in 1 to width)
		var/turf/N = locate(i, height, z)
		var/turf/S = locate(i, 1, z)
		holder = new(null)
		N.vis_contents += holder
		holder.vis_contents = block(locate(i, 1, z), locate(i, 7, z))
		holder.pixel_x = 0
		holder.pixel_y = 32
		holder = new(null)
		S.vis_contents += holder
		holder.vis_contents = block(locate(i, height, z), locate(i, height - 6, z))
		holder.pixel_x = 0
		holder.pixel_y = world.icon_size * -7

	for(var/i in 1 to height)
		var/turf/E = locate(width, i, z)
		var/turf/W = locate(1, i, z)
		holder = new(null)
		E.vis_contents += holder
		holder.vis_contents = block(locate(1, i, z), locate(7, i, z))
		holder.pixel_x = 32
		holder.pixel_y = 0
		holder = new(null)
		W.vis_contents += holder
		holder.vis_contents = block(locate(width - 6, i, z), locate(width, i, z))
		holder.pixel_x = world.icon_size * -7
		holder.pixel_y = 0

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

