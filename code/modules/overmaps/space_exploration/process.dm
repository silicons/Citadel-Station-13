/**
 * Simulation tick
 */
/datum/ship/proc/Tick(ds, times_fired)
	. = FALSE
	for(var/datum/ship_system/S in systems)
		. |= S.Tick(ds, times_fired)
	// do banking angle next
	if (parent.angle != target_angle)
		// nearest angle. Verify this pls
		if (parent.angle < target_angle)
			// our next turn
			var/nextturn = parent.angle - turning_radius
			// see if we overrun
			parent.angle = (nextturn > target_angle) ? target_angle : nextturn
		if (parent.angle > target_angle)
			// our next turn
			var/nextturn = parent.angle + turning_radius
			// see if we overrun
			parent.angle = (nextturn < target_angle) ? target_angle : nextturn

/**
 * Manual sim check
 */
/datum/ship/proc/ShouldProcess()
	for(var/datum/ship_system/S in systems)
		if(S.ShouldProcess())
			return TRUE
	return FALSE
