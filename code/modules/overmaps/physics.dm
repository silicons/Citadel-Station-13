/**
 * simulation tick
 */
/atom/movable/overmap_object/proc/Tick(ds, times_fired)
	if(!ShouldProcess())
		StopProcessing()
	// movement
	if(moving && !isturf(loc))
		velocity_x = 0
		velocity_y = 0
		angle = 0
		moving = FALSE
	if(moving)
		if(velocity_angle)
			Turn(velocity_angle)
		if(velocity_x || velocity_y)
			real_x += velocity_x
			real_y += velocity_y
			MoveToOffsets()
	// other processes

	// check if we need to keep going
	if(ship?.Tick(ds, times_fired))
		// we know we need to
		return

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
	CheckOvermap()

/**
 * Automatically puts us in and takes us out of an overmap if we're in/out of the zlevel
 */
/atom/movable/overmap_object/proc/CheckOvermap()
	var/turf/T = get_turf(src)
	if(!overmap)
		if(T && (T.z == GLOB.overmap?.z))
			GLOB.overmap.AddObject(src)
	else if(overmap)
		if(!T || (T.z != GLOB.overmap?.z))
			GLOB.overmap.RemoveObject(src)

/**
 * resets our real step offset tracking to our loc
 */
/atom/movable/overmap_object/proc/ResetStepOffsets()
	real_x = (x - 1) * 32 + step_x
	real_y = (y - 1) * 32 + step_y

/**
 * move to our real loc
 */
/atom/movable/overmap_object/proc/MoveToOffsets(forcemove = FALSE)
	Move(locate(1,1,z), NONE, real_x - 32, real_y - 32)

/**
 * checks if we need processing
 */
/atom/movable/overmap_object/proc/ShouldProcess()
	return IsMoving() || ship?.ShouldProcess()

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
 * adjust velocities relative to map.
 * angle is entirely detached from velocity on overmaps physics sim to optimize for standard case
 * for adjusting using thrusters on directions, etc, use AdjustVelocityRel if you don't want to math
 */
/atom/movable/overmap_object/proc/AdjustVelocity(x = 0, y = 0, angle = 0)
	velocity_x = clamp(velocity_x + x, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	velocity_y = clamp(velocity_y + y, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	velocity_angle = MODULUS(velocity_angle + angle, 360)
	if(!moving)
		moving = TRUE
		StartProcessing()

/**
 * adjusts velocity relative to self, rather than map
 *
 * @params
 * - parallel - front/back speed. positive = forwards.
 * - perpendicular - sideways speed. posiive = right.
 */
/atom/movable/overmap_object/proc/AdjustVelocityRel(parallel = 0, perpendicular = 0)
	var/x = sin(angle) * parallel - sin(angle + 90) * perpendicular
	var/y = cos(angle) * parallel - cos(angle + 90) * perpendicular
	return AdjustVelocity(x, y, 0)

/**
 * turns our motion by a certain angle.
 */
/atom/movable/overmap_object/proc/TurnVelocity(angle)
	var/currAngle = arctan(y, x)
	var/currVel = sqrt(y**2 + x**2)
	currAngle += angle
	SetVelocity(sin(currAngle) * currVel, cos(currAngle) * currVel)

/**
 * Completely turns by a certain angle
 */
/atom/movable/overmap_object/proc/TurnPhysics(angle)
	Turn(angle)
	TurnVelocity(angle)

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
