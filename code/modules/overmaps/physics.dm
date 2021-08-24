/**
 * simulation tick
 */
/atom/movable/overmap_object/proc/Tick(seconds, times_fired)


/atom/movable/overmap_object/Cross(atom/movable/AM)
	// No rigidbody collisions implemented yet
	// yes, this means we don't send a signal, sue me
	return TRUE

/atom/movable/overmap_object/Uncross(atom/movable/AM, atom/newloc)
	// No rigidbody collisions implemented yet
	// yes, this means we don't send a signal, sue me
	return TRUE
