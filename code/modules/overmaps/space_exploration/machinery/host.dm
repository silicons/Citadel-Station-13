/**
 * Host subtype
 * Things like control columns which provide access
 */
/obj/machinery/ship/host
	name = "ship controller host"
	/// the ship we're linked to, if any
	var/datum/ship/ship

/**
 * what control flags we give to an interface
 */
/obj/machinery/ship/host/proc/AllowControlFlags(obj/machinery/ship/interface/I, datum/ship/S)
