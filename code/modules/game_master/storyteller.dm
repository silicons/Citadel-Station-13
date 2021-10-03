/**
 * Determines what set of weights and balances the gamemaster system is using
 *
 * Config section: "storytellers"
 */
/datum/gm_mode
	/// abstract type
	var/abstract_type = /datum/gm_mode
	/// unique id
	var/id

/datum/gm_mode/New()
	if(!id)
		id = "[path]"

/datum/gm_mode/Destroy()

	return ..()
