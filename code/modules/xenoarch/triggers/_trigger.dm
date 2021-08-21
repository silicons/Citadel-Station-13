/**
 * Trigger datums
 * These determine when an anomaly is activated
 *
 * These do not handle the actual switching/activation
 * These just inform something when it has triggered, and provides a proc to check for conditions.
 */
/datum/exotic_trigger
	/// Our actual name
	var/name = "Undefined Trigger"
	/// Our scanner hint
	var/scan_hint

/datum/exotic_trigger/proc/GetScannerHint()
	return isnull(scan_hint)? "an undefined trigger - contact coderbus for this to be fixed ([type] [REF(src)] - [name])" : scan_hint

/datum/exotic_trigger/proc/ConditionsMet()
	return FALSE



