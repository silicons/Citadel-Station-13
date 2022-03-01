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

/**
 * source can be null, destination can be null
 */
/datum/shuttle_controller/proc/OnMove(atom/movable/shuttle_dock/source, atom/movable/shuttle_dock/destination)
