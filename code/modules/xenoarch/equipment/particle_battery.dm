/**
 * Particle batteries
 *
 * Stores exotic particles for use in devices.
 */
/obj/item/xenoarch/particle_battery
	name = "particle battery"
	desc = "A self-contained storage unit for exotic particles, used to power various pieces of advanced equipment."
	icon_state = "particle_battery"

	/// the stored particle datum
	var/datum/exotic_particle/stored
	/// "units" of it we have stored
	var/charge = 0
	/// maximum storage in this battery
	var/max_charge = 1000

/obj/item/xenoarch/particle_battery/Initialize()
	. = ..()
	if(ispath(stored))
		stored = new stored
	else if(!istype(stored))
		charge = 0
		stored = null

/**
 * uses an amount
 *
 * returns amount used
 */
/obj/item/xenoarch/particle_battery/proc/UseParticles(amount, require_exact, require_particle_id)
	if(!stored)
		return 0
	if(require_exact && charge < amount)
		return 0
	if(require_particle_id && stored?.id != require_particle_id)
		return 0
	var/used = min(amount, charge)
	charge = clamp(charge - amount, 0, max_charge)
	return used

/**
 * charges particles
 *
 * returns amount charged
 */
/obj/item/xenoarch/particle_battery/proc/ChargeParticles(amount, datum/exotic_particle/particle)
	if(stored && stored.id != particle.id)
		return 0
	var/charged = min(max_charge - charge, amount)
	charge = clamp(charge + amount, 0, max_charge)
	return charged

/**
 * failstate: leak some charge
 */
/obj/item/xenoarch/particle_battery/proc/leak(amount)
	#warn impl

/**
 * failstate: detonate
 */
/obj/item/xenoarch/particle_battery/proc/detonate()
	#warn impl



