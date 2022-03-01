/atom/movable/overmap_object/tile/hazard/electrical_storm
	hazard_id = /datum/overmap_hazard/electrical_storm

/datum/overmap_hazard/electrical_storm
	name = "electrical storm"
	icon_state = "electrical"
	has_random_state = 4

	default_announce = TRUE
#warn impl

/datum/overmap_hazard/electrical_storm/affect_entity(atom/movable/overmap_object/entity/O, strength)
	. = ..()
