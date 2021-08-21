/**
 * Exotic Particles
 *
 * The true core of xenoarcheology
 * As many effects as possible should be decomposed into a "particle projection" with a mode, projection type, and additional effect fields.
 * This way they can be replicated by science devices without too much extra code.
 *
 * They are passed around by reference so we can instantiate them as needed.
 *
 * Machines should **never** modify them for this matter, as we can also cache them by ID
 */
/datum/exotic_particle
	/// Actual name
	var/name = "Undefined Particle"
	/// Player-facing name
	var/scan_name = "???"
	/// ID
	var/id
	/// next UID
	var/static/id_next = 0
	/// valid projection types
	var/valid_projection_types = NONE
	/// valid projection modes
	var/valid_projection_modes = NONE
	/// projection properties
	var/projection_properties = NONE

/datum/exotic_particle/New()
	id = ++id_next

// Burst casts
/**
 * Called when a projection is finally blocked by something
 */
/datum/exotic_particle/proc/Impact(atom/victim, datum/exotic_cast/projection)

/**
 * Called when a projection affects something.
 */
/datum/exotic_particle/proc/Affect(atom/victim, datum/exotic_cast/projection)

/**
 * Called to affect everything on a turf - Affect should not be called separately, this'll handle it, taking into account dampening effects
 */
/datum/exotic_particle/proc/AffectTurf(turf/T, datum/exotic_cast/projection)

/**
 * Called when a projection dissipates
 * Only realistically sensical for beam, field, or on a list of targets for direct.
 */
/datum/exotic_particle/proc/Dissipate(atom/location, datum/exotic_cast/projection)

// Static fields
/**
 * Called when a field enters a new turf
 */
/datum/exotic_particle/proc/FieldTurf(turf/T, datum/exotic_field/projection)

/**
 * Called when a field exits a turf
 */
/datum/exotic_particle/proc/DefieldTurf(turf/T, datum/exotic_field/projection)

/**
 * Called when a field afflicts a new atom
 */
/datum/exotic_particle/proc/FieldAtom(atom/A, datum/exotic_field/projection)

/**
 * Called when a field stops a fflicting an atom
 */
/datum/exotic_particle/proc/DefieldAtom(atom/A, datum/exotic_field/projection)

/**
 * Called to tick a field upon an atom or turf
 */
/datum/exotic_particle/proc/FieldTick(atom/victim, datum/exotic_field/projection)


// Projection procs
/**
 * Project this particle
 *
 * @params
 * * type - bitflag of the type of projection (e.g. self, beam, field, etc)
 * * mode - mode of the projection (e.g. destructive, constructive, synchronizing, etc)
 * * proeprties - projection properties (e.g. blocked by glass, etc). usually defaulting to the [projection_properties] set on this.
 * * variables - /datum/exotic_property instance = value list for additional information unable to be conveyed by flags
 * * origin - atom this projection originates from
 * * user - atom that's consciously responsible for triggering this projection
 * * targets - list of targets. unreliable/nonsensical for things like fields, but used for targeted/beam/etc
 */
/datum/exotic_particle/proc/Project(type, mode, properties = projection_properties, list/variables, atom/origin, atom/user, list/targets)

/**
 * Project this particle constantly, returning a /datum/exotic_field.
 *
 * @params
 * * type - bitflag of the type of projection (e.g. self, beam, field, etc)
 * * mode - mode of the projection (e.g. destructive, constructive, synchronizing, etc)
 * * proeprties - projection properties (e.g. blocked by glass, etc). usually defaulting to the [projection_properties] set on this.
 * * variables - /datum/exotic_property instance = value list for additional information unable to be conveyed by flags
 * * origin - atom this projection originates from
 * * user - atom that's consciously responsible for triggering this projection
 * * targets - list of targets. unreliable/nonsensical for things like fields, but used for targeted/beam/etc
 */
/datum/exotic_particle/proc/Field(type, mode, properties = projection_properties, list/variables, atom/origin, atom/user, list/targets)
