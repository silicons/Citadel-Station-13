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
	/// Supported types
	var/trigger_type
	/// Host component
	var/datum/component/anomaly/host

/datum/exotic_trigger/Destroy()
	if(host)
		Detach(host)
	return ..()

/datum/exotic_trigger/proc/Attach(datum/component/anomaly/host)
	if(host)
		Detach()
	src.host = host
	if(host)
		Register(host, host.parent)

/datum/exotic_trigger/proc/Detach()
	if(!host)
		return
	Unregister(host, host.parent)
	host.CleanupTrigger(src)
	host = null

/datum/exotic_trigger/proc/GetScannerHint()
	return isnull(scan_hint)? "an undefined trigger - contact coderbus for this to be fixed ([type] [REF(src)] - [name])" : scan_hint

/datum/exotic_trigger/proc/Register(datum/component/anomaly/A, obj/O)

/datum/exotic_trigger/proc/Unregister(datum/component/anomaly/A, obj/O)

/**
 * For continuously checked triggers
 */
/datum/exotic_trigger/proc/ConditionsMet()
	CRASH("Abstract ConditionsMet called on base exotic trigger.")

/**
 * For signalled triggers, this is what you should have signals call on trigger
 */
/datum/exotic_trigger/proc/SiganlProc()
	host.OnTrigger(src)
