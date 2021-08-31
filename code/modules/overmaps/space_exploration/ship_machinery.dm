/**
 * Machinery attacing to a ship
 * Will automatically update what their ship is on move
 */
/obj/machinery/ship
	name = "ship machinery"
	desc = "This is bugged."
	icon = 'icons/overmap/machinery.dmi'

	/// the object we belong to, if any
	var/atom/movable/overmap_object/object
	/// the ship we're linked to, if any
	var/datum/ship/ship
	/// the ship system datum we're linked to, if any
	var/datum/ship_system/system

	/// the tgui interface component we use
	var/ui_interface

// mark ui static data dirty
/obj/machinery/ship/proc/UpdateUIStatic()
	system.MarkUIDirty(src)

// standard ui static data
/obj/machinery/ship/ui_static_data(mob/user)
	. = list()

// standard ui data
/obj/machinery/ship/ui_data(mob/user)
	. = list()

/**
 * Device subtype
 * Anything part of the ship
 * Right now, they directly connect to the ship, no network eneded
 */
/obj/machinery/ship/device
	name = "ship systems device"

/**
 * Interface subtype
 * Controls the ship
 * Uses control columns to get what the can control
 */
/obj/machinery/ship/interface
	name = "ship control interface"

	/// connected control columns
	var/list/obj/machinery/ship/host/hosts

/obj/machinery/ship/interface/Initialize(mapload)
	. = ..()
	hosts = list()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/ship/interface/LateInitialize()


/obj/machinery/ship/interface/proc/UpdateHosts()
	hosts = GetConnectedHosts()

/obj/machinery/ship/interface/proc/GetConnectedHosts()
	. = list()

/obj/machinery/ship/interface/proc/AllowedControlFlags()
	. = NONE
	for(var/obj/machinery/ship/host/host as anything in hosts)
		. |= host.AllowControlFlags(src, ship)

/**
 * Host subtype
 * Thinsg like control columns which provide access
 */
/obj/machinery/ship/host
	name = "ship controller host"

/**
 * what control flags we give to an interface
 */
/obj/machinery/ship/host/proc/AllowControlFlags(obj/machinery/ship/interface/I, datum/ship/S)
