/**
 * Rigsuits
 */
/obj/item/rig
	name = "rig control module"
	desc = "This is broken! Contact a coder."
	icon = 'icons/modules/rigsuits/rigs.dmi'
	icon_state = ""

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
