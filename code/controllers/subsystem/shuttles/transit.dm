/datum/controler/subsystem/shuttle
	/// shuttles in dynamic transit
	var/static/list/atom/movable/shuttle/in_transit = list()
	/// shuttles in long jump
	var/static/list/atom/movable/shuttle/long_jump = list()
	/// list of space level datums we can use for long jump that are free
	var/static/list/datum/space_level/unused_jump_levels = list()
	/// list of allocated level datums associated to a list of all the shuttles in them
	var/static/list/datum/space_level/allocated_jump_levels = list()

/datum/controller/subsystem/shuttle/proc/RequestShortTransit(atom/movable/shuttle/shuttle)

/datum/controller/subsystem/shuttle/proc/RequestLongTransit(atom/movable/shuttle/shuttle)
