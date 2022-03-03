// gentlemen i have seem to burst in flames
	// if(breech.panel_open)
	// 	visible_message("<span class=userdanger>Arcs of electricity fly out of the MAC cannon's open maintenance panel!</span>")
	// 	tesla_zap(breech,5,30000) //dayum son, get roasted. This will seriously cuck anyone in the munitions bay.



/obj/machinery/ship/weapon/simple/mac_cannon
	mag_ammo = 0 // no mag
	mag_max = 0 // no mag
	internal_ammo = 1 // only one

	var/obj/machinery/ship/mac_breech/breech

	var/list/atom/movable/garbage = list()

	// based on munitions
	// projectile = /obj/item/projectile/overmap_projectile/energy

/obj/machinery/ship/weapon/simple/mac_cannon/Initialize()
	. = ..()
	find_breach()

/obj/machinery/ship/weapon/simple/mac_cannon/proc/find_breach()
	// check based on our facing dir (breach can only be on the BACK relative to the cannon's FRONT)

/obj/machinery/ship/weapon/simple/mac_cannon/reload()

/obj/machinery/ship/weapon/simple/mac_cannon/fire()
	if (!can_fire())
		return

	if(prob(5))
		do_sparks(3, 1, src)

	// get the last item, thats what we are going to accelerate
	var/things_we_have_count = LAZYLEN(garbage)
	if (!things_we_have_count)
		// do nothing
		return

	var/atom/movable/thign_to_fire = LAZYACCESS(garbage, things_we_have_count)
	if (!istype(thign_to_fire, /obj/structure/shell))
		// launch the garbage (just act as a mass driver)
		return

	// now the firing part
	var/obj/structure/shell/munition = thign_to_fire
	consume_shell(munition)
	// playsound(breech,'sound/weapons/mac_fire.ogg',100,0)

	if (things_we_have_count > 1)
		explosion(get_turf(src), munition.dev_dmg, munition.heavy_dmg, munition.light_dmg)
		return

	// var/obj/item/projectile/ship_projectile/mac_round/M = new breech.loaded_shell.projectile(get_step(src,dir))
	// if(breech.loaded_shell.armed)
	// 	M.attack_data = breech.loaded_shell.attack_data
	// M.target = target_component
	// M.shooter = shooter
	// M.setDir(src,dir)
	// M.starting = src.loc
	// M.fire()

/obj/machinery/ship/weapon/simple/mac_cannon/proc/consume_shell(obj/structure/shell/S)
	var/obj/item/weapon/twohanded/required/shell_casing/C = new S.casing
	garbage -= S
	garbage += C
	qdel(S)

	breech.consume_oil() // firing consumes 2 units
	breech.open_breach()

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


// /obj/machinery/ship/mac_breech

/obj/machinery/ship/mac_breech/proc/close_breech()
	if (!open)
		return
	consume_oil()
	density = TRUE // open
	open = FALSE
	// toggle sprite

/obj/machinery/ship/mac_breech/proc/open_breach()
	if (open)
		return
	consume_oil()
	density = FALSE // open
	open = TRUE
	// toggle sprite

/obj/machinery/ship/mac_breech/proc/consume_oil()
	reagents.remove_any(rand(1,3))
	// assuming you filter this properly it should ONLY have oil.
	// i am not reponsible if you can somehow load aphro into this container and use it as a weapons grade lubricant for this


/obj/structure/shell
	name = "cannon shell (High Explosive)"
	desc = "A large shell designed to deliver a high-yield warhead upon high-speed impact with solid objects."
	// icon = 'icons/obj/stationobjs.dmi'
	icon_state = "torpedo"
	density = TRUE

	// var/projectile = /obj/item/projectile/ship_projectile/mac_round
	var/casing = /obj/item/weapon/twohanded/required/shell_casing

	var/armed = FALSE

	//This will allow you to set the explosion values for if the shell is ejected from the cannon while armed. See \code\datums\explosion.dm as a reference
	var/dev_dmg = 2
	var/heavy_dmg = 5
	var/light_dmg = 10

/obj/structure/shell/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	playsound(loc,'sound/weapons/empty.ogg',50,0)
	user.visible_message("<span class=notice>[user] toggles the arming mechanism on [src].</span>","<span class=notice>You toggle the arming mechanism on [src]</span>")
	toggle_arm()

/obj/structure/shell/proc/toggle_arm()
	armed = !armed

// /obj/structure/shell/Collide(atom/A)
// 	if((A))
// 		if(throwing && armed)
// 			explosion(get_turf(src), dev_dmg, heavy_dmg, light_dmg)
// 			throwing = null


/obj/item/weapon/twohanded/required/shell_casing
	name = "cannon shell casing"
	desc = "The ejected casing from a cannon shell. Not very useful."
	icon = 'icons/obj/stationobjs.dmi' //for simplicity
	icon_state = "casing"
	item_state = "casing"

	w_class = 4

	force = 10
	throwforce = 80

/obj/item/weapon/twohanded/required/shell_casing/Initialize()
	. = ..()
	pixel_x = rand(-5,15)
	pixel_y = rand(-15,15)

/obj/item/weapon/twohanded/required/shell_casing/Bump()
	. = ..()
	throwforce = 10 //wow this is hacky, makes the shell only do 80 damage when ejected
