/**
 * Ship systems
 *
 * represents sets of related objects and controls
 */
/datum/ship_system
	/// master ship
	var/datum/ship/ship
	/// sort order
	var/sort_order = 0

/datum/ship_system/New(datum/ship/ship)
	src.ship = ship

/datum/ship_system/Destroy(force, ...)
	ship = null
	return ..()
