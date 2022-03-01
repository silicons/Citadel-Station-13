/**
 * bidirecitional dock check
 */
/atom/movable/shuttle/proc/CheckDock(atom/movable/shuttle_dock/dock, force)
	. = dock.CanDock(src, force)


	if(. != SHUTTLE_CAN_DOCK)
		return
	. = CanDock(dock, force)
	if(. != SHUTTLE_CAN_DOCK)
		return

/**
 * can we **physically** dock at a certain dock?
 *
 * @params
 * - dock - the dock
 * - force - force through things like obstructions. this is an **opinion** - if something, say, we don't fit in the world, happens,
 * 	we still can't dock!
 */
/atom/movable/shuttle/proc/CanDock(atom/movable/shuttle_dock/dock, force)
	. = dock.CanDock(src, force)


