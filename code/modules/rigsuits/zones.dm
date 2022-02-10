/datum/rig_zone_meta
	/// zone
	var/zone
	/// slot capacity
	var/slots
	/// size capacity
	var/size
	/// slot used
	var/slots_used
	/// size used
	var/size_used
	/// max integrity
	var/max_integrity = 400
	/// broken threshold
	var/break_threshold = 100
	/// denting/blunt force damage
	var/brute_damage
	/// burning/searing damage
	var/burn_damage
	/// cannot self repair above this
	var/self_repair_threshold = 260
	/// broken
	var/broken = FALSE

/obj/item/rig/proc/rebuild_zone_system()

/obj/item/rig/proc/slots_left(zone)

/obj/item/rig/proc/size_left(zone)

/obj/item/rig/proc/is_broken(zone)

/obj/item/rig/proc/damage_zone(zone, brute, burn)

/obj/item/rig/proc/damage_all_zones(brute, burn)

/obj/item/rig/proc/fix_all_zones(brute = INFINITY, burn = INFINITY)

/obj/item/rig/proc/fix_zone(zone, brute = INFINITY, burn = INFINITY)
