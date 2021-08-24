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
	/// master object
	var/atom/movable/overmap_hud/master/master
	/// primary lighting
	var/atom/movable/overmap_hud/light/circle/static_vision

	/// images to show to users
	var/list/images

/datum/overmap_view/New(atom/movable/overmap_object/object)
	if(!object)
		CRASH("Invalid object")
	screen = "map_[object.id]"
	initialize_planes()
	initialize_static_vision()
	initialize_images()
	initialize_master()
