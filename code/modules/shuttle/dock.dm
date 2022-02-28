/**
 * docking ports are what shuttles dock to
 *
 * when docking, the shuttle object's dir will match the docking port's dir.
 */
/atom/movable/shuttle_dock
	name = "unknown shuttle dock"
	invisibility = INVISIBILITY_ABSTRACT
	/// unique id
	var/id
	/// next id
	var/static/id_next = 0
	///

/atom/movable/shuttle_dock/Initialize(mapload)
	. = ..()
	if(isnull(id))
		id = "[++id_next]"
	return INITIALIZE_HINT_LATELOAD

/atom/movable/shuttle_dock/LateInitialize()
	. = ..()
	Setup()
