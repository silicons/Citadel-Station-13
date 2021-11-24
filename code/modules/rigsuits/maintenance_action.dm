GLOBAL_LIST_INIT(rig_component_maintenance, init_rig_component_maintenance_actions())

/proc/init_rig_component_maintenance_actions()
	. = list()
	for(var/path in subtypesof(/datum/rig_component_maintenance))
		.[path] = new path

/**
 * Maintenance action datums
 */
/datum/rig_component_maintenance
	/// type of component - anything using this must be a subtype.
	var/component_type = /obj/item/rig_component
	/// icon
	var/icon = "question"
	/// name
	var/name = "Unknown"

/datum/rig_component_maintenance/proc/act(obj/item/rig/rig, obj/item/rig_component/component, mob/user)
	to_chat(user, "<span class='warning'>This maintenance action has no behavior defined! Whine at coders.")
