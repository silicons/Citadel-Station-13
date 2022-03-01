SUBSYSTEM_DEF(overmaps)
	name = "Overmaps"
	wait = 0.5
	init_order = INIT_ORDER_OVERMAPS
	priority = FIRE_PRIORITY_OVERMAPS

	/// all overmaps
	var/static/list/datum/overmap/overmaps = list()
	/// primary overmap
	var/static/datum/overmap/world_overmap
	/// hazards by id
	var/static/hazards_by_id = list()

/datum/controller/subsystem/overmaps/Initialize()
	InstantiateHazards()
	InstantiateWorldOvermap()
	InstantiateOvermapObjects()
	InitializeOvermapObjects()

	return ..()

/datum/controller/subsystem/overmaps/Recover()
	HardReset()

/datum/controller/subsystem/overmaps/proc/InstantiateHazards()
	for(var/datum/overmap_hazard/H in subtypesof(/datum/overmap_hazard))
		if(initial(H.abstract_type) == H)
			continue
		H = new H
		if(hazards_by_id[H.id])
			stack_trace("Duplicate id [H.id] [H] [H.type].")
			continue
		hazards_by_id[H.id] = H

/datum/controller/subsystem/overmaps/proc/GetHazardID(id)
	return hazards_by_id["[id]"]

/datum/controller/subsystem/overmaps/proc/InstantiateWorldOvermap()
	#warn check if we should use overmap, get overmap size, etc.

	if(world_overmap)
		CRASH("World overmap already exists")
	world_overmap = new
	#warn for now it's just making max size.
	world_overmap.Initialize(world.maxx, world.maxy, "abcd")

/datum/controller/subsystem/overmaps/proc/InstantiateOvermapObjects()
	#warn here is the part where the main map, existing shuttles, etc, get created and put into their proper locations/seeded

/datum/controller/subsystem/overmaps/proc/InitializeOvermapObjects()
	#warn oh fuck

	for(var/atom/movable/overmap_object/entity/O in world)
		O.OvermapInitialize()

/datum/controller/subsystem/overmaps/proc/HardReset()
	can_fire = FALSE
	to_chat(world, span_danger("Hard resetting overmaps; This will cause some lag."))
	var/cost = REALTIMEOFDAY

	// wipe all overmaps
	for(var/datum/overmap/O as anything in overmaps)
		if(!istype(O))
			overmaps -= O
		for(var/atom/movable/overmap_object/OO in O.entities)
			O.RemoveEntity(OO)
		O.entities = list()
		O.processing = list()

	for(var/atom/movable/overmap_object/entity/O in world)
		#warn put into overmap

	// recover all overmaps
	for(var/datum/overmap/O as anything in overmaps)
		O.Recover()

		// recover all objects
		for(var/atom/movable/overmap_object/entity/OO as anything in O.entities)
			OO.Recover()

	cost = REALTIMEOFDAY - cost
	to_chat(world, span_danger("Overmaps hard reset in [cost * 0.1] seconds."))
	can_fire = TRUE

/datum/controller/subsystem/overmaps/fire(resumed)
	for(var/datum/overmap/O in overmaps)
		O.Tick(wait * 0.1, times_fired)
