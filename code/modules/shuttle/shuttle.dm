/**
 * #Shuttles
 *
 * Shuttles are the abstract concept of moving a part of the map. They can be as their name implies, shuttles,
 * elevators, turbolifts, transport pads, etc etc.
 *
 * Shuttles are physical, abstract objects.
 * This avoids the issue of synchronizing a datum with a docking port; the docking port is what the physical shuttle object would be ontop of.
 */
/atom/movable/shuttle
	name = "shuttle"
	invisibility = INVISIBILITY_ABSTRACT
	dir = NORTH

	// ID - string, used to identify this shuttle
	/// unique id
	var/id
	/// next unique id
	var/id_next
	/// are we registered with SSshuttle?
	var/registered = FALSE

	// Bounding box - anything outside of this won't be allowed to be taken with the shuttle.
	// Shuttle construction/area expansion should be careful to not overflow this.
	/// size of covered area, perpendicular to dir. this is usually set automatically.
	var/width
	/// size of covered area, parallel to dir. this is usually set automatically.
	var/height
	/// position relative to covered area, perpendicular to dir. this is usually set automatically.
	var/dwidth
	/// position relative to covered area, parallel to dir. this is usually set automatically.
	var/dheight
	/// the areas in us - usually detected automatically. this is a list of instances!
	var/list/areas

	// controller - this is the actual processed object controlling the shuttle
	/// default controller type
	var/shuttle_controller_type = /datum/shuttle_controller
	/// controller instance
	var/datum/shuttle_controller/controller

	// docking
	/// the dock we're docked at
	var/atom/movable/shuttle_dock/docked
	/// the dock we're currently going towards
	var/atom/movable/shuttle_dock/destination
	/// the transit dock we go through to get to the destination
	var/atom/movable/shuttle_dock/transit
	/// only active during maploading - shuttle template loader will handle setting this - if we're template loaded, where do we move to? clear after moving.
	var/atom/movable/shuttle_dock/roundstart

	// ticking/processing
	/// mode - where we physically are
	var/mode = SHUTTLE_MODE_DOCKED
	/// state - used for processing
	var/state = SHUTTLE_STATE_IDLE
	/// world.time where we should finish this processing stage
	var/timer


/atom/movable/shuttle/Initialize(mapload)
	. = ..()
	if(isnull(id))
		id = "[++id_next]"

/atom/movable/shuttle/proc/InitShuttle()
	Register()
	Setup()
	MoveToRoundstart()

/atom/movable/shuttle/Destroy(force)
	if(!force)
		return QDEL_HINT_LETMELIVE
	QDEL_NULL(controller)
	#warn handle the 3 docks we can be on
	if(registered)
		Unregister()
	return ..()

/**
 * sets up the shuttle
 */
/atom/movable/shuttle/proc/Setup()

/**
 * registers the shuttle with SSshuttle
 */
/atom/movable/shuttle/proc/Register()

/**
 * time until next state
 */
/atom/movable/shuttle/proc/TimeLeft()
	return max(0, timer - world.time)

/**
 * tick our current state
 */
/atom/movable/shuttle/proc/Tick()
	switch(state)
		if(SHUTTLE_STATE_IDLE)

		if(SHUTTLE_STATE_IGNITING)

		if(SHUTTLE_STATE_TRANSIT)

		if(SHUTTLE_STATE_DOCKING)
