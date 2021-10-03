/**
 * A single action the GM can perform
 *
 * These should only be hard-referenced by the gamemaster itself. Everything else should use IDs.
 *
 * Config section: "actions"
 */
/datum/gm_action
	/// abstract type
	var/abstract_type = /datum/gm_action
	/// name
	var/name = "Action"
	/// desc
	var/desc = "A broken action. Contact coders."
	/// unique ID
	var/id

/datum/gm_action/New()
	id = "[type]"

/datum/gm_action/Destroy()

	return ..()
