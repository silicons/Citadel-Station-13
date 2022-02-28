/datum/controller/subsystem/shuttle
	/// all shuttle docks
	var/static/list/atom/movable/shuttle_dock/docks = list()
	/// shuttle dock by id
	var/static/list/dock_by_id = list()

/datum/controller/subsystem/shuttle/proc/GetDock(id)
	. = dock_by_id[id]
	if(!.)
		stack_trace("Invalid dock lookup [id]")
