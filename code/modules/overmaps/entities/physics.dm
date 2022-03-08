/**
 * simulation tick
 */
/atom/movable/overmap_object/entity/proc/Tick(ds, times_fired)
	if(!ShouldProcess())
		return FALSE
	. = TRUE
	// movement
	if(!isturf(loc))
		velocity_x = 0
		velocity_y = 0
		angle = 0
	else
		if(velocity_angle)
			Turn(velocity_angle)
		if(velocity_x || velocity_y)
			#warn enforce speed limit
			step_in_x_y(velocity_x, velocity_y)
			CheckWraparound()

	ship?.Tick(ds, times_fired)

/atom/movable/overmap_object/entity/proc/CheckWraparound()
	. = FALSE
	var/list/new_coords
	// wraparound is the first tile on the border to the second tile on the other side
	// we could avoid even the 1 border if byond wasn't a POS that hard crashes when vis contents loops :/
	// fuck non recursive vis_flags.
	if(x < 2)
		. = TRUE
		new_coords = list(overmap.width - 1, y, z)
	else if(x > (overmap.width - 1))
		. = TRUE
		new_coords = list(2, y, z)
	if(.)
		jumping = TRUE
		forceMove(locate(new_coords[1], new_coords[2], z), step_x, step_y)
		jumping = FALSE
		CheckWraparound()
		return
	if(y < 2)
		. = TRUE
		new_coords = list(x, overmap.height - 1, z)
	else if(y > (overmap.height  - 1))
		. = TRUE
		new_coords = list(x, 2, z)
	if(.)
		jumping = TRUE
		forceMove(locate(new_coords[1], new_coords[2], z), step_x, step_y)
		jumping = FALSE
		return

/atom/movable/overmap_object/entity/Cross(atom/movable/AM)
	// No rigidbody collisions implemented yet
	// yes, this means we don't send a signal, sue me
	to_chat(world, "[src] crossed [AM]")
	return TRUE

/atom/movable/overmap_object/entity/Uncross(atom/movable/AM, atom/newloc)
	// No rigidbody collisions implemented yet
	// yes, this means we don't send a signal, sue me
	to_chat(world, "[src] uncrossed [AM]")
	return TRUE

/// forcemove wrapper - admins can literally pull shuttles up from orbit with this
/atom/movable/overmap_object/entity/forceMove(atom/destination)
	var/atom/oldloc = loc
	. = ..()
	log_overmap("[src] forceMoved from [oldloc] ([oldloc && COORD(oldloc)]) to [loc] ([loc && COORD(loc)])")
	OnForceMove(oldloc)

/atom/movable/overmap_object/entity/newtonian_move(direction)
	return	// H E L L NO.

/**
 * Triggered by forcemove
 *
 * for admin ~~abuse~~ ehm I mean convenience, forcemoving an object out of another object while it is docked
 * will quite literally tear the ship into orbit whereever you move it to.
 *
 * it will also nullify all velocity so you don't accidentally slam people into asteroids (tragic!)
 */
/atom/movable/overmap_object/entity/proc/OnForceMove(atom/oldloc)
	if(jumping)
		return
	velocity_x = 0
	velocity_y = 0
	velocity_angle = 0
	CheckOvermap()

/**
 * Automatically puts us in and takes us out of an overmap if we're in/out of the zlevel
 */
/atom/movable/overmap_object/entity/proc/CheckOvermap()
	var/turf/T = get_turf(src)
	if(!T)
		return
	var/datum/overmap/wanted = SSovermaps.overmap_lookup["[T.z]"]
	if(!wanted)
		if(overmap)
			overmap.RemoveEntity(src)
	else if(!(src in wanted.entities))
		if(overmap)
			overmap.RemoveEntity(src)
		wanted.AddEntity(src)

/**
 * checks if we need processing
 */
/atom/movable/overmap_object/entity/proc/ShouldProcess()
	return ship || IsMoving() || (datum_flags & DF_ISPROCESSING)

/**
 * checks if we're moving
 */
/atom/movable/overmap_object/entity/proc/IsMoving()
	return OVERMAPS_QUANTIZE_VELOCITY(velocity_x) || OVERMAPS_QUANTIZE_VELOCITY(velocity_y) || OVERMAPS_QUANTIZE_VELOCITY(velocity_angle)

/**
 * turns our angle
 */
/atom/movable/overmap_object/entity/proc/Turn(amt)
	angle += amt
	if(angle < 0)
		angle += 360
	if(angle > 360)
		angle -= 360
	var/matrix/T = matrix(transform)
	T.Turn(amt)
	transform = T

/**
 * adjust velocities relative to map.
 * angle is entirely detached from velocity on overmaps physics sim to optimize for standard case
 * for adjusting using thrusters on directions, etc, use AdjustVelocityRel if you don't want to math
 */
/atom/movable/overmap_object/entity/proc/AdjustVelocity(x = 0, y = 0, angle = 0)
	velocity_x = clamp(velocity_x + x, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	velocity_y = clamp(velocity_y + y, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	velocity_angle = MODULUS(velocity_angle + angle, 360)
	StartProcessing()

/**
 * adjusts velocity relative to self, rather than map
 *
 * @params
 * - parallel - front/back speed. positive = forwards.
 * - perpendicular - sideways speed. posiive = right.
 */
/atom/movable/overmap_object/entity/proc/AdjustVelocityRel(parallel = 0, perpendicular = 0)
	var/x = sin(angle) * parallel - sin(angle + 90) * perpendicular
	var/y = cos(angle) * parallel - cos(angle + 90) * perpendicular
	return AdjustVelocity(x, y, 0)

/**
 * turns our motion by a certain angle.
 */
/atom/movable/overmap_object/entity/proc/TurnVelocity(angle)
	var/currAngle = arctan(y, x)
	var/currVel = sqrt(y**2 + x**2)
	currAngle += angle
	SetVelocity(sin(currAngle) * currVel, cos(currAngle) * currVel)

/**
 * Completely turns by a certain angle
 */
/atom/movable/overmap_object/entity/proc/TurnPhysics(angle)
	Turn(angle)
	TurnVelocity(angle)

/**
 * sets velocity
 * if a value is null, doesn't set it
 */
/atom/movable/overmap_object/entity/proc/SetVelocity(x, y, angle)
	if(!isnull(x))
		velocity_x = clamp(x, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	if(!isnull(y))
		velocity_y = clamp(y, -OVERMAPS_MAX_SPEED, OVERMAPS_MAX_SPEED)
	if(!isnull(angle))
		velocity_angle = MODULUS(angle, 360)
	StartProcessing()

/**
 * stops processing
 */
/atom/movable/overmap_object/entity/proc/StopProcessing()
	if(!(datum_flags & DF_ISPROCESSING))
		return
	datum_flags &= ~DF_ISPROCESSING
	overmap?.processing -= src

/**
 * starts processing
 */
/atom/movable/overmap_object/entity/proc/StartProcessing()
	if(datum_flags & DF_ISPROCESSING)
		return
	datum_flags |= DF_ISPROCESSING
	overmap?.processing += src
