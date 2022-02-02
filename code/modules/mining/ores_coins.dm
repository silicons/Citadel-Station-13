
#define GIBTONITE_QUALITY_HIGH 3
#define GIBTONITE_QUALITY_MEDIUM 2
#define GIBTONITE_QUALITY_LOW 1

#define ORESTACK_OVERLAYS_MAX 10

/**********************Mineral ores**************************/

/obj/item/stack/ore
	name = "rock"
	icon = 'icons/obj/mining.dmi'
	icon_state = "ore"
	item_state = "ore"
	full_w_class = WEIGHT_CLASS_BULKY
	singular_name = "ore chunk"
	var/points = 0 //How many points this ore gets you from the ore redemption machine
	var/refined_type = null //What this ore defaults to being refined into
	var/mine_experience = 5 //How much experience do you get for mining this ore?
	novariants = TRUE // Ore stacks handle their icon updates themselves to keep the illusion that there's more going
	var/list/stack_overlays
	var/scan_state = "" //Used by mineral turfs for their scan overlay.
	var/spreadChance = 0 //Also used by mineral turfs for spreading veins

/obj/item/stack/ore/update_overlays()
	. = ..()
	var/difference = min(ORESTACK_OVERLAYS_MAX, amount) - (LAZYLEN(stack_overlays)+1)
	if(!difference)
		return

	if(difference < 0 && LAZYLEN(stack_overlays)) //amount < stack_overlays, remove excess.
		if(LAZYLEN(stack_overlays)-difference <= 0)
			stack_overlays = null
			return
		stack_overlays.len += difference

	else //amount > stack_overlays, add some.
		for(var/i in 1 to difference)
			var/mutable_appearance/newore = mutable_appearance(icon, icon_state)
			newore.pixel_x = rand(-8,8)
			newore.pixel_y = rand(-8,8)
			LAZYADD(stack_overlays, newore)

	if(stack_overlays)
		. += stack_overlays

/obj/item/stack/ore/welder_act(mob/living/user, obj/item/I)
	..()
	if(!refined_type)
		return TRUE

	if(I.use_tool(src, user, 0, volume=50, amount=15))
		new refined_type(drop_location())
		use(1)

	return TRUE

/obj/item/stack/ore/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(isnull(refined_type))
		return
	else
		var/probability = (rand(0,100))/100
		var/burn_value = probability*amount
		var/amountrefined = round(burn_value, 1)
		if(amountrefined < 1)
			qdel(src)
		else
			new refined_type(drop_location(),amountrefined)
			qdel(src)

/obj/item/stack/ore/uranium
	name = "uranium ore"
	icon_state = "Uranium ore"
	// inhand_icon_state = "Uranium ore"
	singular_name = "uranium ore chunk"
	points = 30
	// material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/uranium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/uranium
	mine_experience = 6
	scan_state = "rock_Uranium"
	spreadChance = 5
	// merge_type = /obj/item/stack/ore/uranium

/obj/item/stack/ore/iron
	name = "iron ore"
	icon_state = "Iron ore"
	item_state = "Iron ore"
	singular_name = "iron ore chunk"
	points = 1
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/metal
	mine_experience = 1
	scan_state = "rock_Iron"
	spreadChance = 20
	// merge_type = /obj/item/stack/ore/metal

/obj/item/stack/ore/glass
	name = "sand pile"
	icon_state = "Glass ore"
	item_state = "Glass ore"
	singular_name = "sand pile"
	points = 1
	custom_materials = list(/datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/glass
	w_class = WEIGHT_CLASS_TINY
	mine_experience = 0 //its sand
	// merge_type = /obj/item/stack/ore/glass

GLOBAL_LIST_INIT(sand_recipes, list(\
		new /datum/stack_recipe("sandstone", /obj/item/stack/sheet/mineral/sandstone, 1, 1, 50)
))


/obj/item/stack/ore/glass/get_main_recipes()
	. = ..()
	. += GLOB.sand_recipes

/obj/item/stack/ore/glass/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(..() || !ishuman(hit_atom))
		return
	var/mob/living/carbon/human/poorsod = hit_atom
	eyesand(poorsod)

/obj/item/stack/ore/glass/attack(mob/living/M, mob/living/user)
	if(!ishuman(M))
		return ..()
	if(user.zone_selected != BODY_ZONE_PRECISE_EYES && user.zone_selected != BODY_ZONE_HEAD)
		return ..()
	var/mob/living/carbon/human/poorsod = M
	visible_message("<span class='danger'>[user] throws the sand at [poorsod]'s face!</span>")
	if(ishuman(user) && prob(80))
		var/mob/living/carbon/human/sayer = user
		sayer.forcesay("POCKET SAAND!!")
	eyesand(poorsod)

/obj/item/stack/ore/glass/proc/eyesand(mob/living/carbon/human/C)
	if(C.head && C.head.flags_cover & HEADCOVERSEYES)
		visible_message("<span class='danger'>[C]'s headgear blocks the sand!</span>")
		return
	if(C.wear_mask && C.wear_mask.flags_cover & MASKCOVERSEYES)
		visible_message("<span class='danger'>[C]'s mask blocks the sand!</span>")
		return
	if(C.glasses && C.glasses.flags_cover & GLASSESCOVERSEYES)
		visible_message("<span class='danger'>[C]'s glasses block the sand!</span>")
		return
	C.adjust_blurriness(6)
	C.adjustStaminaLoss(15)//the pain from your eyes burning does stamina damage
	C.confused += 5
	to_chat(C, "<span class='userdanger'>\The [src] gets into your eyes! The pain, it burns!</span>")
	C.forcesay("*scream")
	qdel(src)

/obj/item/stack/ore/glass/ex_act(severity, target, origin)
	if (severity == EXPLODE_NONE)
		return
	qdel(src)

/obj/item/stack/ore/glass/basalt
	name = "volcanic ash"
	icon_state = "volcanic_sand"
	icon_state = "volcanic_sand"
	singular_name = "volcanic ash pile"
	mine_experience = 0
	// merge_type = /obj/item/stack/ore/glass/basalt

/obj/item/stack/ore/plasma
	name = "plasma ore"
	icon_state = "Plasma ore"
	icon_state = "Plasma ore"
	singular_name = "plasma ore chunk"
	points = 15
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/plasma
	mine_experience = 5
	scan_state = "rock_Plasma"
	spreadChance = 8
	// merge_type = /obj/item/stack/ore/plasma

/obj/item/stack/ore/plasma/welder_act(mob/living/user, obj/item/I)
	to_chat(user, "<span class='warning'>You can't hit a high enough temperature to smelt [src] properly!</span>")
	return TRUE

/obj/item/stack/ore/silver
	name = "silver ore"
	icon_state = "Silver ore"
	item_state = "Silver ore"
	singular_name = "silver ore chunk"
	points = 16
	mine_experience = 3
	custom_materials = list(/datum/material/silver=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/silver
	scan_state = "rock_Silver"
	spreadChance = 5
	// merge_type = /obj/item/stack/ore/silver

/obj/item/stack/ore/gold
	name = "gold ore"
	icon_state = "Gold ore"
	icon_state = "Gold ore"
	singular_name = "gold ore chunk"
	points = 18
	mine_experience = 5
	custom_materials = list(/datum/material/gold=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/gold
	scan_state = "rock_Gold"
	spreadChance = 5
	// merge_type = /obj/item/stack/ore/gold

/obj/item/stack/ore/diamond
	name = "diamond ore"
	icon_state = "Diamond ore"
	item_state = "Diamond ore"
	singular_name = "diamond ore chunk"
	points = 50
	custom_materials = list(/datum/material/diamond=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/diamond
	mine_experience = 10
	scan_state = "rock_Diamond"
	// merge_type = /obj/item/stack/ore/diamond

/obj/item/stack/ore/bananium
	name = "bananium ore"
	icon_state = "Bananium ore"
	item_state = "Bananium ore"
	singular_name = "bananium ore chunk"
	points = 60
	custom_materials = list(/datum/material/bananium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/bananium
	mine_experience = 15
	scan_state = "rock_Bananium"
	// merge_type = /obj/item/stack/ore/bananium

/obj/item/stack/ore/titanium
	name = "titanium ore"
	icon_state = "Titanium ore"
	item_state = "Titanium ore"
	singular_name = "titanium ore chunk"
	points = 50
	custom_materials = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/titanium
	mine_experience = 3
	scan_state = "rock_Titanium"
	spreadChance = 5
	// merge_type = /obj/item/stack/ore/titanium

/obj/item/stack/ore/slag
	name = "slag"
	desc = "Completely useless."
	icon_state = "slag"
	item_state = "slag"
	singular_name = "slag chunk"
	// merge_type = /obj/item/stack/ore/slag

/obj/item/gibtonite
	name = "gibtonite ore"
	desc = "Extremely explosive if struck with mining equipment, Gibtonite is often used by miners to speed up their work by using it as a mining charge. This material is illegal to possess by unauthorized personnel under space law."
	icon = 'icons/obj/mining.dmi'
	icon_state = "Gibtonite ore"
	item_state = "Gibtonite ore"
	w_class = WEIGHT_CLASS_BULKY
	throw_range = 0
	var/primed = FALSE
	var/det_time = 100
	var/quality = GIBTONITE_QUALITY_LOW //How pure this gibtonite is, determines the explosion produced by it and is derived from the det_time of the rock wall it was taken from, higher value = better
	var/attacher = "UNKNOWN"
	var/det_timer

/obj/item/gibtonite/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/gibtonite/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/item/gibtonite/attackby(obj/item/I, mob/user, params)
	if(!wires && istype(I, /obj/item/assembly/igniter))
		user.visible_message("<span class='notice'>[user] attaches [I] to [src].</span>", "<span class='notice'>You attach [I] to [src].</span>")
		wires = new /datum/wires/explosive/gibtonite(src)
		attacher = key_name(user)
		qdel(I)
		add_overlay("Gibtonite_igniter")
		return

	if(wires && !primed)
		if(is_wire_tool(I))
			wires.interact(user)
			return

	if(I.tool_behaviour == TOOL_MINING || istype(I, /obj/item/resonator) || I.force >= 10)
		GibtoniteReaction(user)
		return
	if(primed)
		if(istype(I, /obj/item/mining_scanner) || istype(I, /obj/item/t_scanner/adv_mining_scanner) || I.tool_behaviour == TOOL_MULTITOOL)
			primed = FALSE
			if(det_timer)
				deltimer(det_timer)
			user.visible_message("<span class='notice'>The chain reaction stopped! ...The ore's quality looks diminished.</span>", "<span class='notice'>You stopped the chain reaction. ...The ore's quality looks diminished.</span>")
			icon_state = "Gibtonite ore"
			quality = GIBTONITE_QUALITY_LOW
			return
	..()

/obj/item/gibtonite/attack_self(user)
	if(wires)
		wires.interact(user)
	else
		..()

/obj/item/gibtonite/bullet_act(obj/item/projectile/P)
	GibtoniteReaction(P.firer)
	. = ..()

/obj/item/gibtonite/ex_act(severity, target, origin)
	GibtoniteReaction(null, 1)

/obj/item/gibtonite/proc/GibtoniteReaction(mob/user, triggered_by = 0)
	if(!primed)
		primed = TRUE
		playsound(src,'sound/effects/hit_on_shattered_glass.ogg',50,TRUE)
		icon_state = "Gibtonite active"
		var/turf/bombturf = get_turf(src)
		var/notify_admins = FALSE
		if(z != 5)//Only annoy the admins ingame if we're triggered off the mining zlevel
			notify_admins = TRUE

		if(triggered_by == 1)
			message_admins("An explosion has triggered a [name] to detonate at [ADMIN_VERBOSEJMP(bombturf)].")
		else if(triggered_by == 2)
			if(notify_admins)
				message_admins("A signal has triggered a [name] to detonate at [ADMIN_VERBOSEJMP(bombturf)]. Igniter attacher: [ADMIN_LOOKUPFLW(attacher)]")
			var/bomb_message = "A signal has primed a [name] for detonation at [AREACOORD(bombturf)]. Igniter attacher: [key_name(attacher)]."
			log_game(bomb_message)
			GLOB.bombers += bomb_message
		else
			user.visible_message("<span class='warning'>[user] strikes \the [src], causing a chain reaction!</span>", "<span class='danger'>You strike \the [src], causing a chain reaction.</span>")
			log_game("[key_name(user)] has primed a [name] for detonation at [AREACOORD(bombturf)]")
		det_timer = addtimer(CALLBACK(src, .proc/detonate, notify_admins), det_time, TIMER_STOPPABLE)

/obj/item/gibtonite/proc/detonate(notify_admins)
	if(primed)
		switch(quality)
			if(GIBTONITE_QUALITY_HIGH)
				explosion(src,2,4,9,adminlog = notify_admins)
			if(GIBTONITE_QUALITY_MEDIUM)
				explosion(src,1,2,5,adminlog = notify_admins)
			if(GIBTONITE_QUALITY_LOW)
				explosion(src,0,1,3,adminlog = notify_admins)
		qdel(src)

/obj/item/stack/ore/Initialize(mapload, new_amount, merge = TRUE)
	. = ..()
	pixel_x = initial(pixel_x) + rand(0, 16) - 8
	pixel_y = initial(pixel_y) + rand(0, 8) - 8

/obj/item/stack/ore/ex_act(severity, target, origin)
	if (!severity || severity >= 2)
		return
	qdel(src)


#undef ORESTACK_OVERLAYS_MAX
