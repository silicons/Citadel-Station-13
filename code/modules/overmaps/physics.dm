/**
 * simulation tick
 */
/atom/movable/overmap_object/proc/Tick(seconds, times_fired)
	// movement
	if(moving)
		if(velocity_angle)
			Turn(velocity_angle)
		if(velocity_x || velocity_y)
			real_x += velocity_x
			real_y += velocity_y
			MoveToOffsets()
	// other processes

	// check if we need to keep going
	if(!ShouldProcess())
		StopProcessing()

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
	ResetStepOffsets()
	#warn if moved out of overmap, rip it out of the map entirely, check for overmaps zlevel and stop moving

/**
 * resets our real step offset tracking to our loc
 */
/atom/movable/overmap_object/proc/ResetStepOffsets()
	real_x = (x - 1) * 32 + step_x
	real_y = (y - 1) * 32 + step_y

/**
 * move to our real loc
 */
/atom/movable/overmap_object/proc/MoveToOffsets()
	Move(locate(1,1,z), NONE, real_x - 32, real_y - 32)

/**
 * checks if we need processing
 */
/atom/movable/overmap_object/proc/ShouldProcess()
	return IsMoving()

/**
 * checks if we're moving
 */
/atom/movable/overmap_object/proc/IsMoving()
	return OVERMAPS_QUANTIZE_VELOCITY(velocity_x) || OVERMAPS_QUANTIZE_VELOCITY(velocity_y) || OVERMAPS_QUANTIZE_VELOCITY(velocity_angle)

/**
 * turns our angle
 */
/atom/movable/overmap_object/proc/Turn(amt)
	angle += amt
	transform.Turn(amt)


/**
 * adjust velocities
 */
/atom/movable/overmap_object/proc/AdjustVelocity(x, y, angle)
	velocity_x = clamp(velocity_x + x, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	velocity_y = clamp(velocity_y + y, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	velocity_angle = MODULUS(velocity_angle + angle, 360)
	if(!moving)
		moving = TRUE
		StartProcessing()

/**
 * sets velocity
 * if a value is null, doesn't set it
 */
/atom/movable/overmap_object/proc/SetVelocity(x, y, angle)
	if(!isnull(x))
		velocity_x = clamp(x, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	if(!isnull(y))
		velocity_y = clamp(y, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	if(!isnull(angle))
		velocity_angle = MODULUS(angle, 360)
	if(!moving)
		moving = TRUE
		StartProcessing()

/**
 * stops processing
 */
/atom/movable/overmap_object/proc/StopProcessing()
	if(!(datum_flags & DF_ISPROCESSING))
		return
	overmap?.processing -= src

/**
 * starts processing
 */
/atom/movable/overmap_object/proc/StartProcessing()
	if(datum_flags & DF_ISPROCESSING)
		return
	overmap?.processing += src
