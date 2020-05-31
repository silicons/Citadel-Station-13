/mob/living/silicon/Login()
	if(mind && SSticker.mode)
		SSticker.mode.remove_cultist(mind, 0, 0)
		remove_vampire(src)
		var/datum/antagonist/rev/rev = mind.has_antag_datum(/datum/antagonist/rev)
		if(rev)
			rev.remove_revolutionary(TRUE)
		var/datum/antagonist/bloodsucker/V = mind.has_antag_datum(/datum/antagonist/bloodsucker)
		if(V)
			mind.remove_antag_datum(V)
		var/datum/antagonist/gang/G = mind.has_antag_datum(/datum/antagonist/gang)
		if(G)
			mind.remove_antag_datum(G)
	..()
