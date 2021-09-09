/**
 * Ship systems
 *
 * represents sets of related objects and controls
 */
/datum/ship_system
	/// master ship
	var/datum/ship/ship
	/// sort order. below 0 goes to left of the map
	var/sort_order = 1
	/// name
	var/name = "System (unknown)"
	/// Devices connected
	var/list/obj/machinery/ship/device/devices
	/// ui data id
	var/data_id
	/// interface component id - defaults to a list of devices but we need special stuff for stuff like helm
	var/interface_id = "OvermapShipSystem"

/datum/ship_system/New(datum/ship/ship)
	src.ship = ship
	devices = list()

/datum/ship_system/Destroy()
	ship = null
	devices = null
	return ..()

/**
 * Simulation tick
 * Return TRUE when a system needs to keep ticking
 */
/datum/ship_system/proc/Tick(ds, times_fired)
	return ShouldProcess()

/**
 * Manual check if we should keep processing
 */
/datum/ship_system/proc/ShouldProcess()
	return FALSE
