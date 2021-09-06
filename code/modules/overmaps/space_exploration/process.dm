/**
 * Simulation tick
 */
/datum/ship/proc/Tick(seconds, times_fired)
	. = FALSE
	for(var/datum/ship_system/S in systems)
		. |= S.Tick(seconds, times_fired)

/**
 * Manual sim check
 */
/datum/ship/proc/ShouldProcess()
	for(var/datum/ship_system/S in systems)
		if(S.ShouldProcess())
			return TRUE
	return FALSE
