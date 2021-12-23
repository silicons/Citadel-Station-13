/**
 * Exonet Control Protocol holders
 *
 * All objects may have one, allowing them to receive/respond to commands.
 *
 * Commands: command arg1 arg2 arg3, etc
 * Response: list(statuscode, message)
 */
/datum/exonet_control_protocol


/datum/exonet_control_protocol/proc/process_command(command, list/args, sender_id)
	return list(STATUS_CODE_INVALID_COMMAND, "No such command exists.")

/datum/exonet_control_protocol/proc/process_security(command, list/args, sender_id)
