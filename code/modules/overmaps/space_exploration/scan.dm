/**
 * radar.
 * How it works?
 *
 * 1.) Ping around it <br />
 * 2.) When the ping returns, see if they are returning
 */
/datum/ship_system/radar
	/// list of IFF that's tagged as enemy.
	var/list/enemyIFF = list("syndicate")

	var/list/friendlyIFF = list("nanotrasen")

	var/list/neutralIFF = list("neutral") // neutral / unknown

	/// range of the radar.
	var/range = 5
	/// power usage of the radar.
	var/power_usage = 300

/datum/ship_system/radar/Tick(ds, times_fired)
	ping()

/datum/ship_system/radar/proc/updateRange(range)
	src.range = range
	return range * power_usage

/datum/ship_system/radar/proc/ping()
	var/list/bogeys = range(range, ship.parent)

