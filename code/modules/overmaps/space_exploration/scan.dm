/**
 * radar.
 * How it works?
 *
 * 1.) Ping around it <br />
 * 2.) When the ping returns, see if they are returning
 */
/datum/ship_system/radar
	name = "Primary Radar (unknown)"
	/// list of IFF that's tagged as enemy.
	var/list/enemyIFF = list(OVERMAP_IFF_SYNDIE)

	var/list/friendlyIFF = list(OVERMAP_IFF_NT)

	var/list/neutralIFF = list(OVERMAP_IFF_UNKNOWN, OVERMAP_IFF_WIZARD) // neutral / unknown

	/// range of the radar.
	var/range = 9
	/// range where the IFF detects FOF
	var/IFFrange = (range / 2) + 1
	/// power usage of the radar. (active)
	var/power_usage = 500
	/// ping delay
	var/ping_delay = 5 SECONDS
	var/lastfire
	/// delays the firing by ping delay/2
	var/stillboggingthestack = FALSE

/datum/ship_system/radar/New(datum/ship/ship)
	. = ..()
	name = "Primary Radar ([ship.parent.name])"

/datum/ship_system/radar/Tick(ds, times_fired)
	if (ping_delay > world.time)
		return
	if (stillboggingthestack) // built in functionality so it doesnt fire when the thread isn't done (5000 missiles :sus:)
		lastfire = world.time + (ping_delay / 2)
		return
	INVOKE_ASYNC(src, .proc/ping) // feature.
	lastfire = world.time + ping_delay

/datum/ship_system/radar/proc/updateRange(range)
	src.range = range
	src.IFFrange = (range / 2) + 1
	return range * power_usage

/// hey keb idk if this is slow
/datum/ship_system/radar/proc/ping()
	stillboggingthestack = TRUE
	var/list/bogeys = range(range, ship.parent)
	for (var/atom/movable/overmap_object/OM in bogeys)
		if (!OM.ship)
			continue

		var/datum/weakref/wr = WEAKREF(OM.ship)
		ship.bogeys["tracked"] |= wr // default grey

		if (get_dist(ship.parent, OM) > IFFrange)
			continue

		if (verifyIFF(OM.ship.iff, enemyIFF))
			ship.bogeys["enemy"] |= wr // green
			ship.bogeys["friendly"] -= wr // blue
			ship.bogeys["neutral"] -= wr // white
			continue

		if (verifyIFF(OM.ship.iff, friendlyIFF))
			ship.bogeys["enemy"] -= wr
			ship.bogeys["friendly"] |= wr
			ship.bogeys["neutral"] -= wr
			continue

		ship.bogeys["enemy"] -= wr
		ship.bogeys["friendly"] -= wr
		ship.bogeys["neutral"] |= wr
	stillboggingthestack = FALSE
