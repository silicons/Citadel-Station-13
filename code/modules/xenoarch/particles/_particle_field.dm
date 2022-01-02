/**
 * Metadata held about an projection instance
 * Unlike exotic_cast, this represents an ongoing field
 */
/datum/exotic_field
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
	/// visual flags passed in
	var/visuals = NONE

	/// turfs currently afflicted
	var/list/turf/turfs = list()
	/// atoms currently afflicted - regardless of them being on those turfs. does not stack.
	var/list/atom/atoms = list()

	/// physical object used to cast. the effect will be centered here if relevant.
	var/atom/caster
	/// logical user that caused the cast, if different
	var/atom/user

	/// range
	var/range = 1
	/// target list - atoms, or angles clockwise from NORTH.
	var/list/targets = list()
