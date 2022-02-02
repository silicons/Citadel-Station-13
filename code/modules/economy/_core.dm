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
