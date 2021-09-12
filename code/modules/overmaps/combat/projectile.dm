/**
 * Overmap projectiles
 *
 * Separate from actual projectiles for modularity
 */
/atom/movable/overmap_object/projectile
	name = "projectile"
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

/atom/movable/overmap_object/projectile/proc/CheckImpact(atom/movable/overmap_object/O)
	if(O == firer)
		return FALSE
	if(istype(O, /atom/movable/overmap_object/projectile))
		#warn complicated checks here for intercept
	#warn IFF checks here
	return TRUE

/atom/movable/overmap_object/projectile/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(AM, /atom/movable/overmap_object))
		if(CheckImpact(AM))
			var/ret = Impact(AM)
