/**
 * Machinery attacing to a ship
 * Will automatically update what their ship is on move
 */
/obj/machinery/ship
	name = "ship machinery"
	desc = "This is bugged."
	icon = 'icons/overmap/machinery.dmi'

// standard ui static data
/obj/machinery/ship/ui_static_data(mob/user)
	. = list("direct" = TRUE)

// standard ui data
/obj/machinery/ship/ui_data(mob/user)
	. = list()

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
	system?.MarkUIDirty(src)
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

/**
 * Interface subtype
 * Controls the ship
 * Uses control columns to get what the can control
 */
/obj/machinery/ship/interface
	name = "ship control interface"

	/// connected control columns
	var/list/obj/machinery/ship/host/hosts

/obj/machinery/ship/interface/Initialize(mapload)
	. = ..()
	hosts = list()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/ship/interface/LateInitialize()


/obj/machinery/ship/interface/proc/UpdateHosts()
	hosts = GetConnectedHosts()

/obj/machinery/ship/interface/proc/GetConnectedHosts()
	. = list()

/obj/machinery/ship/interface/proc/AllowedControlFlags()
	. = NONE
	for(var/obj/machinery/ship/host/host as anything in hosts)
		. |= host.AllowControlFlags(src, ship)

/**
 * Host subtype
 * Things like control columns which provide access
 */
/obj/machinery/ship/host
	name = "ship controller host"
	/// the ship we're linked to, if any
	var/datum/ship/ship

/**
 * what control flags we give to an interface
 */
/obj/machinery/ship/host/proc/AllowControlFlags(obj/machinery/ship/interface/I, datum/ship/S)
