/datum/controller/subsystem/shuttle
	/// all shuttles
	var/static/list/atom/movbale/shuttle/shuttles = list()
	/// shuttles by id
	var/static/list/shuttle_by_id = list()

/datum/controller/subsystem/shuttle/proc/GetShuttle(id)
	. = shuttle_by_id(id)
	if(!.)
		stack_trace("Invalid shuttle lookup [id]")
