/**
 * Machinery attacing to a ship
 * Will automatically update what their ship is on move
 */
/obj/machinery/ship
	name = "ship machinery"
	desc = "This is bugged."
	// icon = 'icons/modules/overmap/machinery.dmi'

// standard ui static data
/obj/machinery/ship/ui_static_data(mob/user)
	/// set to false from ship systems
	/// this means we're directly accessing the ui-interface, instead of from a control console.
	. = list("direct" = TRUE)

// standard ui data
/obj/machinery/ship/ui_data(mob/user)
	. = list()

// /obj/machinery/computer/
