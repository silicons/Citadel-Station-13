/**
 * Holds the maintenance panel of a rigsuit.
 *
 * Tab 1: Physical
 * Bottom:
 * One section column for every rig zone, with the components on them
 * Master components list at top right, rig pieces on top left
 *
 * Tab 2: Control Module
 * Right side: Debug interface
 * Left side: Wires, battery jack, buttons, etc
 */
/datum/rig_maintenance_ui
	/// parent rig
	var/obj/item/rig/rig

/datum/rig_maintenance_ui/New(obj/item/rig/rig)
	if(rig)
		src.rig = rig

/datum/rig_maintenance_ui/Destroy()
	rig = null
	return ..()

/datum/rig_maintenance_ui/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RigMaintenance", "[rig.name]")
		ui.open()

/datum/rig_maintenance_ui/ui_static_data(mob/user)
	. = ..()

/datum/rig_maintenance_ui/ui_data(mob/user)
	. = ..()

/datum/rig_maintenance_ui/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

