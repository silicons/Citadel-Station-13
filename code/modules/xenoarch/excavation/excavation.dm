/datum/component/excavation
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	/// current depth
	var/depth = 0

/datum/component/excavation/Initialize(_depth = 0)
	if(!isturF(parent))
		return COMPONENT_INCOMPATIBLE
	depth = _depth
	on_excavate(0, depth)
	return ..()

/datum/component/excavation/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, .proc/overlays)
	var/atom/A = parent
	A.update_overlays()

/datum/component/excavation/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS)
	var/atom/A = parent
	A.update_overlays()

/datum/component/excavation/proc/on_excavate(old_depth, new_depth)
	#warn signal

/datum/component/excavation/InheritComponent(datum/component/C, i_am_original, depth)
	var/old = depth
	src.depth += depth
	on_excavate(old, src.depth)
