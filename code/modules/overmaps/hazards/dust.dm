/atom/movable/overmap_object/tile/hazard/dust
	hazard_id = /datum/overmap_hazard/dust

/datum/overmap_hazard/dust
	name = "space dust"
	icon_state = "dust"
	has_random_state = 4

	default_announce = TRUE
#warn impl

/datum/overmap_hazard/dust/affect_entity(atom/movable/overmap_object/entity/O, strength)
	. = ..()
