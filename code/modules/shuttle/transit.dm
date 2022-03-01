/**
 * temporary docks used for transit
 */
/atom/movable/shuttle_dock/temporary/transit
	/// shuttle we belong to
	var/atom/movable/shuttle/owner
	/// are we a short or long transit? short transits are done using dynamic transit, long = level
	var/short_transit = TRUE
	/// turf reservation we belong to if we're a short transit
	var/datum/turf_reservation/reservation
	/// space level we belong to if we're a long transit
	var/datum/space_level/level

/atom/movable/shuttle_dock/temporary/transit/Destroy()
	owner = null
	if(owner.assigned_transit == src)
		owner.ClearTransit(FALSE)
	. = ..()
	qdel(reservation)

/**
 * used for long jump/overmaps transit
 */
/atom/movable/shuttle_dock/temporary/transit/overmap_flight
	short_transit = FALSE

/atom/movable/shuttle/proc/RequestShortTransit()

/atom/movable/shuttle/proc/RequestLongTransit()

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
