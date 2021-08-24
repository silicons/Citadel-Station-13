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

/datum/ship/New(atom/movable/overmap_object/parent)
	src.parent = parent

/datum/ship/Destroy()
	if(parent)
		parent.ship = null
	return ..()
