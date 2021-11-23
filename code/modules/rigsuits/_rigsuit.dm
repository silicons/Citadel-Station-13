/**
 * Rigsuits
 */
/obj/item/rig
	name = "rig control module"
	desc = "This is broken! Contact a coder."
	icon = 'icons/modules/rigsuits/rigs.dmi'
	icon_state = ""

	// Basics
	/// Active theme
	var/datum/rig_theme/theme = /datum/rig_theme

	// Pieces
	/// all pieces
	var/list/obj/item/pieces

	// Components
	/// all components
	var/list/obj/item/rig_component/components

	// Integrals - singleton components
	/// armor
	var/obj/item/rig_component/integral/armor/integral_armor
	/// environmental
	var/obj/item/rig_component/integral/environmental/integral_environmental
	/// headlamp
	var/obj/item/rig_component/integral/light/integral_light
	/// magboots
	var/obj/item/rig_component/integral/magboots/integral_magboots

	// Logistics
	/// Cached slot usage - ordered tuple based on theme
	var/list/cached_slots
	/// Cached size usage - ordered tuple based on theme
	var/list/cached_sizes
	/// Cached weight
	var/cached_weight

	// Control
	/// users - associated to control flag
	var/list/users
	/// master user - effectively can do everything - usually the pilot, if it isn't, they're probably being hijacked
	var/mob/living/owner

	// Maintenance
	/// debug log - up to 20 entries, output by debug interface
	var/list/debug_logz

	// UI
	/// list of components that need their ui_data updated
	var/list/obj/item/rig_component/ui_update_pending
	/// list of components that need their ui_static_data updated
	var/list/obj/item/rig_component/ui_static_update_pending
	/// list of components that need their ui_data for the maintenance panel updated
	var/list/obj/item/rig_component/maintenance_ui_update_pending
	/// list of components that need their ui_static_data for the maintenance panel updated
	var/list/obj/item/rig_component/maintenance_ui_static_update_pending
	/// ui static update timerid for both normal and maintenance panel
	var/static_update_timerid
	/// debug log needs flushing?
	var/flush_debug_log = FALSE

// WARNING: Quick deploy onto only supports humans with back slots for now!
/obj/item/rig/Initialize(mapload, datum/rig_theme/theme_override, mob/living/carbon/human/quick_deploy_onto)
	. = ..()
	apply_theme(theme_override || theme)
	if(quick_deploy_onto)
		qdel(quick_deploy_onto.back)
		quick_deploy_onto.equip_to_slot(src, SLOT_BACK)
		activate()

/obj/item/rig/Destroy()
	deactivate()
	delete_everything()
	return ..()

/**
 * Completely rebuilds ordered tuples, hotbinds, actions, and other "synchronized" datastructures
 * For when admins are dunces
 */
/obj/item/rig/proc/rebuild_internal_datastructures()
#warn rebuild cached slots
#warn rebuild cached sizes
#warn rebuild cached weight
#warn rebuild integrals
#warn rebuild ui updates

/**
 * Applies a theme
 *
 * @param
 * - theme - theme to apply
 * - destroy_conflicting - delete conflicting modules rather than drop them
 * - destroy_all - delete everything and apply the theme, effectively resetting the rig
 */
/obj/item/rig/proc/apply_theme(datum/rig_theme/theme, destroy_conflicting = FALSE, destroy_all = FALSE)

/**
 * Deletes everything attached to us
 */
/obj/item/rig/proc/delete_everything()

/**
 * Factory reset proc - Resets to our state at creation
 */
/obj/item/rig/proc/factory_reset()
	apply_theme(theme, FALSE, TRUE)
