/**
 * "but why the actual seven hells are you defining all this here instead of __HELPERS/text.dm?"
 *
 * because i'm stuck coding for two furry erp codebases, and today is not the day i deal with unifying __HELPERS.
 */

/proc/render_currency(amount, accuracy = 0.01)
	amount = round(amount, accuracy)
	. = abs(amount)
	if(abs(amount) == 1)
		return "1 [CURRENCY_NAME]"
	if(. < 1000)
		return "[amount < 0 && "-"][.] [CURRENCY_NAME]"
	// uh oh! fancy text time :/
	var/constructed = ""

	do
		var/cut = MODULUS(., 1000)
		. -= cut
		constructed += "[cut][constructed? "," : " [CURRENCY_NAME_PLURAL"]"
	while(. > 1000)

	return constructed

#warn timestamp proc here? use SSworld.in_game_year?
/proc/CurrentEconomicDatestamp()

/proc/CurrentEconomicTimestamp()

/proc/render_economic_date(day, month, year)
	if(!isnum(day) || !isnum(month) || !ISINRANGE(day, 1, 32) || !ISINRANGE(month, 1, 12) || !isnum(year))
		CRASH("someone screwed up")
	return "[year] [render_economic_month_text(month)] [day]"

/**
 * 24 hour format
 */
/proc/render_economic_time(seconds, minutes, hours)
	if(!ISINRANGE(seconds, 0, 60) || !ISINRANGE(minutes, 0, 60) || !ISINRANGE(hours, 0, 24))
		CRASH("someone screwed up")
	return "[hours]:[minutes]:[seconds]"

/proc/render_economic_month_text(month)
	switch(month)
		if(1)
			return "JAN"
		if(2)
			return "FEB"
		if(3)
			return "MAR"
		if(4)
			return "APR"
		if(5)
			return "MAY"
		if(6)
			return "JUN"
		if(7)
			return "JUL"
		if(8)
			return "AUG"
		if(9)
			return "SEP"
		if(10)
			return "OCT"
		if(11)
			return "NOV"
		if(12)
			return "DEC"
		else
			CRASH("What?")
