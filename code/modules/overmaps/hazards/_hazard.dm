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
	var/datum/overmap_hazard/hazard = SSovermaps.GetHazard(hazard_id)
	if(hazard)
		SetHazard(hazard)

/atom/movable/overmap_object/tile/hazard/proc/SetHazard(datum/overmap_hazard/hazard)
	name = hazard.name
	desc = hazard.desc
	icon = hazard.icon
	icon_state = hazard.icon_state
	color = hazard.color
	hazard_id = hazard.id

/atom/movable/overmap_object/tile/hazard/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(!istype(AM, /atom/movable/overmap_object))
		return

	if(istype(AM, src.type))
		return

	var/atom/movable/overmap_object/O = AM
	O.AddHazard(src, hazard_id, hazard_strength)

/atom/movable/overmap_object/tile/hazard/Uncrossed(atom/movable/AM, oldloc)
	. = ..()
	if(!istype(AM, /atom/movable/overmap_object))
		return
	var/atom/movable/overmap_object/O = AM
	O.RemoveHazard(src)

/**
 * The actual hazard datum
 */
/datum/overmap_hazard
	var/name = "Unknown Hazard"
	var/desc = "Report this to a coder!"
	var/icon = 'icons/modules/overmaps/tile.dmi'
	var/icon_state = "unknown"
	var/color = COLOR_RED

	/// abstract type
	var/abstract_type = /datum/overmap_hazard

	/// unique id, defaulting to path
	var/id

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

