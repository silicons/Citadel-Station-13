/**
 * Device subtype
 * Anything part of the ship
 * Right now, they directly connect to the ship, no network eneded
 */
/obj/machinery/ship/device
	name = "ship systems device"
	interaction_flags_machine = INTERACT_MACHINE_OPEN | INTERACT_MACHINE_OPEN_SILICON
	/// the ship we're linked to, if any
	var/datum/ship/ship
	/// the ship system datum we're linked to, if any
	var/datum/ship_system/system
	/// the tgui interface component we use - loaded as-is or with [ui-interface]Component if loaded from within a system.
	var/ui_interface
	/// can be directly controlled while panel is open
	var/direct_control = FALSE
	/// control severed from system wireless
	var/control_severed = FALSE
	/// can sever control from system
	var/can_disconnect = TRUE
	/// if exists, icon state when opened
	var/icon_state_open

// mark ui static data dirty
/obj/machinery/ship/device/proc/UpdateUIStatic()
	// system?.MarkUIDirty(src)
	update_static_data()

/obj/machinery/ship/device/ui_static_data(mob/user)
	. = ..()
	.["can_disconnect"] = can_disconnect
	.["disconnected"] = control_severed

/obj/machinery/ship/device/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(default_deconstruction_screwdriver(user, icon_state_open || icon_state, initial(icon_state), I))
		return
	if(circuit && default_deconstruction_crowbar(I))
		return
	if(wires && I.tool_behaviour == TOOL_MULTITOOL)
		wires.interact(user)

/obj/machinery/ship/device/ui_state(mob/user)
	. = ..()
	if(!panel_open || !direct_control)
		return UI_CLOSE

/obj/machinery/ship/device/ui_interact(mob/user, datum/tgui/ui)
	if(!direct_control)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, ui_interface)
		ui.open()
