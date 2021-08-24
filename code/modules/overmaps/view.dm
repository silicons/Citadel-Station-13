/**
 * view datums
 *
 * these are necessary to manage the view shown on overmap uis
 */
/datum/overmap_view
	/// id for screen locs
	var/screen
	/// holds plane masters
	var/list/atom/movable/overmap_hud/plane/plane_masters
	/// master object - holds turfs
	var/atom/movable/overmap_hud/master/master
	/// primary lighting
	var/atom/movable/overmap_hud/light/circle/static_vision
	/// lighting darkifier
	var/atom/movable/overmap_hud/darkifier/darkness

	/// images to show to users
	var/list/images

/datum/overmap_view/New(atom/movable/overmap_object/object)
	if(!object)
		CRASH("Invalid object")
	screen = "map_[object.id]"
	initialize_planes()
	initialize_lighting()
	initialize_images()
	initialize_master()

/**
 * Gets the screen objects to apply to a client
 */
/datum/overmap_view/proc/GetScreen()
	. = list(master, static_vision, darkness)
	. |= plane_masters

/**
 * Instantiates an overmap object
 * Always use this.
 */
/datum/ovemrap_view/proc/MakeHUDObject(path)
	. = new path(src)
