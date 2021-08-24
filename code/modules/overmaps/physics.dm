/**
 * simulation tick
 */
/atom/movable/overmap_object/proc/Tick(seconds, times_fired)
	// check if we need to still move
	if(!IsMoving())
		moving = FALSE
		overmap.moving -= src
	#warn impl

/atom/movable/overmap_object/Cross(atom/movable/AM)
	// No rigidbody collisions implemented yet
	// yes, this means we don't send a signal, sue me
	return TRUE

/atom/movable/overmap_object/Uncross(atom/movable/AM, atom/newloc)
	// No rigidbody collisions implemented yet
	// yes, this means we don't send a signal, sue me
	return TRUE

/// forcemove wrapper - admins can literally pull shuttles up from orbit with this
/atom/movable/overmap_object/forceMove(atom/destination)
	var/oldloc = loc
	. = ..()
	OnForceMove(oldloc)

/**
 * Triggered by forcemove
 *
 * for admin ~~abuse~~ ehm I mean convenience, forcemoving an object out of another object while it is docked
 * will quite literally tear the ship into orbit whereever you move it to.
 *
 * it will also nullify all velocity so you don't accidentally slam people into asteroids (tragic!)
 */
/atom/movable/overmap_object/proc/OnForceMove(atom/oldloc)
	velocity_x = 0
	velocity_y = 0
	velocity_angle = 0
	#warn impl

/**
 * checks if we're moving
 */
/atom/movable/overmap_object/proc/IsMoving()
	return OVERMAPS_QUANTIZE_VELOCITY(velocity_x) || OVERMAPS_QUANTIZE_VELOCITY(velocity_y) || OVERMAPS_QUANTIZE_VELOCITY(velocity_angle)

/**
 * adjust velocities
 */
/atom/movable/overmap_object/proc/AdjustVelocity(x, y, angle)
	velocity_x += x
	velocity_y += y
	velocity_angle += angle
	if(!moving)
		moving = TRUE
		overmap.moving += src
