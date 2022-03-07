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
	Reset()

/datum/particle_projection/proc/Reset()
	atoms = list()
	intensities = list()

/datum/particle_projection/proc/FlattenToOverall()
	. = list()
	for(var/i in 1 to atoms.len)
		.[atoms[i]] = intensities[i]

/datum/particle_projection/proc/Run(atom/source, atom/target, intensity, max_range = 14, falloff_exp = 0, falloff_linear = 0)
	CRASH("Abstract Run() called on /datum/particle_projection")

/**
 * Raycast projections
 */
/datum/particle_projection/raycast
	/// originating turf
	var/turf/origin
	/// targeted turf
	var/turf/target
	/// range
	var/range

/datum/

/**
 * Single target projection
 */
/datum/particle_projection/single

/datum/particle_projection/single/proc/Run

/**
 * Particle fields - meant for ticked and constant projections
 */
/datum/particle_field

