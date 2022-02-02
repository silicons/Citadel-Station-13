/**
 * checks if something can be used to pay for something
 */
/proc/is_economic_currency(obj/item/I)
	// we do a little yanderedevving
	if(istype(I, /obj/item/card/id))
		return TRUE
	else if(istype(I, /obj/item/holochip))
		return TRUE
	else if(istype(I, /obj/item/stack/spacecash))
		return TRUE
	else if(istype(I, /obj/item/coin))
		return TRUE
	return FALSE

/**
 * checks available money in something considered currency
 */
/proc/check_economic_currency(obj/item/I)

/**
 * pays using a certain item - for some things, this might delete when empty, others, not so much
 *
 * either returns amount used (number), or fail reason (string)
 */
/proc/use_economic_currency(obj/item/I, amount, fail_on_insufficient = TRUE)
