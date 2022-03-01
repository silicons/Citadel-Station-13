/**
 * Overmap projectiles
 *
 * Separate from actual projectiles for modularity
 */
/atom/movable/overmap_object/entity/projectile
	name = "generic projectile"

	/// firer
	var/atom/movable/overmap_object/firer

	// primary projectile type
	var/projectile_type = OVERMAP_PROJECTILE_KINETIC

	// physics
	/// pentrating power
	var/k_penetration = 10
	/// energy
	var/k_energy = 10000
	/// do we breach tiles on purpose or only "dense" objects
	var/k_plating_breach = TRUE

	// explosives
	/// explodes
	var/e_trigger = FALSE
	/// deterministic explosions - power
	var/e_power = 300
	/// determinsitic explosions - falloff factor
	var/e_falloff = 0.97
	/// determinsitic epxlosions - falloff constant
	var/e_decay = 3
	/// deterministic explosions - resistance to block
	var/e_block_resist = 0.5
	/// tiles penetration max before detonating
	var/e_on_tiles = 20

	/**
	 * target for self guided projectiles. If null, it will not self guide and do normal vx vy
	 */
	var/atom/movable/target = null
	var/fuel = 0
	var/time_to_live = INFINITY

/atom/movable/overmap_object/entity/projectile/proc/CheckImpact(atom/movable/overmap_object/O)
	if(O == firer)
		return FALSE
	if(istype(O, /atom/movable/overmap_object/entity/projectile))
		#warn complicated checks here for intercept
	#warn IFF checks here
	return TRUE

/atom/movable/overmap_object/entity/projectile/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(AM, /atom/movable/overmap_object))
		if(CheckImpact(AM))
			var/ret = Impact(AM)

/**
 * ix - Initial X velocity
 * iy - Initial Y velocity
 * iangle - initial angle(when launched)
 * selfguided_target - self target for missiles
 * fuel - fuel count before the self guidance dies
 */
/atom/movable/overmap_object/entity/projectile/Initialize(mapload, ix, iy, iangle, atom/movable/selfguided_target = null, fuel = null)
	. = ..()
	SetVelocity(ix, iy, iangle) // todo: get parent ship angle
	target = selfguided_target
	if (fuel)
		src.fuel = fuel
	time_to_live = INFINITY

/atom/movable/overmap_object/entity/projectile/Tick(ds, times_fired)
	. = ..()
	// dumb bombs
	if (!target || time_to_live == INFINITY)
		return
	// ttl survival
	if (time_to_live < world.time)
		qdel(src)
		return
	if (fuel <= 0) // out of fuel, arm self destruct
		if(!time_to_live)
			time_to_live = world.time + (45 SECONDS)
		return

	// the missile knows where it is, because it knows where it isn't.
	var/dy = target.y - y
	var/dx = target.x - x
	var/nangle = tan(dy / dx)
	var/dangle = abs(angle - nangle)
	SetVelocity(dx, dy, nangle)
	// fuel @ 100% efficiency i guess?
	// according to desmos, a rough 360 turn will do 171.428 fuel usage
	// https://www.desmos.com/calculator/l2ck3boo7m
	fuel = clamp(abs(fuel * 1.1) - dangle, 0, initial(fuel))

/atom/movable/overmap_object/entity/projectile/Destroy()
	target = null
	return ..()

/// man i wonder what this is
/atom/movable/overmap_object/entity/projectile/railgun
	name = "railgun bullet"

/// see FTL for tomfoolery about loading clown in the magetically accelerated cannon (railgun)
/atom/movable/overmap_object/entity/projectile/railgun/clown
	name = "railgun tomfoolery"

/// missile
/atom/movable/overmap_object/entity/projectile/torp
	name = "torpedo tube"
	fuel = 300 // can turn like, 3 times when the ship causes src to do sharp 360

/// pew pew
/atom/movable/overmap_object/entity/projectile/laser
	name = "laser"


/atom/movable/overmap_object/entity/projectile/laser/Initialize(mapload)
	. = ..()
	time_to_live = world.time + (30 SECONDS)
