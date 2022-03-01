/**
 * shuttle controllers
 *
 * shuttle controllers control the behavior of shuttles
 * e.g. the emergency shuttle isn't controllable, same with the cargo, they use the old call/recall system.
 */
/datum/shuttle_controller
	/// shuttle we're linked to
	var/atom/movable/shuttle/shuttle

/datum/shuttle_controller/New(atom/movable/shuttle/shuttle)



/datum/shuttle_controller/proc/RequestGracefulDock()
