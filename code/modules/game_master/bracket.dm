/**
 * Collects similar-in-severity events together
 */
/datum/gm_bracket
	/// abstract type
	var/abstract_type = /datum/gm_bracket
	/// internal id of this bracket
	var/id
	/// Name
	var/name = "Bracket"
	/// desc
	var/desc = "A broken bracket. Contact coders."
	/// actions by id in this bracket
	var/list/actions
	/// disabled actions by id
	var/list/disabled

/datum/gm_bracket/New()
	if(!id)
		id = "[path]"
	actions = list()
	disabled = list()

/datum/gm_bracket/Destroy()
	actions = null
	disabled = null
	return ..()

