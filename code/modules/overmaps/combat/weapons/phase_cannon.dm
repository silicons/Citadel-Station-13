

/obj/machinery/ship/weapon/simple/phase_cannon
	name = "phase cannon"
	// icon = 'icons/obj/96x96.dmi'
	icon_state = "phase_cannon"
	circuit = /obj/item/circuitboard/machine/weapon/phase_cannon
	reload_delay = 10 SECONDS
	damage_type = list(DAMAGE_SHIELD = 10, DAMAGE_HULL = 5)

	// projectile = /obj/item/projectile/overmap_projectile/energy

/obj/machinery/ship/weapon/simple/phase_cannon/Initialize()
	. = ..()

	RefreshParts()

/obj/machinery/ship/weapon/simple/phase_cannon/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS, null, CALLBACK(src, .proc/can_be_rotated))

/obj/machinery/ship/weapon/simple/phase_cannon/proc/can_be_rotated(mob/user,rotation_type)
	if (anchored)
		to_chat(user, "<span class='warning'>It is fastened to the floor!</span>")
		return FALSE
	return TRUE


/obj/machinery/ship/weapon/simple/phase_cannon/RefreshParts()
	var/firedelay = 10 SECONDS // 2 min max (60*(4*2))
	for(var/obj/item/stock_parts/micro_laser/L in component_parts)
		firedelay -= 10 * L.rating
	reload_delay = firedelay
	// for(var/obj/item/stock_parts/manipulator/M in component_parts)
	// 	power_usage -= 50 * M.rating
	// active_power_usage = power_usage

// /obj/machinery/ship/weapon/simple/phase_cannon/reload_entirely()
// 	. = ..()


/obj/item/circuitboard/machine/weapon
	name = "undefined - Weapons"
	icon_state = "security"

/obj/item/circuitboard/machine/weapon/phase_cannon
	name = "Phase Cannnon - Weapons"
	build_path = /obj/machinery/ship/weapon/simple/phase_cannon
	req_components = list(
		// /obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/micro_laser = 2, // charge rate
		/obj/item/stock_parts/capacitor = 5, // charge rate
		/obj/item/stack/sheet/mineral/diamond = 5) // lens
	// TODO allow shitty lenses like normal glass or less shit one like plasmaglass
