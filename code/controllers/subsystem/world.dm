/**
 * holds world factions
 */
SUBSYSTEM_DEF(world)
	name = "World"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_WORLD

	/// factions
	var/list/datum/world_faction/factions
	/// factions by type
	var/list/factions_by_type

/datum/controller/subsystem/world/Initialize()
	InitializeFactions()
	return ..()

/datum/controller/subsystem/world/proc/InitializeFactions()
	for(var/path in subtypesof(/datum/world_faction))
		var/datum/world_faction/F = path
		if(initial(F.abstract_type) == path)
			continue
		F = new path
		factions += F
		factions_by_type[F.GetID()] = F

/datum/controller/subsystem/world/proc/GetFactionType(type)
	return factions_by_type[type]
