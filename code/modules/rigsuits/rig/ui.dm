/**
 * Rig UI
 *
 * Oriented in portrait.
 *
 * Tab 1: Primary
 * Top section: stats on left, pieces/deployment on right
 * Bottom section: Modules by zone.
 *
 * Tab 2: Debug interface - see maintenance UI
 *
 * Tab 3: Permissions panel
 */

/**
 * Queues a component to have its rig_ui_data() sent on next ui_data()
 */
/obj/item/rig/proc/queue_ui_update(obj/item/rig_component/C)

/**
 * Queues a component to have its rig_ui_static_data() sent on next ui_data()
 */
/obj/item/rig/proc/queue_ui_static_update(obj/item/rig_component/C)



/obj/item/rig/ui_status(mob/user)
	. = ..()

/obj/item/rig/ui_state(mob/user)
	. = ..()

/obj/item/rig/ui_static_data(mob/user)
	. = ..()

/**
 * Our internal ui static data
 * The reason for this is so we can cache ourselves for a flush without resending all component reflists and other datas.
 */
/obj/item/rig/proc/ui_static_data_internal(mob/user)
	. = list()

/**
 * Generates reflists for components
 */
/obj/item/rig/proc/ui_static_module_reflist()
	. = list()
	var/list/component_refs = list()
	for(var/i in components)
		component_refs += REF(i)
	var/list/piece_refs = list()
	for(var/i in pieces)
		piece_refs += REF(i)
	.["components"] = component_refs
	.["pieces"] = piece_refs

/obj/item/rig/ui_data(mob/user)
	. = ..()

/obj/item/rig/ui_act(action, params)
	. = ..()
