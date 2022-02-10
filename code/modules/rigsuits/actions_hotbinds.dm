/**
 * includes all code for action handling
 */

/**
 * fully reloads hotbinds and actions
 */
/obj/item/rig/proc/rebuild_action_system()
	for(var/mob/M in users)
		reload_actions(M)

/**
 * fully cleans up hotbinds and actions
 */
/obj/item/rig/proc/cleanup_action_system()
	cleanup_all_hotbinds()
	cleanup_all_actions()

/obj/item/rig/proc/cleanup_actions(mob/M)

/obj/item/rig/proc/cleanup_all_actions()

/obj/item/rig/proc/reload_actions(mob/M)

/obj/item/rig/proc/generate_ui_action(mob/M)

/datum/action/rigsuit
	check_flags = AB_CHECK_ALIVE | AB_CHECK_CONSCIOUS

/datum/action/rigsuit/ui/Trigger()
	. = ..()
	var/obj/item/rig/target = src.target
	target.ui_interact(owner)

/datum/action/rigsuit/hotbind
	/// hotbind in question
	var/datum/rig_hotbind/hotbind

/datum/action/rigsuit/hotbind/Trigger()
	. = ..()
	if(!hotbind)
		return
	var/obj/item/rig/target = src.target
	target.hotbind_act(owner, hotbind)

/datum/rig_hotbind
	/// action string
	var/act
	/// params
	var/list/params
	/// object target, for quick lookup/cleanup
	var/obj/item/component
	/// static hotbind, shouldn't be deletable by users
	var/system = FALSE

/obj/item/rig/proc/hotbind_create(act, list/params, obj/item/rig_component/component)

/obj/item/rig/proc/hotbind_delete(datum/rig_hotbind/hotbind, force = FALSE)

/obj/item/rig/proc/cleanup_all_hotbinds()

/obj/item/rig/proc/cleanup_component_hotbinds(obj/item/component)

/obj/item/rig/proc/hotbind_act(mob/user, datum/rig_hotbind/bind)
