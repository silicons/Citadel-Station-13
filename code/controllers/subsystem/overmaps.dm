SUBSYSTEM_DEF(overmaps)
	name = "Overmaps"
	wait = 0.5
	init_order = INIT_ORDER_OVERMAPS
	fire_priority = FIRE_PRIORITY_OVERMAPS

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

/datum/controller/subsystem/overmaps/fire(resumed)
	GLOB.overmap.Tick(wait * 0.1, times_fired)
