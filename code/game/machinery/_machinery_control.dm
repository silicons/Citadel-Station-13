/**
 * methods to control machinery stuff remotely.
 * everything from ntnet to airlock controllers using radio to air alarms should use this.
 */
/obj/machinery
	/// remote control status
	var/remote_control = MACHINERY_REMOTE_DISABLED


/obj/machinery/proc/run_command(command, list/params)
	return

/obj/machinery/receive_signal(datum/signal/signal)
	. = ..()

/obj/machinery/

#warn ughh
