/**
 * Hazards
 *
 * Objects with fulltile collision boxes that represent a hazard status, which will be present on anything touching it
 */
/atom/movable/overmap_object/tile/hazard
	name = "hazard"
	icon = 'icons/modules/overmaps/tile.dmi'
	icon_state = "unknown"
	color = COLOR_RED

	/// id of hazard - can be typepath
	var/hazard_id
	/// strength of hazard
	var/hazard_strength = OVERMAP_HAZARD_STRENGTH_DEFAULT

/atom/movable/overmap_object/tile/hazard/Initialize(mapload)
	. = ..()
	var/datum/overmap_hazard/hazard = SSovermaps.GetHazardID(hazard_id)
	if(hazard)
		SetHazard(hazard)

/atom/movable/overmap_object/tile/hazard/proc/SetHazard(datum/overmap_hazard/hazard)
	name = hazard.name
	desc = hazard.desc
	icon = hazard.icon
	icon_state = hazard.get_icon_state()
	color = hazard.get_color(hazard_strength)
	hazard_id = hazard.id

/atom/movable/overmap_object/tile/hazard/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(!istype(AM, /atom/movable/overmap_object/entity))
		return

	if(istype(AM, src.type))
		return

	var/atom/movable/overmap_object/entity/O = AM
	O.AddHazard(src, hazard_id, hazard_strength)

/atom/movable/overmap_object/tile/hazard/Uncrossed(atom/movable/AM, oldloc)
	. = ..()
	if(!istype(AM, /atom/movable/overmap_object/entity))
		return
	var/atom/movable/overmap_object/entity/O = AM
	O.RemoveHazard(src)

/**
 * The actual hazard datum
 */
/datum/overmap_hazard
	var/name = "Unknown Hazard"
	var/desc = "Report this to a coder!"
	var/icon = 'icons/modules/overmaps/tile.dmi'
	var/icon_state = "unknown"
	/// if not null, randomly picks 1 to x.
	var/has_random_state
	var/color = COLOR_RED

	/// abstract type
	var/abstract_type = /datum/overmap_hazard

	/// unique id, defaulting to path
	var/id

	/// should announce?
	var/announce = TRUE
	/// default announce?
	var/default_announce = FALSE

	/// minimum strength to color red
	var/danger_strength = OVERMAP_HAZARD_STRENGTH_STRONG
#warn announce system

/datum/overmap_hazard/New()
	if(isnull(id))
		id = "[type]"

/**
 * called on every tick
 */
/datum/overmap_hazard/proc/affect_entity(atom/movable/overmap_object/entity/O, strength = OVERMAP_HAZARD_STRENGTH_DEFAULT)
	return

/**
 * called to see if we can affect something
 */
/datum/overmap_hazard/proc/can_affect(atom/movable/overmap_object/entity/O, strength = OVERMAP_HAZARD_STRENGTH_DEFAULT)
	return TRUE

/**
 * gets our icon state
 */
/datum/overmap_hazard/proc/get_icon_state()
	return has_random_state? icon_state + "[rand(1, has_random_state)]" : icon_state

/**
 * gets color to use
 */
/datum/overmap_hazard/proc/get_color(strength)
	if(strength >= danger_strength)
		return COLOR_RED
	return COLOR_WHITE

/**
 * start affecting entity
 */
/datum/overmap_hazard/proc/start_affecting_entity(atom/movable/overmap_object/entity/E, strength = OVERMAP_HAZARD_STRENGTH_DEFAULT)
	#warn handle announce

/**
 * stop affecting entity
 */
/datum/overmap_hazard/proc/stop_affecting_entity(atom/movable/overmap_object/entity/E, strength = OVERMAP_HAZARD_STRENGTH_DEFAULT)
	#warn handle announce

/datum/overmap_hazard/proc/announce_start(atom/movable/overmap_object/entity/E, strength = OVERMAP_HAZARD_STRENGTH_DEFAULT)

/datum/overmap_hazard/proc/announce_end(atom/movable/overmap_object/entity/E, strength = OVERMAP_HAZARD_STRENGTH_DEFAULT)
