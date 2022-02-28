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
	/// unique id
	var/id
	/// next unique id
	var/id_next

/atom/movable/shuttle/Initialize(mapload)
	. = ..()
	if(isnull(id))
		id = "[++id_next]"
	return INITIALIZE_HINT_LATELOAD

/atom/movable/shuttle/LateInitialize()
	. = ..()
	Setup()



