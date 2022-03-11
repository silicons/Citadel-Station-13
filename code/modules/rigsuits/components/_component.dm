/**
 * Base type of rig components.
 */
/obj/item/rig_component
	/// name shown in rig - defaults to name
	var/component_name
	/// desc shown in rig - defaults to desc
	var/component_desc
	/// Currently attached rig. Set by rig attach/detach procs.
	var/obj/item/rig/host
	/// Rig component type
	var/component_type = RIG_COMPONENT_GENERIC
	/// UI name
	var/ui_name = "RigComponent"
	/// Weight of this component - this affects stats like power usage and slowdown
	var/weight = RIG_COMPONENT_WEIGHT_NONE
	/// Slots used - a section must have enough slots to support this module
	var/slots = RIG_COMPONENT_SLOTS_NONE
	/// Size used - a section must have enough free space to support this module
	var/size = RIG_COMPONENT_SIZE_NONE
	/// Prevent the **exact** same type of component from being mounted if one's already in ANY of the sections this occupies
	var/prevent_duplicates = TRUE
	/// Automatically allow changing attachment side of this component for arms/legs
	var/allow_changing_side = TRUE
	/// Prevent anything with these conflict types from being mounted if there's one in any sections that this occupies
	var/conflicts_with_locally = RIG_CONFLICT_NONE
	/// Prevent anything with these conflict types from being mounted if there's any in the entire rigsuit
	var/conflicts_with = RIG_CONFLICT_NONE
	/// Rig zones this occupies.
	var/rig_zone = RIG_FLAG_CHEST
	/// Allowed suit types, flags.
	var/allowed_suit_types = ALL
	/// Is this component considered an "abstract component" aka unremovable, can't be used in other suits.
	var/internal = FALSE
	/// Maintenance actions
	var/list/maintenance_actions
	/// Brute damage
	var/brute_dam = 0
	/// Burn damage
	var/burn_dam = 0
	/// Max integrity
	var/max_dam = 100

/obj/item/rig_component/Initialize()
	if(maintenance_actions)
		maintenance_actions = typelist("maintenance_actions", maintenance_actions)
	return ..()

/**
 * Called when being attached to a suit.
 *
 * Slots, size, weight, conflicts, suit types, internal, are all checked by the suit. Use this for custom behavior.
 *
 * @return Whether or not we should attach
 */
/obj/item/rig_component/proc/can_attach(obj/item/rig/rig)
	return TRUE

/**
 * Checks if we can be detached.
 *
 * Slots, size, weight, conflicts, suit types, internal, are all checked by the suit. Use this for custom behavior.
 *
 * @return Whether or not we can be detached
 */
/obj/item/rig_component/proc/can_detach(obj/item/rig/rig)
	return TRUE

/**
 * Called when attached to a suit.
 *
 * Cached slots/weight/conflicts updates are all handled by the suit. Use this for custom behavior.
 *
 * @params
 * * rig - The control module being attached into
 * * rig_creation - Being created and attached as part of default modules.
 */
/obj/item/rig_component/proc/on_attach(obj/item/rig/rig, rig_creation = FALSE)
	return

/**
 * Called when detached from a suit.
 *
 * Cached slots/weight/conflicts updates are all handled by the suit. Use this for custom behavior.
 *
 * @params
 * * rig - The control module being attached into
 */
/obj/item/rig_component/proc/on_detach(obj/item/rig/rig)

/**
 * UI data for this piece.
 * Static.
 */
/obj/item/rig_component/proc/rig_ui_static_data(mob/user)
	. = list()
	.["ui"] = ui_name
	.["name"] = component_name || name
	.["desc"] = component_desc || desc
	.["options"] = rig_options_static()

/**
 * UI data for this piece.
 */
/obj/item/rig_component/proc/rig_ui_data(mob/user)
	. = list()
	.["options"] = rig_options_data()

/**
 * UI act on piece
 */
/obj/item/rig_component/proc/rig_ui_act(action, params)
	if(params["option"])
		rig_option_act(params["id"], params)
		update_ui()
		return


/**
 * Called when an option is invoked.
 * All option handling code goes in HERE.
 */
/obj/item/rig_component/proc/rig_option_act(id, params)
	return

/**
 * UI options
 *
 * Returns a list of action type = list(params), see __DEFINES/rigsuits/ui.dm
 * This should hold **static** data only. Static params go in here, list[RIG_UI_OPTION_TYPE_DEFINE] = list(params)
 *
 * The reason this is a proc is because no admin in their right mind should ever try to varedit this.
 */
/obj/item/rig_component/proc/rig_options_static()
	return list()

/**
 * UI options
 *
 * Returns a list of action type = list(params), see __DEFINES/rigsuits/ui.dm
 * This should hold **normal** data only. Params go in here, list(list(params), list(params), ...). Same order as rig_options_static for each option.
 *
 * The reason this is a proc is because no admin in their right mind should ever try to varedit this.
 */
/obj/item/rig_component/proc/rig_options_data()

/**
 * Call this to update our UI data. We don't constantly resend data to save performance.
 */
/obj/item/rig_component/proc/update_ui()
	host?.queue_ui_update(src)

/**
 * Call this to flush static data update.
 */
/obj/item/rig_component/proc/update_ui_static()
	host?.queue_ui_static_update()

#warn impl all of this
/obj/item/rig_component/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	// welder check

	// cable coil check

	// screwdriver check

/obj/item/rig_component/proc/auto_change_side(mob/living/user)

/obj/item/rig_component/proc/considered_side_mounted()

/obj/item/rig_component/proc/is_left_side()

