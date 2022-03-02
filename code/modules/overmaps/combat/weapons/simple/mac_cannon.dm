// gentlemen i have seem to burst in flames
	// if(breech.panel_open)
	// 	visible_message("<span class=userdanger>Arcs of electricity fly out of the MAC cannon's open maintenance panel!</span>")
	// 	tesla_zap(breech,5,30000) //dayum son, get roasted. This will seriously cuck anyone in the munitions bay.



/obj/machinery/ship/weapon/simple/mac_cannon
	mag_ammo = 0 // no mag
	mag_max = 0 // no mag
	internal_ammo = 1 // only one

	var/obj/machinery/ship/mac_breech/breech

	// based on munitions
	// projectile = /obj/item/projectile/overmap_projectile/energy

/obj/machinery/ship/weapon/simple/mac_cannon/Initialize()
	. = ..()
	find_breach()

/obj/machinery/ship/weapon/simple/mac_cannon/proc/find_breach()
	// check based on our facing dir (breach can only be on the BACK relative to the cannon's FRONT)

/obj/machinery/ship/weapon/simple/mac_cannon/proc/open_breach()

/obj/machinery/ship/weapon/simple/mac_cannon/reload()

// real
/obj/machinery/ship/mac_breech
	name = "\improper MAC cannon breech"
	desc = "You should probably not put your hands in this thing during use."

	var/open = FALSE
	var/atom/movable/munition

/obj/machinery/ship/mac_breech/Initialize()
	. = ..()
	create_reagents(1000)
	reagents.add_reagent("oil",50)

/obj/machinery/ship/mac_breech/proc/open_breach()
	consume_oil()
	if(open)
		density = TRUE // closed
		open = FALSE
		// toggle sprite
		return
	density = FALSE // open
	open = TRUE

/obj/machinery/ship/mac_breech/proc/consume_oil()
	reagents.remove_any(rand(1,3))
	// assuming you filter this properly it should ONLY have oil.
	// i am not reponsible if you can somehow load aphro into this container and use it as a weapons grade lubricant for this
