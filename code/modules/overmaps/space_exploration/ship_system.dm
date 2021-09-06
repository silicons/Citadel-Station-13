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
	/// name
	var/name = "System (unknown)"
	/// Devices in us **and controllable**
	var/list/obj/machinery/ship/device/devices
	/// ui data id
	var/data_id

/datum/ship_system/New(datum/ship/ship)
	src.ship = ship
	devices = list()

/datum/ship_system/Destroy(force, ...)
	ship = null
	return ..()
