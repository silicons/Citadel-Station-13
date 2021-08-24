/**
 * view datums
 *
 * these are necessary to manage the view shown on overmap uis
 */
/datum/overmap_view
	/// id for screen locs
	var/screen
	/// view range
	var/view_range = OVERMAP_VIEW_RANGE
	/// holds plane masters
	var/list/atom/movable/overmap_hud/plane/plane_masters
	/// holds parallax
	var/list/atom/movable/overmap_hud/parallax/parallax_layers
	/// master object - holds turfs
	var/atom/movable/overmap_hud/master/master
	/// primary lighting
	var/atom/movable/overmap_hud/light/circle/static_vision
	/// static vision range
	var/static_vision_range = OVERMAP_STATIC_VISION
	/// lighting darkifier
	var/atom/movable/overmap_hud/darkifier/darkness

	/// images to show to users
	var/list/images
	/// showing
	var/list/client/showing

/datum/overmap_view/New(atom/movable/overmap_object/object)
	if(!object)
		CRASH("Invalid object")
	screen = "map_[object.id]"
	initialize_planes()
	initialize_parallax()
	initialize_lighting()
	initialize_images()
	initialize_master()

/datum/overmap_view/proc/initialize_planes()
	#warn impl

/datum/overmap_view/proc/initialize_parallax()
	#warn impl

/datum/overmap_view/proc/initialize_lighting()
	#warn impl

/datum/overmap_view/proc/initialize_images()
	images = list()

/datum/overmap_view/proc/initialize_master()
	#warn impl
	Update()

/**
 * updates our location
 */
/datum/overmap_view/proc/Update()
	#warn impl

/**
 * updates static vision range
 */
/datum/overmap_view/proc/UpdateStaticVision()

/**
 * Gets the screen objects to apply to a client
 */
/datum/overmap_view/proc/GetScreen()
	. = list(master, static_vision, darkness)
	. |= plane_masters
	. |= parallax_layers

/**
 * Instantiates an overmap object
 * Always use this.
 */
/datum/ovemrap_view/proc/MakeHUDObject(path)
	. = new path(src)

/datum/overmap_view/ui_static_data(mob/user)
	. = ..()
	.["map"] = screen

/datum/overmap_view/proc/Show(client/user)
	if(ismob(user))
		user = user.client
	if(!user)
		return
	user.screen |= GetScreen()
	user.images |= images
	showing |= user
	RegisterSignal(user, COMSIG_PARENT_QDELETING, .proc/RemoveClient)

/datum/overmap_view/proc/RemoveClient(client/C)
	Hide(C)

/datum/overmap_view/proc/Hide(client/user)
	if(ismob(user))
		user = user.client
	if(!user)
		return
	user.screen -= GetScreen()
	user.images -= images
	showing -= user

/datum/overmap_view/proc/AddImage(image/I)
	for(var/client/C in showing)
		C.images |= I
	images |= I

/datum/overmap_view/proc/RemoveImage(image/I)
	for(var/client/C in showing)
		C.images -= I
	images -= I

/datum/overmap_view/proc/SetViewRange(newrange)
	ASSERT(isnum(newrange) && newrange >= 0)
	if(view_range == newrange)
		return
	view_range = newrange
	Update()

/datum/overmap_view/proc/SetStaticVision(newrange)
	ASSERT(isnum(newrange) && newrange >= 0)
	if(static_vision_range == newrange)
		return
	static_vision_range = newrange
	UpdateStaticVision()
