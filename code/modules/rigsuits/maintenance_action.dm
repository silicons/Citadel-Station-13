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

/datum/rig_component_maintenance/fix_brute
	name = "Fix Plating"
	icon = "tg-welding-torch"

/datum/rig_component_maintenance/fix_brute/act(obj/item/rig/rig, obj/item/rig_component/component, mob/user)

/datum/rig_component_maintenance/fix_burn
	name = "Fix Plating"
	icon = "tg-cable-coil"

/datum/rig_component_maintenance/fix_burn/act(obj/item/rig/rig, obj/item/rig_component/component, mob/user)

/**
 * "Maintenance" action of damaging a component.
 *
 * Uses a held weapon as a blunt force, uses a held gun to shoot if harm intent
 */
/datum/rig_component_maintenance/damage
	name = "Strike"
	icon = "fist"

/datum/rig_component_maintenance/damage/act(obj/item/rig/rig, obj/item/rig_component/component, mob/user)

/datum/rig_component_maintenance/attach
	name = "Attach/Detach"
	icon = "tg-screwdriver"

/datum/rig_component/maintenance/attach/act(obj/item/rig/rig, obj/item/rig_component/component, mob/user)
