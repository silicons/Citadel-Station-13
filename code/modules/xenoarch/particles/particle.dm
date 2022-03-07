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
	/// Discovered name
	var/discovered_name = "Undefined Particle"
	/// ID
	var/id
	/// next UID
	var/static/id_next = 0
	/// Supported projection effects
	var/list/supported_effects = list(

	)

/datum/exotic_particle/New()
	if(isnull(id))
		id = "[++id_next]"

/**
 * Represents one method of projecting a particle
 *
 * Effects are encoded to these
 */
/datum/exotic_effect
	/// Actual name
	var/name = "Unkonwn Particle Emission"
	/// supported projection methods
	var/supported_methods = NONE


/**
 * acts on an atom
 *
 * nullifying effects/protections should be checked BEFORE this
 */
/datum/exotic_effect/proc/Act(atom/A, intensity, power, range, time, index)
