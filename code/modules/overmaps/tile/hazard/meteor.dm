/atom/movable/overmap_object/tile/hazard/meteor
	hazard_id = /datum/overmap_hazard/meteor

/datum/overmap_hazard/meteor
	name = "meteor field"
	icon_state = "meteor"
	has_random_state = 4

	danger_strength = 0
	default_announce = TRUE
#warn impl

/datum/overmap_hazard/meteor/affect_entity(atom/movable/overmap_object/entity/O, strength)
	. = ..()
