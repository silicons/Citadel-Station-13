/*
|| A Deck of Cards for playing various games of chance ||
*/

/obj/item/toy/cards
	resistance_flags = FLAMMABLE
	max_integrity = 50
	var/parentdeck = null
	var/deckstyle = "nanotrasen"
	var/card_hitsound = null
	var/card_force = 0
	var/card_throwforce = 0
	var/card_throw_speed = 3
	var/card_throw_range = 7
	var/list/card_attack_verb = list("attacked")

/obj/item/toy/cards/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] is slitting [user.p_their()] wrists with \the [src]! It looks like [user.p_they()] [user.p_have()] a crummy hand!</span>")
	playsound(src, 'sound/items/cardshuffle.ogg', 50, 1)
	return BRUTELOSS

/obj/item/toy/cards/proc/apply_card_vars(obj/item/toy/cards/newobj, obj/item/toy/cards/sourceobj) // Applies variables for supporting multiple types of card deck
	if(!istype(sourceobj))
		return

/obj/item/toy/cards/deck
	name = "deck of cards"
	desc = "A deck of space-grade playing cards."
	icon = 'icons/obj/toy.dmi'
	deckstyle = "nanotrasen"
	icon_state = "deck_nanotrasen_full"
	w_class = WEIGHT_CLASS_SMALL
	var/cooldown = 0
	var/obj/machinery/computer/holodeck/holo = null // Holodeck cards should not be infinite
	var/list/cards = list()
	var/original_size = 52

/obj/item/toy/cards/deck/Initialize()
	. = ..()
	populate_deck()

/obj/item/toy/cards/deck/proc/populate_deck()
	icon_state = "deck_[deckstyle]_full"
	for(var/i in 2 to 10)
		cards += "[i] of Hearts"
		cards += "[i] of Spades"
		cards += "[i] of Clubs"
		cards += "[i] of Diamonds"
	cards += "King of Hearts"
	cards += "King of Spades"
	cards += "King of Clubs"
	cards += "King of Diamonds"
	cards += "Queen of Hearts"
	cards += "Queen of Spades"
	cards += "Queen of Clubs"
	cards += "Queen of Diamonds"
	cards += "Jack of Hearts"
	cards += "Jack of Spades"
	cards += "Jack of Clubs"
	cards += "Jack of Diamonds"
	cards += "Ace of Hearts"
	cards += "Ace of Spades"
	cards += "Ace of Clubs"
	cards += "Ace of Diamonds"

//ATTACK HAND NOT CALLING PARENT
/obj/item/toy/cards/deck/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	draw_card(user)

/obj/item/toy/cards/deck/proc/draw_card(mob/user)
	if(user.lying)
		return
	var/choice = null
	if(cards.len == 0)
		to_chat(user, "<span class='warning'>There are no more cards to draw!</span>")
		return
	var/obj/item/toy/cards/singlecard/H = new/obj/item/toy/cards/singlecard(user.loc)
	if(holo)
		holo.spawned += H // track them leaving the holodeck
	choice = popleft(cards)
	H.cardname = choice
	H.parentdeck = src
	var/O = src
	H.apply_card_vars(H,O)
	H.pickup(user)
	user.put_in_hands(H)
	user.visible_message("[user] draws a card from the deck.", "<span class='notice'>You draw a card from the deck.</span>")
	update_icon()

/obj/item/toy/cards/deck/update_icon_state()
	switch(cards.len)
		if(original_size*0.5 to INFINITY)
			icon_state = "deck_[deckstyle]_full"
		if(original_size*0.25 to original_size*0.5)
			icon_state = "deck_[deckstyle]_half"
		if(1 to original_size*0.25)
			icon_state = "deck_[deckstyle]_low"
		else
			icon_state = "deck_[deckstyle]_empty"

/obj/item/toy/cards/deck/attack_self(mob/user)
	if(cooldown < world.time - 50)
		cards = shuffle(cards)
		playsound(src, 'sound/items/cardshuffle.ogg', 50, 1)
		user.visible_message("[user] shuffles the deck.", "<span class='notice'>You shuffle the deck.</span>")
		cooldown = world.time

/obj/item/toy/cards/deck/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/cards/singlecard))
		var/obj/item/toy/cards/singlecard/SC = I
		if(SC.parentdeck == src)
			if(!user.temporarilyRemoveItemFromInventory(SC))
				to_chat(user, "<span class='warning'>The card is stuck to your hand, you can't add it to the deck!</span>")
				return
			cards += SC.cardname
			user.visible_message("[user] adds a card to the bottom of the deck.","<span class='notice'>You add the card to the bottom of the deck.</span>")
			qdel(SC)
		else
			to_chat(user, "<span class='warning'>You can't mix cards from other decks!</span>")
		update_icon()
	else if(istype(I, /obj/item/toy/cards/cardhand))
		var/obj/item/toy/cards/cardhand/CH = I
		if(CH.parentdeck == src)
			if(!user.temporarilyRemoveItemFromInventory(CH))
				to_chat(user, "<span class='warning'>The hand of cards is stuck to your hand, you can't add it to the deck!</span>")
				return
			cards += CH.currenthand
			user.visible_message("[user] puts [user.p_their()] hand of cards in the deck.", "<span class='notice'>You put the hand of cards in the deck.</span>")
			qdel(CH)
		else
			to_chat(user, "<span class='warning'>You can't mix cards from other decks!</span>")
		update_icon()
	else
		return ..()

/obj/item/toy/cards/deck/MouseDrop(atom/over_object)
	. = ..()
	var/mob/living/M = usr
	if(!istype(M) || usr.incapacitated() || usr.lying)
		return
	if(Adjacent(usr))
		if(over_object == M && loc != M)
			M.put_in_hands(src)
			to_chat(usr, "<span class='notice'>You pick up the deck.</span>")

		else if(istype(over_object, /atom/movable/screen/inventory/hand))
			var/atom/movable/screen/inventory/hand/H = over_object
			if(M.putItemFromInventoryInHandIfPossible(src, H.held_index))
				to_chat(usr, "<span class='notice'>You pick up the deck.</span>")

	else
		to_chat(usr, "<span class='warning'>You can't reach it from here!</span>")



/obj/item/toy/cards/cardhand
	name = "hand of cards"
	desc = "A number of cards not in a deck, customarily held in ones hand."
	icon = 'icons/obj/toy.dmi'
	icon_state = "none"
	w_class = WEIGHT_CLASS_TINY
	var/list/currenthand = list()
	var/choice = null

/obj/item/toy/cards/cardhand/attack_self(mob/user)
	var/list/handradial = list()
	interact(user)

	for(var/t in currenthand)
		handradial[t] = image(icon = src.icon, icon_state = "sc_[t]_[deckstyle]")

	if(usr.stat || !ishuman(usr))
		return
	var/mob/living/carbon/human/cardUser = usr
	if(!(cardUser.mobility_flags & MOBILITY_USE))
		return
	var/O = src
	var/choice = show_radial_menu(usr,src, handradial, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE
	var/obj/item/toy/cards/singlecard/C = new/obj/item/toy/cards/singlecard(cardUser.loc)
	currenthand -= choice
	handradial -= choice
	C.parentdeck = parentdeck
	C.cardname = choice
	C.apply_card_vars(C,O)
	C.pickup(cardUser)
	cardUser.put_in_hands(C)
	cardUser.visible_message("<span class='notice'>[cardUser] draws a card from [cardUser.p_their()] hand.</span>", "<span class='notice'>You take the [C.cardname] from your hand.</span>")

	interact(cardUser)
	update_sprite()
	if(length(currenthand) == 1)
		var/obj/item/toy/cards/singlecard/N = new/obj/item/toy/cards/singlecard(loc)
		N.parentdeck = parentdeck
		N.cardname = currenthand[1]
		N.apply_card_vars(N,O)
		qdel(src)
		N.pickup(cardUser)
		cardUser.put_in_hands(N)
		to_chat(cardUser, "<span class='notice'>You also take [currenthand[1]] and hold it.</span>")

/obj/item/toy/cards/cardhand/attackby(obj/item/toy/cards/singlecard/C, mob/living/user, params)
	if(istype(C))
		if(C.parentdeck == src.parentdeck)
			src.currenthand += C.cardname
			user.visible_message("<span class='notice'>[user] adds a card to [user.p_their()] hand.</span>", "<span class='notice'>You add the [C.cardname] to your hand.</span>")
			qdel(C)
			interact(user)
			update_sprite(src)
		else
			to_chat(user, "<span class='warning'>You can't mix cards from other decks!</span>")
	else
		return ..()

/obj/item/toy/cards/cardhand/apply_card_vars(obj/item/toy/cards/newobj,obj/item/toy/cards/sourceobj)
	..()
	newobj.deckstyle = sourceobj.deckstyle
	update_sprite()
	newobj.card_hitsound = sourceobj.card_hitsound
	newobj.card_force = sourceobj.card_force
	newobj.card_throwforce = sourceobj.card_throwforce
	newobj.card_throw_speed = sourceobj.card_throw_speed
	newobj.card_throw_range = sourceobj.card_throw_range
	newobj.card_attack_verb = sourceobj.card_attack_verb
	newobj.resistance_flags = sourceobj.resistance_flags

/**
  * check_menu: Checks if we are allowed to interact with a radial menu
  *
  * Arguments:
  * * user The mob interacting with a menu
  */
/obj/item/toy/cards/cardhand/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/**
  * This proc updates the sprite for when you create a hand of cards
  */
/obj/item/toy/cards/cardhand/proc/update_sprite()
	cut_overlays()
	var/overlay_cards = currenthand.len

	var/k = overlay_cards == 2 ? 1 : overlay_cards - 2
	for(var/i = k; i <= overlay_cards; i++)
		var/card_overlay = image(icon=src.icon,icon_state="sc_[currenthand[i]]_[deckstyle]",pixel_x=(1-i+k)*3,pixel_y=(1-i+k)*3)
		add_overlay(card_overlay)

/obj/item/toy/cards/singlecard
	name = "card"
	desc = "a card"
	icon = 'icons/obj/toy.dmi'
	icon_state = "singlecard_down_nanotrasen"
	w_class = WEIGHT_CLASS_TINY
	var/cardname = null
	var/flipped = 0
	pixel_x = -5


/obj/item/toy/cards/singlecard/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/cardUser = user
		if(cardUser.is_holding(src))
			cardUser.visible_message("[cardUser] checks [cardUser.p_their()] card.", "<span class='notice'>The card reads: [cardname].</span>")
		else
			. += "<span class='warning'>You need to have the card in your hand to check it!</span>"

/obj/item/toy/cards/singlecard/verb/Flip()
	set name = "Flip Card"
	set category = "Object"
	set src in range(1)
	if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE))
		return
	if(!flipped)
		src.flipped = 1
		if (cardname)
			src.icon_state = "sc_[cardname]_[deckstyle]"
			src.name = src.cardname
		else
			src.icon_state = "sc_Ace of Spades_[deckstyle]"
			src.name = "What Card"
		src.pixel_x = 5
	else if(flipped)
		src.flipped = 0
		src.icon_state = "singlecard_down_[deckstyle]"
		src.name = "card"
		src.pixel_x = -5

/obj/item/toy/cards/singlecard/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/cards/singlecard/))
		var/obj/item/toy/cards/singlecard/C = I
		if(C.parentdeck == src.parentdeck)
			var/obj/item/toy/cards/cardhand/H = new/obj/item/toy/cards/cardhand(user.loc)
			H.currenthand += C.cardname
			H.currenthand += src.cardname
			H.parentdeck = C.parentdeck
			H.apply_card_vars(H,C)
			to_chat(user, "<span class='notice'>You combine the [C.cardname] and the [src.cardname] into a hand.</span>")
			qdel(C)
			qdel(src)
			H.pickup(user)
			user.put_in_active_hand(H)
		else
			to_chat(user, "<span class='warning'>You can't mix cards from other decks!</span>")

	if(istype(I, /obj/item/toy/cards/cardhand/))
		var/obj/item/toy/cards/cardhand/H = I
		if(H.parentdeck == parentdeck)
			H.currenthand += cardname
			user.visible_message("[user] adds a card to [user.p_their()] hand.", "<span class='notice'>You add the [cardname] to your hand.</span>")
			qdel(src)
			H.interact(user)
			if(H.currenthand.len > 4)
				H.icon_state = "[deckstyle]_hand5"
			else if(H.currenthand.len > 3)
				H.icon_state = "[deckstyle]_hand4"
			else if(H.currenthand.len > 2)
				H.icon_state = "[deckstyle]_hand3"
		else
			to_chat(user, "<span class='warning'>You can't mix cards from other decks!</span>")
	else
		return ..()

/obj/item/toy/cards/singlecard/attack_self(mob/living/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	if(!CHECK_MOBILITY(user, MOBILITY_USE))
		return
	Flip()

/obj/item/toy/cards/singlecard/apply_card_vars(obj/item/toy/cards/singlecard/newobj,obj/item/toy/cards/sourceobj)
	..()
	newobj.deckstyle = sourceobj.deckstyle
	newobj.icon_state = "singlecard_down_[deckstyle]" // Without this the card is invisible until flipped. It's an ugly hack, but it works.
	newobj.card_hitsound = sourceobj.card_hitsound
	newobj.hitsound = newobj.card_hitsound
	newobj.card_force = sourceobj.card_force
	newobj.force = newobj.card_force
	newobj.card_throwforce = sourceobj.card_throwforce
	newobj.throwforce = newobj.card_throwforce
	newobj.card_throw_speed = sourceobj.card_throw_speed
	newobj.throw_speed = newobj.card_throw_speed
	newobj.card_throw_range = sourceobj.card_throw_range
	newobj.throw_range = newobj.card_throw_range
	newobj.card_attack_verb = sourceobj.card_attack_verb
	newobj.attack_verb = newobj.card_attack_verb

/*
|| Syndicate playing cards, for pretending you're Gambit and playing poker for the nuke disk. ||
*/

/obj/item/toy/cards/deck/syndicate
	name = "suspicious looking deck of cards"
	desc = "A deck of space-grade playing cards. They seem unusually rigid."
	icon_state = "deck_syndicate_full"
	deckstyle = "syndicate"
	card_hitsound = 'sound/weapons/bladeslice.ogg'
	card_force = 5
	card_throwforce = 10
	card_throw_speed = 3
	card_throw_range = 7
	card_attack_verb = list("attacked", "sliced", "diced", "slashed", "cut")
	resistance_flags = NONE
