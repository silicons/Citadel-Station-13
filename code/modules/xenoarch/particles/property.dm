/**
 * Property datums
 *
 * Sometimes, mode + projection doesn't cut it
 * Example: psionic energy message to display
 *
 * Much like particles, these are passed by reference. These must never be modified after creation by the thing creating it, so we do not corrupt the global cache.
 *
 * In those cases, these datums will handle the job of providing extra, bounded & checked inputs.
 */
/datum/exotic_property
	/// Actual name for this
	var/name = "Unnamed property"
	/// User-facing name
	var/scan_name = "???"

