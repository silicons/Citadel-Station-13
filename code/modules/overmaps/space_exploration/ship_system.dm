/**
 * Ship systems
 *
 * represents sets of related objects and controls
 */
/datum/ship_system
	/// master ship
	var/datum/ship/ship

/datum/ship_system/New(datum/ship/ship)
	src.ship = ship

/datum/ship_system/Destroy(force, ...)
	ship = null
	return ..()
