/**
 * These are the physical projectiles that get put into the map and fired by an impact to "standard" overmap locations (as opposed to things like planets)
 */
/obj/item/projectile/overmap_projectile
	name = "munitions"
	// GOTTAGOFAST
	pixels_per_second = TILES_TO_PIXELS(20)

	/// standard type
	var/type = OVERMAP_PROJECTILE_KINETIC

	/**
	 * how this works:
	 *
	 * k_penetration and k_energy are realistically used both for kinetic and energy types
	 * explosive types detonate some point within the ship either when they're out of energy or when a preset number of tiles go through
	 */
	// instance tracking
	/// tiles penetrated
	var/p_tiles_hit = 0

	// projectile energistics
	/// penetrating power - how far it'll go for when hitting hard objects. higher penetration means less energy expended per tile.
	var/k_penetration = 10
	/// kinetic energy - how much total energy is going to be released. 1000 is generally equivalent to a minibomb.
	var/k_energy = 10000
	/// original kinetic energy
	var/k_energy_original
	/// do we breach the hull or only impact walls - useful for anti crew or incendiaries
	var/k_plating_breach = TRUE

	// explosive properties
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

/obj/item/projectile/overmap_projectile/Initialize(mapload, atom/movable/overmap_object/projectile/P)
	. = ..()
	#warn grab properties from projectile
	k_energy_original = k_energy

/**
 * destructive energy release at location
 */
/obj/item/projectile/overmap_projectile/proc/release_energy(location = loc, ratio = 0.1)
	var/released = k_energy * ratio
	k_energy -= released
	wave_explosion(location, released * 0.1, e_falloff, e_decay, source = src)

/**
 * check if we should detonate
 */
/obj/item/projectile/overmap_projectile/proc/check_detonation()
	if(!e_trigger)
		return FALSE
	if(k_energy <= 0)
		return TRUE
	if(p_tiles_hit > e_on_tiles)
		return TRUE
	return FALSE

/**
 * detonate
 */
/obj/item/projectile/overmap_projectile/proc/detonate()

#warn tgprojectiles before finishing this
