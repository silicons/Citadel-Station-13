// Holds codes for the projection methods

/**
 * Particle projection - meant for "single fire" projections.
 */
/datum/particle_projection
	/// atoms hit list
	var/list/atoms
	/// intensities of hit per atom list - synchronized to atoms.
	var/list/intensities
	/// source of the projection - this is usually the root object casting a particle
	var/atom/source
	/**
	 * act callback - if existing, will be called with (target, intensity, time, index)
	 * time is world.time since start and index is the object count that's been acted on
	 * if this returns false, the thing will not be added to atoms list
	 */
	var/datum/callback/act_callback
	/// exotic_effect we represent
	var/datum/exotic_effect/effect
	/// amount of things acted on so far
	var/acted = 0
	/// finished?
	var/finished
	/// world.time of start
	var/start_time

/datum/particle_projection/New()
	Reset()

/datum/particle_projection/proc/Reset()
	atoms = list()
	intensities = list()
	finished = null
	start_time = null
	acted = 0

/datum/particle_projection/proc/FlattenToOverall()
	. = list()
	for(var/i in 1 to atoms.len)
		.[atoms[i]] = intensities[i]

/**
 * instructs a projection to run
 *
 * @params
 * - immediate_finish - skip any ticked iteration and immediately simulate the entire thing as if infinite time has passed
 */
/datum/particle_projection/proc/Run(immediate_finish)
	if(immediate_finish)

/**
 * executes the next tick of a projection
 *
 * return TRUE if there's more work to do
 */
/datum/particle_projection/proc/Tick(immediate_finish)
	CRASH("Abstract Tick() called on /datum/particle_projection")

/**
 * acts on something hit
 */
/datum/particle_projection/proc/Act(atom/A, intensity, immediate_finish)


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

