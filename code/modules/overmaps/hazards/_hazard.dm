/**
 * Hazards
 *
 * Objects with fulltile collision boxes that represent a hazard status, which will be present on anything touching it
 */
/atom/movable/overmap_object/hazard
	name = "hazard"
	icon = 'icons/overmaps/hazards.dmi'
	icon_state = "hazard"

	/// id of hazard - can be typepath
	var/hazard_id
	/// strength of hazard
	var/hazard_strength = OVERMAP_HAZARD_STRENGTH_DEFAULT

/atom/movable/overmap_object/hazard/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(!istype(AM, /atom/movable/overmap_object))
		return

	if(istype(AM, src.type))
		return

	var/atom/movable/overmap_object/O = AM
	O.AddHazard(src, hazard_id, hazard_strength)

/atom/movable/overmap_object/hazard/Uncrossed(atom/movable/AM, oldloc)
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
	var/icon = 'icons/overmaps/hazard_ui.dmi'
	var/icon_state = ""

	/// unique id, defaulting to path
	var/id

/datum/overmap_hazard/New()
	if(isnull(id))
		id = type

/**
 * called on every tick
 */
/datum/overmap_hazard/proc/affect_object(atom/movable/overmap_object/O, strength = OVERMAP_HAZARD_STRENGTH_DEFAULT)

/**
 * called to see if we can affect something
 */
/datum/overmap_hazard/proc/can_affect(atom/movable/overmap_object/O, strength = OVERMAP_HAZARD_STRENGTH_DEFAULT)
	return TRUE

