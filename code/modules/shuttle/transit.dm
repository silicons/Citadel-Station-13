/**
 * temporary docks used for transit
 */
/atom/movable/shuttle_dock/temporary/transit
	/// shuttle we belong to
	var/atom/movable/shuttle/owner
	/// turf reservation we belong to
	var/datum/turf_reservation/reservation

/atom/movable/shuttle_dock/temporary/transit/Destroy()
	owner = null
	if(owner.assigned_transit == src)
		owner.ClearTransit(FALSE)
	. = ..()
	qdel(reservation)

/**
 * used for long jump/overmaps transit
 */
/atom/movable/shuttle_dock/temporary/transit/long_jump

/atom/movable/shuttle/proc/RequestTransit()

/atom/movable/shuttle/proc/ClearTransit(qdel = TRUE)
	if(!assigned_transit)
		return
	if(docked == assigned_transit)
		// uh oh
		#warn impl
	if(qdel)
		QDEL_NULL(assigned_transit)
	else
		assigned_transit = null
