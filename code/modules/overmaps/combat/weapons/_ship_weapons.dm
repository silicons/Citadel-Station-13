
/obj/machinery/ship/weapon
	name = "basetype. does nothing"

/**
 * simple, dumb weapons
 */

/obj/machinery/ship/weapon/simple
	name = "simple weapon"
	max_integrity = 300

	var/mag_ammo = 0
	var/mag_max = 3
	var/internal_ammo = 100
	var/rate_of_fire = 2 // delay/fire
	COOLDOWN_DECLARE(fire_cd)

	var/reload_delay = 5 SECONDS
	/// Are we reloading?
	var/is_reloading = FALSE
	/// Do we reload the entire mag or only 1/reload_delay
	var/burst_reload = FALSE

	var/list/damage_type = list()

	var/projectile = /obj/item/projectile/overmap_projectile

/obj/machinery/ship/weapon/simple/proc/reload()
	if(is_reloading)
		return FALSE
	is_reloading = TRUE
	INVOKE_ASYNC(src, .proc/reload_entirely)
	return TRUE

/obj/machinery/ship/weapon/simple/proc/reload_until(how_much)
	if (!how_much)
		is_reloading = FALSE
		return

	if ((mag_ammo + 1) > mag_max || !internal_ammo)
		is_reloading = FALSE
		return

	sleep(reload_delay)

	if (QDELETED(src))
		is_reloading = FALSE // dont need to set this kek
		return

	mag_ammo += 1
	internal_ammo =- 1
	reload_until(how_much - 1)

/obj/machinery/ship/weapon/simple/proc/reload_entirely()
	if (!internal_ammo)
		is_reloading = FALSE
		return

	sleep(reload_delay)

	if (QDELETED(src))
		is_reloading = FALSE // dont need to set this kek
		return

	var/n_to_reload = mag_max - mag_ammo
	var/thing_we_took = internal_ammo - n_to_reload
	mag_ammo = n_to_reload - (thing_we_took < 0 ? thing_we_took : 0)
	internal_ammo -= thing_we_took


/obj/machinery/ship/weapon/simple/proc/fire()

/// Your own check to see if the weapon can fire or not.
/obj/machinery/ship/weapon/simple/proc/can_fire()
	return !!mag_ammo

/**
 * cool modular guns
 */

/obj/machinery/ship/weapon/modular
	name = "basetype for modular. does nothing"

/obj/machinery/ship/weapon/modular/parent
	name = "parent piece of a modular weapon"

	var/projectile = /obj/item/projectile/overmap_projectile


/obj/machinery/ship/weapon/modular/parent/proc/connect_nearby()
    var/list/things_to_add = list()
    check_and_connect_neighbour(src, things_to_add)
    // floodfil
    if (!LAZYLEN(things_to_add))
        return
    for (var/obj/machinery/ship/weapon/modular/modules/M as anything in things_to_add)
        M.parent = src

/obj/machinery/ship/weapon/modular/parent/proc/check_and_connect_neighbour(atom/movable/location, list/bucket)
    var/turf/T
    var/obj/machinery/ship/weapon/modular/modules/M
    var/obj/machinery/ship/weapon/modular/parent/P //monkaW
    for (var/dir in GLOB.cardinals)
        T = get_step(location, GLOB.cardinals[dir])
        M = (locate(/obj/machinery/ship/weapon/modular/modules) in T)
        if (!M || (M in bucket)) // no dupes
            continue
        if (M)
            bucket += M
            CHECK_TICK
            check_and_connect_neighbour(M)
            continue // its obviously not a parent

        P = (locate(/obj/machinery/ship/weapon/modular/parent) in T)
        if (P && P != src) // P stands for PANIC (another parent part is found)
            bucket = list() // nuke the list
            // idk where to log
            break

/obj/machinery/ship/weapon/modular/modules
	name = "parent piece of a modular weapon"
	var/obj/machinery/ship/weapon/modular/parent/parent
