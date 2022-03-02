/**
 * Much like client view datums, perspectives are used to handle eyes/forced sight flags/etc
 */
/datum/perspective
	/// perspective the client uses while it's using this perspective
	var/forced_perspective_flags
	/// if not null, sight flags are forced to this
	var/forced_sight_flags
	/// if not null, lighting plane alpha is forced to this
	var/forced_lighting_alpha
	/// if not null, see_in_dark is forced to this
	var/forced_see_in_dark
	/// list of screen objects to add
	var/list/atom/movable/screens
	/// list of images to add
	var/list/image/images
	/// clients using
	var/list/client/attached

#warn impl

#warn the following needs to be standardized:
#warn sight setting needs to be a single update_sight proc, with potential traits, and getters for flags/see in dark
#warn client.eye should only be changed by something like mob.SetDefaultPerspective() and client.SetPerspective()
#warn mob needs a self_perspective and default_perspective
#warn refactor eyemobs to use this!
#warn mob.GetSelfPerspective(), mob.SetSelfPerspective()?

/datum/perspective/proc/GetEye()
	return

/datum/perspective/proc/GetVirtualEye()
	return

/datum/perspective/proc/UpdateEye(client/C)
	C.eye = GetEye() || C.mob
	C.virtual_eye = GetVirtualEye() || C.eye || C.mob
	C.perspective = isnull(forced_perspective_flags)? initial(C.perspective) : forced_perspective_flags

/datum/perspective/proc/UpdateSight(client/C)
	if(!isnull(forced_sight_flags))
		C.mob.sight = forced_sight_flags
	if(!isnull(forced_see_in_dark))
		C.mob.see_in_dark = forced_see_in_dark
	if(!isnull(forced_lighting_alpha))
		#warn impl

/datum/perspective/proc/UpdateMisc(client/C)

/datum/perspective/proc/UpdateAll(client/C)
	UpdateEye(C)
	UpdateSight(C)

/datum/perspective/proc/ApplyTo(client/C)
	#warn oh i need to rethink this, mob default perspective needs to apply on client, client needs to keep track of stuff, etc.
	UpdateAll(C)
	C.screen |= screens
	C.images |= images

/datum/perspective/proc/RemoveFrom(client/C)
	C.screen -= screens
	C.images -= images
	// if(src != C.mob.default_perspective)
	// 	C.mob.default_perspective.ApplyTo(C)

/datum/perspective/proc/AddScreen(atom/movable/AM)
	for(var/client/C in attached)
		C.screen |= AM
	screens |= AM

/datum/perspective/proc/RemoveScreen(atom/movable/AM)
	for(var/client/C in attached)
		C.screen -= AM
	screens -= AM

/datum/perspective/proc/AddImage(image/I)
	for(var/client/C in attached)
		C.images |= I
	images |= I

/datum/perspective/proc/RemoveImage(image/I)
	for(var/client/C in attached)
		C.images -= I
	images -= I
