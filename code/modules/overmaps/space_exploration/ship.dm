/**
 * CORE PROC: Gets the ship we're on
 */
/atom/proc/GetShip()
	var/atom/movable/overmap_object/O = GetOvermapObject()
	if(!O)
		return
	return O.ship

/**
 * ships
 *
 * think about this like it's an extension to overmap objects
 */
/datum/ship
	/// our object
	var/atom/movable/overmap_object/parent
	/// subsystems by type
	var/list/datum/ship_system/systems
	/// all machinery in us
	var/list/obj/machinery/ship/machinery
	/// var list about helm

	/// bogeys detected
	var/list/bogeys = list(
		"enemy" = list(), // weakref of their ship datums?
		"friendly" = list(),
		"neutral" = list()
	)

/datum/ship/New(atom/movable/overmap_object/parent)
	src.parent = parent
	machinery = list()
	InitializeSystems()
	LinkMachinery()

/datum/ship/Destroy()
	UnlinkMachinery()
	DestroySystems()
	return ..()

/datum/ship/proc/InitializeSystems()

/datum/ship/proc/LinkMachinery()

/datum/ship/proc/DestroySystems()
	for(var/path in systems)
		qdel(systems[path])
	systems = null

/datum/ship/proc/UnlinkMachinery()

/datum/ship/Destroy()
	if(parent)
		parent.ship = null
	return ..()
