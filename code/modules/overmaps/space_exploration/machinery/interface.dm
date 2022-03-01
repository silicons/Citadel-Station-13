/**
 * Interface subtype
 * Controls the ship
 * Uses control columns to get what they can control
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
	// for(var/obj/machinery/ship/host/host as anything in hosts)
		// . |= host.AllowControlFlags(src, ship)
