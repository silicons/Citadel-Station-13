/atom/movable/overmap_object/tile/hazard/carp
	hazard_id = /datum/overmap_hazard/carp

/datum/overmap_hazard/carp
	name = "space carp"
	icon_state = "carp"
	has_random_state = 4

	default_announce = TRUE
#warn impl

/datum/overmap_hazard/carp/affect_entity(atom/movable/overmap_object/entity/O, strength)
	. = ..()
