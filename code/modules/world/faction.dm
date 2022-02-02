/**
 * a representation of a faction in the IC world
 *
 * ALWAYS reference by id/type!
 */
/datum/world_faction
	/// abstract type
	var/abstract_type = /datum/world_faction
	/// entity name
	var/name = "Unknown"
	/// short player-facing lore description
	var/desc = "What is this?"
	/// id
	var/id

/datum/world_faction/New()
	if(!id)
		id = type

/datum/world_faction/proc/GetName()
	return name

/datum/world_faction/proc/GetID()
	return id
