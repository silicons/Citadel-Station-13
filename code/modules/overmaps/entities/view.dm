
/**
 * Requests a view datum be made if not already
 */
/atom/movable/overmap_object/entity/proc/AssertViewInitialized()
	if(!view_holder)
		view_holder = new(src)

/**
 * view datums
 *
 * these are necessary to manage the view shown on overmap uis
 */
/datum/overmap_view
	/// id for screen locs
	var/screen
	/// view range
	var/view_range = 7
	/// holds plane masters
	var/list/atom/movable/overmap_hud/plane/plane_masters
	/// holds parallax
	var/list/atom/movable/overmap_hud/parallax/parallax_layers
	/// master object - holds turfs
	var/atom/movable/overmap_hud/master/master
	/// background object - goes below everything else
	var/atom/movable/overmap_hud/background/background
	/// primary lighting
	var/atom/movable/overmap_hud/light/circle/static_vision
	/// static vision range
	var/static_vision_range = 3

	/// the object we are the view for
	var/atom/movable/overmap_object/entity/object

	/// images to show to usersw
	var/list/images
	/// showing
	var/list/client/showing

/datum/overmap_view/New(atom/movable/overmap_object/entity/object)
	if(!object)
		CRASH("Invalid object")
	screen = "map_[object.id]"
	// object.AssertStaticVision()
	initialize_planes()
	initialize_parallax()
	initialize_images()
	initialize_background()
	initialize_master()
	Update()

/datum/overmap_view/Destroy()
	for(var/i in showing)
		Hide(showing)
	QDEL_NULL(master)
	QDEL_NULL(background)
	QDEL_LIST(plane_masters)
	QDEL_LIST(parallax_layers)
	object = null
	images = list()
	return ..()

/datum/overmap_view/proc/initialize_planes()
	if(islist(plane_masters))
		QDEL_LIST(plane_masters)
	plane_masters = list()
	for(var/path in subtypesof(/atom/movable/overmap_hud/plane))
		plane_masters += new path(null, src)

/datum/overmap_view/proc/initialize_parallax()
	#warn impl

/datum/overmap_view/proc/initialize_images()
	images = list()

/datum/overmap_view/proc/initialize_master()
	master = new(null, src)

/datum/overmap_view/proc/initialize_background()
	background = new(null, src)

/**
 * updates our location
 */
/datum/overmap_view/proc/Update()
	#warn impl

/**
 * Gets the screen objects to apply to a client
 */
/datum/overmap_view/proc/GetScreen()
	. = list(master, background)
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

/datum/overmap_view/proc/Show(client/user, datum/source)
	if(ismob(user))
		var/mob/M = user
		user = M.client
	if(!user)
		return
	user.screen |= GetScreen()
	user.images |= images
	LAZYINITLIST(showing[user])
	showing[user] |= source
	RegisterSignal(user, COMSIG_PARENT_QDELETING, .proc/RemoveClient)

/datum/overmap_view/proc/RemoveClient(client/C)
	showing -= C
	// we don't care about cleanup they're disconnecting

/datum/overmap_view/proc/Hide(client/user, datum/source)
	if(ismob(user))
		var/mob/M = user
		user = M.client
	if(!user)
		return
	showing[user] -= source
	if(length(showing[user]))
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
	background?.Update()
	Update()

/datum/overmap_view/proc/SetStaticVision(newrange)
	ASSERT(isnum(newrange) && newrange >= 0)
	if(static_vision_range == newrange)
		return
	static_vision_range = newrange
	// UpdateStaticVision()
