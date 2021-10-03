GLOBAL_DATUM(game_master, /datum/game_master)

/**
 * Dynamic with blackjack and hookers
 *
 * "Smart" algorithm for figuring out what to do when.
 */
/datum/game_master
	var/name = "Game Master"
	/// brackets
	var/list/datum/gm_bracket/brackets
	/// actions
	var/list/datum/gm_action/actions
	/// storytellers
	var/list/datum/gm_mode/storytellers

