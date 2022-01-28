// Holds codes for the projection methods

/**
 * Particle projection - meant for "single fire" projections.
 */
/datum/particle_projection
	/// atoms hit list
	var/list/atoms
	/// intensities of hit per atom list - synchronized to atoms.
	var/list/intensities

/datum/particle_projection/New()
	atoms = list()
	intensities = list()

/datum/particle_projection/proc/Reset()
	atoms = list()
	intensities = list()

/datum/particle_projection/proc/FlattenToOverall()
	. = list()
	for(var/i in 1 to atoms.len)
		.[atoms[i]] = .[atoms[i]] + intensities[i]

/datum/particle_projection/proc/Run()
	CRASH("Abstract Run() called on /datum/particle_projection")

/**
 * Raycast projections
 */
/datum/particle_projection/raycast
	/// originating turf
	var/turf/origin
	///


/**
 * Particle fields - meant for ticked and constant projections
 */
/datum/particle_field

