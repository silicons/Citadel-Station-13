PROCESSING_SUBSYSTEM_DEF(artifacts)
	name = "Xenoarcheology"
	wait = 5
	init_order = INIT_ORDER_ARTIFACTS
	priority = FIRE_PRIORITY_ARTIFACTS

	/// list of particles by typepath
	var/static/list/particles_by_path = list()

/datum/controller/subsystem/artifacts/Initialize()
	InitializeParticles()
	return ..()

/datum/controller/subsystem/artifacts/proc/InitializeParticles()
	particles_by_path = list()
	for(var/path in subtypesof(/datum/exotic_particle))
		var/datum/exotic_particle/P = new path
		particles_by_path["[P.type]"] = P
