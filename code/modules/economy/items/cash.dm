#warn refactor

/obj/item/stack/spacecash  //Don't use base space cash stacks. Any other space cash stack can merge with them, and could cause potential money duping exploits.
	name = "space cash"
	singular_name = "bill"
	icon = 'icons/obj/economy.dmi'
	icon_state = "spacecash"
	amount = 1
	max_amount = INFINITY
	throwforce = 0
	throw_speed = 2
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 10)
	var/value = 0

/obj/item/stack/spacecash/Initialize(mapload, new_amount, merge = TRUE)
	. = ..()
	update_desc()

/obj/item/stack/spacecash/update_desc()
	var/total_worth = get_item_credit_value()
	desc = "It's worth [total_worth] credit[( total_worth > 1 ) ? "s" : ""]"

/obj/item/stack/spacecash/get_item_credit_value()
	return (amount*value)

/obj/item/stack/spacecash/merge(obj/item/stack/S)
	. = ..()
	update_desc()

/obj/item/stack/spacecash/use(used, transfer = FALSE)
	. = ..()
	update_desc()

/obj/item/stack/spacecash/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/card/id))
		var/obj/item/card/id/ID = W
		if(!ID.registered_account)
			to_chat(user, "<span class='warning'>[ID] doesn't have a linked account to deposit into!</span>")
			return
		for(var/obj/item/holochip/money in src.loc.contents)
			ID.attackby(money, user)
		for(var/obj/item/stack/spacecash/money in src.loc.contents)
			ID.attackby(money, user)
		for(var/obj/item/coin/money in src.loc.contents)
			ID.attackby(money, user)

/obj/item/stack/spacecash/c1
	icon_state = "spacecash"
	singular_name = "one credit bill"
	value = 1

/obj/item/stack/spacecash/c10
	icon_state = "spacecash10"
	singular_name = "ten credit bill"
	value = 10

/obj/item/stack/spacecash/c20
	icon_state = "spacecash20"
	singular_name = "twenty credit bill"
	value = 20

/obj/item/stack/spacecash/c50
	icon_state = "spacecash50"
	singular_name = "fifty credit bill"
	value = 50

/obj/item/stack/spacecash/c100
	icon_state = "spacecash100"
	singular_name = "one hundred credit bill"
	value = 100

/obj/item/stack/spacecash/c200
	icon_state = "spacecash200"
	singular_name = "two hundred credit bill"
	value = 200

/obj/item/stack/spacecash/c500
	icon_state = "spacecash500"
	singular_name = "five hundred credit bill"
	value = 500

/obj/item/stack/spacecash/c1000
	icon_state = "spacecash1000"
	singular_name = "one thousand credit bill"
	value = 1000

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
	var/worth = 0
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
	for(var/i in valid_denominators)
		while(left < i)
		#warn finish

/obj/item/cash/proc/set_worth(amount)
	// set stored list as needed
	if(amount <= 0)
		amount = 0
		worth = 0
		stored = null
		update_appearance()
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
/obj/item/spacecash
	name = "0 Thaler"
	desc = "It's worth 0 Thalers."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "spacecash1"
	opacity = 0
	density = 0
	anchored = 0.0
	force = 1.0
	throwforce = 1.0
	throw_speed = 1
	throw_range = 2
	w_class = ITEMSIZE_SMALL
	var/access = list()
	access = access_crate_cash
	var/worth = 0
	drop_sound = 'sound/items/drop/paper.ogg'
	pickup_sound = 'sound/items/pickup/paper.ogg'

/obj/item/spacecash/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/spacecash))
		if(istype(W, /obj/item/spacecash/ewallet)) return 0

		var/obj/item/spacecash/SC = W

		SC.adjust_worth(src.worth)
		if(istype(user, /mob/living/carbon/human))
			var/mob/living/carbon/human/h_user = user

			h_user.drop_from_inventory(src)
			h_user.drop_from_inventory(SC)
			h_user.put_in_hands(SC)
		to_chat(user, "<span class='notice'>You combine the Thalers to a bundle of [SC.worth] Thalers.</span>")
		qdel(src)

/obj/item/spacecash/update_icon()
	overlays.Cut()
	name = "[worth] Thaler\s"
	if(worth in list(1000,500,200,100,50,20,10,1))
		icon_state = "spacecash[worth]"
		desc = "It's worth [worth] Thalers."
		return
	var/sum = src.worth
	var/num = 0
	for(var/i in list(1000,500,200,100,50,20,10,1))
		while(sum >= i && num < 50)
			sum -= i
			num++
			var/image/banknote = image('icons/obj/items.dmi', "spacecash[i]")
			var/matrix/M = matrix()
			M.Translate(rand(-6, 6), rand(-4, 8))
			M.Turn(pick(-45, -27.5, 0, 0, 0, 0, 0, 0, 0, 27.5, 45))
			banknote.transform = M
			src.overlays += banknote
	if(num == 0) // Less than one thaler, let's just make it look like 1 for ease
		var/image/banknote = image('icons/obj/items.dmi', "spacecash1")
		var/matrix/M = matrix()
		M.Translate(rand(-6, 6), rand(-4, 8))
		M.Turn(pick(-45, -27.5, 0, 0, 0, 0, 0, 0, 0, 27.5, 45))
		banknote.transform = M
		src.overlays += banknote
	src.desc = "They are worth [worth] Thalers."

/obj/item/spacecash/attack_self()
	var/amount = input(usr, "How many Thalers do you want to take? (0 to [src.worth])", "Take Money", 20) as num
	if(!src || QDELETED(src))
		return
	amount = round(clamp(amount, 0, src.worth))

	if(!amount)
		return

	adjust_worth(-amount)
	var/obj/item/spacecash/SC = new (usr.loc)
	SC.set_worth(amount)
	usr.put_in_hands(SC)

/obj/item/spacecash/c1
	name = "1 Thaler"
	icon_state = "spacecash1"
	desc = "It's worth 1 credit."
	worth = 1

/obj/item/spacecash/c10
	name = "10 Thaler"
	icon_state = "spacecash10"
	desc = "It's worth 10 Thalers."
	worth = 10

/obj/item/spacecash/c20
	name = "20 Thaler"
	icon_state = "spacecash20"
	desc = "It's worth 20 Thalers."
	worth = 20

/obj/item/spacecash/c50
	name = "50 Thaler"
	icon_state = "spacecash50"
	desc = "It's worth 50 Thalers."
	worth = 50

/obj/item/spacecash/c100
	name = "100 Thaler"
	icon_state = "spacecash100"
	desc = "It's worth 100 Thalers."
	worth = 100

/obj/item/spacecash/c200
	name = "200 Thaler"
	icon_state = "spacecash200"
	desc = "It's worth 200 Thalers."
	worth = 200

/obj/item/spacecash/c500
	name = "500 Thaler"
	icon_state = "spacecash500"
	desc = "It's worth 500 Thalers."
	worth = 500

/obj/item/spacecash/c1000
	name = "1000 Thaler"
	icon_state = "spacecash1000"
	desc = "It's worth 1000 Thalers."
	worth = 1000

proc/spawn_money(var/sum, spawnloc, mob/living/carbon/human/human_user as mob)
	var/obj/item/spacecash/SC = new (spawnloc)

	SC.set_worth(sum)
	if (ishuman(human_user) && !human_user.get_active_hand())
		human_user.put_in_hands(SC)
	return
