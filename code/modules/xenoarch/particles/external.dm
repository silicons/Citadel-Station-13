/**
 * called when something is affected by particles
 */
/atom/proc/particle_act(datum/exotic_particle/particle, intensity, datum/exotic_projection/projection)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(src, COMSIG_ATOM_PARTICLE_ACT, particle, intensity, projection)
