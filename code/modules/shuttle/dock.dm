/**
 * docking ports are what shuttles dock to
 *
 * when docking, the shuttle object's dir will match the docking port's dir.
 *
 * this means shuttle docks **usually** point **towards** from the shuttle, rather than towards the station!
 */
/atom/movable/shuttle_dock
	name = "unknown shuttle dock"
	invisibility = INVISIBILITY_ABSTRACT
	dir = NORTH
	// ID - string, used to identify this dock
	/// unique id
	var/id
	/// next id
	var/static/id_next = 0
	/// are we registered with SSshuttle?
	var/registered = FALSE

	// Bounding box - shuttles that don't fit in this won't be able to dock.
	/// size of covered area, perpendicular to dir.
	var/width = 0
	/// size of covered area, parallel to dir.
	var/height = 0
	/// position relative to covered area, perpendicular to dir.
	var/dwidth = 0
	/// position relative to covered area, parallel to dir.
	var/dheight = 0

	// docking
	/// currently docked shuttle
	var/atom/movable/shuttle/docked
	/// shuttle in transit to this dock
	var/atom/movable/shuttle/inbound

	// roundstart setup
	/// template to load - put an id and it'll be looked up on init
	var/datum/map_template/shuttle/roundstart_template
	/// template key to load from map config.shuttles json
	var/json_key
	/// roundstart loaded?w
	var/roundstart_loaded = FALSE
	/// roundstart load even if not at mapload?
	var/roundstart_load_requires_mapload = TRUE

/atom/movable/shuttle_dock/Initialize(mapload)
	. = ..()
	if(isnull(id))
		id = "[++id_next]"
	if(!mapload && roundstart_load_requires_mapload)
		roundstart_loaded = TRUE
	return INITIALIZE_HINT_LATELOAD

/atom/movable/shuttle_dock/LateInitialize()
	. = ..()
	InitDock()

/atom/movable/shuttle_dock/Destroy(force)
	if(!force)
		return QDEL_HINT_LETMELIVE


/atom/movable/shuttle_dock/proc/InitDock()
	Setup()
	Register()
	if(!roundstart_loaded)
		LoadRoundstart()

/**
 * sets up the dock
 */
/atom/movable/shuttle_dock/proc/Setup()

/**
 * called to see who's docked
 */
/atom/movable/shuttle_dock/proc/GetDocked()
	RETURN_TYPE(atom/movable/shuttle)
	return docked

/**
 * called to see who's occupying us - this is different from docked
 */
/atom/movable/shuttle_dock/proc/IsOccupied()
	RETURN_TYPE(atom/movable/shuttle)
	return docked || inbound



/**
 * can a shuttle **physically** dock on us?
 *
 * @params
 * - shuttle - the shuttle
 * - force - force through things like obstructions. this is an **opinion**.
 */
/atom/movable/shuttle_dock/proc/CanDock(atom/movable/shuttle/shuttle, force)
	. = CheckObstructions(shuttle, force)
	if(. != SHUTTLE_CAN_DOCK)
		return


/**
 * check if we're obstructed for a certain shuttle
 */
/atom/movable/shuttle_dock/proc/CheckObstructions(atom/movable/shuttle/shuttle, force)
	var/atom/movable/shuttle/existing = IsOccupied()
	if(existing && existing != shuttle)
		return SHUTTLE_OBSTRUCTED_

/**
 * Checks if a shuttle fits in our bounding box
 */
/atom/movable/shuttle_dock/proc/InBounds(atom/movable/shuttle/shuttle)

/**
 * Get all turfs in our bounding box
 */
/atom/movable/shuttle_dock/proc/GetTurfs()

/**
 * Called before a shuttle docks.
 */
/atom/movable/shuttle_dock/proc/Docking(atom/movable/shuttle/shuttle)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(COMSIG_SHUTTLE_DOCK_DOCKING, shuttle)
	return TRUE

/**
 * Called after a shuttle docks.
 */
/atom/movable/shuttle_dock/proc/Docked(atom/movable/shuttle/shuttle)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(COMSIG_SHUTTLE_DOCK_DOCKED, shuttle)
	return TRUE

/**
 * Called before a shuttle leaves.
 */
/atom/movable/shuttle_dock/proc/Undocking(atom/movable/shuttle/shuttle)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(COMSIG_SHUTTLE_DOCK_UNDOCKING, shuttle)
	return TRUE

/**
 * Called after a shuttle leaves.
 */
/atom/movable/shuttle_dock/proc/Undocked(atom/movable/shuttle/shuttle)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(COMSIG_SHUTTLE_DOCK_UNDOCKED, shuttle)
	return TRUE
