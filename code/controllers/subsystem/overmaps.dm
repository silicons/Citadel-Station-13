SUBSYSTEM_DEF(overmaps)
	name = "Overmaps"
	wait = 0.5
	init_order = INIT_ORDER_OVERMAPS
	fire_priority = FIRE_PRIORITY_OVERMAPS

	/// all overmaps
	var/static/list/datum/overmap/overmaps = list()

/datum/controller/subsystem/overmaps/Initialize()
	if(SSmapping.use_overmap)
		// yes, we aren't using BuildOvermap
		if(GLOB.overmap)
			to_chat(world, "<span class='danger'>Overmaps failed to initialize as it already exists.</span>")
			return ..()
		GLOB.overmap = new
		#warn impl - generation parameters
		GLOB.overmap.Initialize()
	for(var/atom/movable/overmap_object/O in world)
		O.OvermapInitialize()
	return ..()

/datum/controller/subsystem/overmaps/Recover()
	HardReset()

/datum/controller/subsystem/overmaps/proc/HardReset()
	can_fire = FALSE
	to_chat(world, span_danger("Hard resetting overmaps; This will cause some lag."))
	var/cost = REALTIMEOFDAY

	// wipe all overmaps
	for(var/datum/overmap/O as anything in overmaps)
		if(!istype(O))
			overmaps -= O
		for(var/atom/movable/overmap_object/OO in O.objects)
			O.RemoveObject(OO)
		O.objects = list()
		O.processing = list()

	for(var/atom/movable/overmap_object/O in world)

	// recover all overmaps
	for(var/datum/overmap/O as anything in overmaps)
		O.Recover()

	// recover all objects
	for(var/atom/movable/overmap_object/OO as anything in O.objects)
		OO.Recover()


	cost = REALTIMEOFDAY - cost
	to_chat(world, span_danger("Overmaps hard reset in [cost * 0.1] seconds."))
	can_fire = TRUE

/datum/controller/subsystem/overmaps/fire(resumed)
	for(var/datum/overmap/O in overmaps)
		O.Tick(wait * 0.1, times_fired)
