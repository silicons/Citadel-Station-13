/**
 * CORE PROC: Gets the ship we're on
 */
/atom/proc/GetShip()
	return GetOvermapObject()?.ship

/**
 * ships
 *
 * think about this like it's an extension to overmap objects
 */
/datum/ship
	/// our object
	var/atom/movable/overmap_object/entity/parent
	/// subsystems by type
	var/list/datum/ship_system/systems
	/// all machinery in us
	var/list/obj/machinery/ship/machinery
	/// var list about helm

	/// our IFF
	var/iff = OVERMAP_IFF_UNKNOWN

	/**
	 * # Ship's radar bogey cache
	 * Data structure
	 * ```tsx
	 * [key: /datum/weakref]: {"coords": "x,y", "iff": "iff"}
	 * ```
	 */
	var/list/bogeys = list()

	/* ship based tomfoolery. */
	/// Angle we /want/ to achive. Slowly ticks up based on where engines are facing etc.
	var/target_angle = 0
	/// turning radius of the ship. Calculated / t if target angle != parent.angle
	var/turning_radius = 90

/datum/ship/New(atom/movable/overmap_object/parent)
	src.parent = parent
	machinery = list()
	InitializeSystems()
	LinkMachinery()

/datum/ship/Destroy()
	UnlinkMachinery()
	DestroySystems()

	if(parent)
		parent.ship = null

	return ..()

/datum/ship/proc/InitializeSystems()
	// for (var/datum/ship_system/ship_sys in GLOB.default_ship_systems)
		// systems.Add(new ship_sys(src))

/datum/ship/proc/LinkMachinery()

/datum/ship/proc/DestroySystems()
	QDEL_LIST_ASSOC_VAL(systems)
	QDEL_LIST(bogeys)

/datum/ship/proc/UnlinkMachinery()


// /// In degrees.
// /datum/ship/set_desired_angle(rudder_angle)
// 	if (target_angle == rudder_angle)
// 		return FALSE
// 	target_angle = rudder_angle
