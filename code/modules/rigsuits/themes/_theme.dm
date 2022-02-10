GLOBAL_LIST_EMPTY(rig_themes)

/**
 * Gets a rig theme datum from the global cache, or makes it if it isn't there.
 */
/proc/get_rig_theme_datum(datum/rig_theme/type_id_datum)
	if(istype(type_id_datum))
		return type_id_datum
	if(GLOB.rig_themes[type_id_datum])
		return GLOB.rig_themes[type_id_datum]
	if(!ispath(type_id_datum))
		return
	GLOB.rig_themes[type_id_datum] = new type_id_datum
	return GLOB.rig_themes[type_id_datum]

/**
 * Rig theme datum
 *
 * Encapsulates all the data for a given type of suit.
 *
 * Icon states:
 * All themes should only have one .dmi for inventory/in world icons, and at most x worn icon spritesheets for x species bodytypes.
 * A string of "_on" will be appended to any state while sealed - if it exists.
 */
/datum/rig_theme
	// identity
	/// override "[name] suit control module" default naming style
	var/name_is_literal = FALSE
	/// name - renders as "[name]" suit control module
	var/name = "unknown"
	/// Description - literal string
	var/desc = "An unknown brand of suit."

	// basics
	/// suit type
	var/suit_type = RIG_TYPE_STANDARD

	// rendering
	/// inventory icons
	var/inventory_icons = 'icons/modules/rigsuits/themes/engineering/inventory.dmi'
	/// onmob icons
	var/worn_icons = 'icons/modules/rigsuits/themes/engineering/worn.dmi'
	/// control module inv state
	var/rig_state = "control"
	/// control module onmob icon base
	var/rig_worn_state = "control"

	// pieces
	// The following variables are all **ordered tuples**.
	/// pieces by typepath
	var/list/pieces = list(
		/obj/item/clothing/head/rig,
		/obj/item/clothing/suit/rig,
		/obj/item/clothing/gloves/rig,
		/obj/item/clothing/shoes/rig
	)
	/// rig piece flags
	var/list/piece_flags = list(
		RIG_PIECE_INHERITS_ARMOR | RIG_PIECE_INHERITS_ENVIRONMENTAL | RIG_PIECE_FIT_OVER_DEFAULT | RIG_PIECE_ENVIRONMENTAL_REQUIRES_SEAL | RIG_PIECE_AUTODEPLOYS | RIG_PIECE_RIGID, RIG_PIECE_ACTION_BUTTON,
		RIG_PIECE_INHERITS_ARMOR | RIG_PIECE_INHERITS_ENVIRONMENTAL | RIG_PIECE_FIT_OVER_DEFAULT | RIG_PIECE_ENVIRONMENTAL_REQUIRES_SEAL | RIG_PIECE_AUTODEPLOYS | RIG_PIECE_RIGID,
		RIG_PIECE_INHERITS_ARMOR | RIG_PIECE_INHERITS_ENVIRONMENTAL | RIG_PIECE_FIT_OVER_DEFAULT | RIG_PIECE_ENVIRONMENTAL_REQUIRES_SEAL | RIG_PIECE_AUTODEPLOYS | RIG_PIECE_RIGID,
		RIG_PIECE_INHERITS_ARMOR | RIG_PIECE_INHERITS_ENVIRONMENTAL | RIG_PIECE_FIT_OVER_DEFAULT | RIG_PIECE_ENVIRONMENTAL_REQUIRES_SEAL | RIG_PIECE_AUTODEPLOYS | RIG_PIECE_RIGID,
	)
	/// rig piece base inv states
	var/list/piece_inv_states = list(
		"head",
		"suit",
		"gloves",
		"shoes"
	)
	/// rig piece base worn states
	var/list/piece_worn_states = list(
		"head",
		"suit",
		"gloves",
		"shoes"
	)
	/// rig piece base names
	var/list/piece_names = list(
		"helmet",
		"chassis",
		"gauntlets",
		"boots"
	)

	// integral components
	/// starting armor
	var/integral_armor = null
	/// armor unmodifiable - if this is true, it won't take slots either!
	var/integral_armor_fixed = FALSE
	/// starting environmental protection
	var/integral_environmental = null
	/// environmental module unmodifiable - if this is true, it won't take slots either!
	var/integral_environmental_fixed = FALSE
	/// starting headlamp
	var/integral_light = /obj/item/rig_component/integral/light
	/// headlamp fixed? won't take slots if so, can't be removed
	var/integral_light_fixed = FALSE
	/// starting magboots/traction boots
	var/integral_magboots = /obj/item/rig_component/integral/magboots
	/// magboots fixed? won't take slots if so, can't be removed
	var/integral_magboots_fixed = FALSE
	/// starting storage component
	var/integral_storage = /obj/item/rig_component/integral/storage
	/// storage component fixed? won't take slots if so, can't be removed
	var/integral_storage_fixed = FALSE

	// components
	/// starting components - typepath list
	var/list/components = list(

	)
	/// starting components - fixed - typepath list - these cannot be removed, and will not take up slots.
	var/list/components_fixed = list(

	)

	// power
	/// cell types we allow
	var/cell_types_allowed = CELL_TYPE_RIG
	/// contains maintenance charging port
	var/has_cell_port = TRUE
	/// starting power module
	var/cell_type = /obj/item/stock_parts/cell/rig
	/// power module is not replaceable
	var/cell_fixed = FALSE

	// zones, logistics, durability
	// the following variables are ordered tuples
	/// zone list
	var/list/zones = list(
		RIG_ZONE_HEAD,
		RIG_ZONE_CHEST,
		RIG_ZONE_L_ARM,
		RIG_ZONE_R_ARM,
		RIG_ZONE_L_LEG,
		RIG_ZONE_R_LEG
	)
	/// size allowed by zone
	var/list/max_sizes = list(
		50,
		50,
		25,
		25,
		25,
		25
	)
	/// slots allowed by zone
	var/list/max_slots = list(
		25,
		25,
		10,
		10,
		10,
		10
	)
	/// max integrity by zone
	var/list/max_integrity = list(
		1000,
		1000,
		500,
		500,
		500,
		500
	)
	// normal variables follow
	/// invulnerable to damage
	var/unbreakable = FALSE
	/// damage is all or nothing - no partial operation
	var/damage_all_or_nothing = FALSE
	/// relative "error checking" capability - helps resist malfunctions before a piece fully breaks - from +100 to -100 (WIP)
	var/reliability_bias = 0
	/// max total weight before slowdown
	var/carry_weight = 50
	/// divide extra weight by this for slowdown
	var/extra_weight_divisor = 30

/datum/rig_part_meta

/datum/rig_zone_meta
