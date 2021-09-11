
/obj/machinery/ship/device/radar
	name = "NTelstar Incorporated™ High-Band Distant Object Detector Module"
	desc = "A high-powered radar used for detecting ships and verifying their IFF when in range."
	idle_power_usage = 10
	active_power_usage = 500
	use_power = IDLE_POWER_USE

	var/enabled = FALSE
	var/range = 8

/obj/machinery/ship/device/radar/Initialize()
	. = ..()
	// todo: ship system

/obj/machinery/ship/device/radar/proc/toggle_power()
	var/datum/ship_system/radar/R = system
	enabled = !enabled
	if (enabled)
		use_power = ACTIVE_POWER_USE
	else
		use_power = IDLE_POWER_USE


/obj/machinery/ship/device/radar/ui_data(mob/user)
	. = ..()
	if (!.)
		return

	// .["bogeys"] = ship.bogeys
	.["enabled"] = enabled
// todo: steal camera code
