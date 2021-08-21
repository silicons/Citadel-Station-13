/**
 * Metadata held about an projection instance
 */
/datum/exotic_cast
	/// particle datum
	var/datum/exotic_particle/particle
	/// particle variables
	var/list/datum/exotic_property/variables
	/// projection mode passed in
	var/mode = NONE
	/// projection type passed in
	var/projection = NONE
	/// projection properties passed in
	var/properties = NONE

	/// turfs already afflicted
	var/list/turf/turfS_hit = list()
	/// atoms already afflicted
	var/list/atom/atoms_hit = list()

	/// physical object used to cast. the effect will be centered here if relevant.
	var/atom/caster
	/// logical user that caused the cast, if different
	var/atom/user

	/// range
	var/range = 1
	/// target list - atoms, or angles clockwise from NORTH.
	var/list/targets = list()
