/obj/item/cash
	name = "cash"
	desc = "It's somehow uninitialized cash. Uh oh."
	icon = 'icons/modules/economy/cash.dmi'
	icon_state = "spacecash1"
	force = 0
	throwforce = 0
	throw_speed = 1
	#warn impl throwing cash is a bad idea lmfao (split stack)
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	// drop_sound = 'sound/items/drop/paper.ogg'
	// pickup_sound = 'sound/items/pickup/paper.ogg'
	/// total worth - cached
	var/worth = 10
	/// stored cash - i don't know why i'm being a dumbass and bothering to simulate this but uh ok
	var/list/stored
	/// valid denominators
	var/static/list/valid_denominators = _valid_denominators()

/obj/item/cash/Initialize()
	set_worth(worth)
	return ..()

// incase admins break shit
/obj/item/cash/proc/_valid_denominators()
	. = list(
		1,
		10,
		20,
		50,
		100,
		200,
		500,
		1000
	)
	. = sortTim(., /proc/cmp_numeric_dsc)

/obj/item/cash/update_name()
	. = ..()
	name = "[render_currency(worth)]"

/obj/item/cash/update_desc()
	. = ..()
	desc = "A stack of [render_currency(worth)]."

/obj/item/cash/update_icon_state()
	. = ..()
	for(var/i in valid_denominators)
		if(i < worth)
			icon_state = "spacecash[i]"
			break

/obj/item/cash/update_overlays()
	. = ..()
	var/left = worth
	for(var/i in valid_denominators)
		if(i < left)
			left -= i
			break
	// took out the one we set in icon state, let's go do the rest
	var/limit = 15
	for(var/denominator in stored)
		for(var/i in 1 to stored[denominator])
			if(!--limit)
				break
			var/mutable_appearance/MA = new(icon, "spacecash[denominator]")
			var/matrix/TT = new
			TT.Translate(rand(-6, 6), rand(-4, 8))
			TT.Turn(pick(-45, -27.5, 0, 0, 0, 0, 0, 0, 0, 27.5, 45))
			MA.transform = TT
			. += MA
		if(!limit)
			break

/obj/item/cash/proc/set_worth(amount, autodel = TRUE)
	// set stored list as needed
	if(amount <= 0)
		amount = 0
		worth = 0
		stored = null
		if(autodel)
			qdel(src)
		return
	worth = amount
	stored = list()
	var/left = worth
	for(var/i in valid_denominators)
		while(left > i)
			left -= i
			if(stored["[i]"])
				stored["[i]"]++
			else
				stored["[i]"] = 1
	update_appearance()

/obj/item/cash/proc/combine(obj/item/cash/other)
	LAZYINITLIST(stored)
	for(var/amt_txt in other.stored)
		if(!stored[amt_txt])
			stored[amt_txt] = other.stored[amt_txt]
		else
			stored[amt_txt] += other.stored[amt_txt]
	LAZYCLEARLIST(stored)
	other.stored = null
	qdel(other)
	update_appearance()

/obj/item/cash/update_appearance()
	update_worth()
	return ..()

/obj/item/cash/proc/update_worth()
	. = 0
	for(var/amt_txt in stored)
		var/amt = text2num(amt_txt)
		if(!(amt in valid_denominators) || !stored[amt_txt])
			// auto sanitize out
			stored -= amt
			continue
		. += amt * stored[amt_txt]
	worth = .

/obj/item/cash/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/cash))
		if(ismob(loc))
			var/mob/M = loc
			if(!M.temporarilyRemoveItemFromInventory(src))
				to_chat(user, span_warning("[src] is stuck!"))
				return
		var/obj/item/cash/C = I
		C.combine(src)
		to_chat(user, span_notice("You combine the [CURRENCY_NAME_PLURAL] to form [C]."))
		return

/obj/item/cash/proc/attempt_split(mob/user, take_all)
	var/list/choices = list()
	for(var/denomination in stored)
		var/mutable_appearance/MA = new(icon, "spacecash[denomination]")
		choices[denomination] = MA
	var/choice = show_radial_menu(user, src, choices)
	if(!user.CanReach(src))
		retur/	n
	if(!stored[choice])
		return
	var/amount = take_all? stored[choice] : 1
	user.visible_message(
		span_notice("[user] takes [amount] [choice] [CURRENCY_NAME_PLURAL] bills out of the stack."),
		span_notice("You take [amount] [choice] [CURRENCY_NAME_PLURAL] bills out of the stack."),
		span_notice("You hear some paper ruffling."),
		COMBAT_MESSAGE_RANGE
	)
	var/obj/item/cash/C = new(user)
	C.stored = list(
		choice = amount
	)
	C.update_appearance()
	if(!user.put_in_hands(C))
		user.dropItemToGround(C)


/obj/item/cash/attack_self(mob/user)
	. = ..()
	attempt_split(user)

/obj/item/cash/AltClick(mob/user)
	. = ..()
	attempt_split(user, TRUE)

/obj/item/cash/c1
	name = "1 Thaler"
	icon_state = "spacecash1"
	desc = "It's worth 1 credit."
	worth = 1

/obj/item/cash/c10
	name = "10 Thaler"
	icon_state = "spacecash10"
	desc = "It's worth 10 Thalers."
	worth = 10

/obj/item/cash/c20
	name = "20 Thaler"
	icon_state = "spacecash20"
	desc = "It's worth 20 Thalers."
	worth = 20

/obj/item/cash/c50
	name = "50 Thaler"
	icon_state = "spacecash50"
	desc = "It's worth 50 Thalers."
	worth = 50

/obj/item/cash/c100
	name = "100 Thaler"
	icon_state = "spacecash100"
	desc = "It's worth 100 Thalers."
	worth = 100

/obj/item/cash/c200
	name = "200 Thaler"
	icon_state = "spacecash200"
	desc = "It's worth 200 Thalers."
	worth = 200

/obj/item/cash/c500
	name = "500 Thaler"
	icon_state = "spacecash500"
	desc = "It's worth 500 Thalers."
	worth = 500

/obj/item/cash/c1000
	name = "1000 Thaler"
	icon_state = "spacecash1000"
	desc = "It's worth 1000 Thalers."
	worth = 1000
