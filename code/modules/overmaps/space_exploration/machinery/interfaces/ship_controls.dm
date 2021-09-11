/**
 * Control consoles
 */
/obj/machinery/ship/interface/console
	name = "dumb catboy didnt name the console"
	desc = "hah gottem!"

/obj/machinery/ship/interface/console/sensor
	name = "Sensor Console"
	desc = "Console used for ship navigation operations."
	// Stuff needed to render the map
	var/map_name
	var/atom/movable/screen/map_view/cam_screen
	/// All the plane masters that need to be applied.
	var/list/cam_plane_masters
	/// Background SFX
	var/atom/movable/screen/background/cam_background
	/// the actual radar.
	var/obj/machinery/ship/device/radar/radar_machinery
	/// last turf
	var/turf/last_camera_turf

/obj/machinery/ship/interface/console/sensor/Initialize(mapload)
	. = ..()
	// Map name has to start and end with an A-Z character,
	// and definitely NOT with a square bracket or even a number.
	// I wasted 6 hours on this. :agony:
	map_name = "camera_console_[REF(src)]_map"
	// Initialize map objects
	cam_screen = new
	cam_screen.name = "screen"
	cam_screen.assigned_map = map_name
	cam_screen.del_on_map_removal = FALSE
	cam_screen.screen_loc = "[map_name]:1,1"
	cam_plane_masters = list()
	// TODO: map layer tomfoolery.
	for(var/plane in subtypesof(/atom/movable/screen/plane_master))
		var/atom/movable/screen/instance = new plane()
		instance.assigned_map = map_name
		instance.del_on_map_removal = FALSE
		instance.screen_loc = "[map_name]:CENTER"
		cam_plane_masters += instance
	cam_background = new
	cam_background.assigned_map = map_name
	cam_background.del_on_map_removal = FALSE

/obj/machinery/ship/interface/console/sensor/Destroy()
	qdel(cam_screen)
	QDEL_LIST(cam_plane_masters)
	qdel(cam_background)
	return ..()

/obj/machinery/ship/interface/console/sensor/ui_interact(mob/user, datum/tgui/ui)
	// Update UI
	ui = SStgui.try_update_ui(user, src, ui)

	// Update the camera, showing static if necessary and updating data if the location has moved.
	update_active_camera_screen()

	if(!ui)
		// Register map objects
		user.client.register_map_obj(cam_screen)
		for(var/plane in cam_plane_masters)
			user.client.register_map_obj(plane)
		user.client.register_map_obj(cam_background)
		// Open UI
		ui = new(user, src, "CameraConsole", name)
		ui.open()

/obj/machinery/ship/interface/console/sensor/proc/updateScreen()
	/// todo: bug kev to move ship into /machinery/ship/ instead of /machinery/ship/device
	var/rloc = radar_machinery.ship.parent.loc
	var/newturf = get_turf(rloc)
	if(last_camera_turf == newturf)
		return

	// Cameras that get here are moving, and are likely attached to some moving atom such as cyborgs.
	last_camera_turf = get_turf(rloc)

	var/list/visible_things = view(radar_machinery.range, rloc)
	var/list/visible_turfs = list()

	for(var/turf/visible_turf in visible_things)
		visible_turfs += visible_turf

	var/list/bbox = get_bbox_of_atoms(visible_turfs)
	var/size_x = bbox[3] - bbox[1] + 1
	var/size_y = bbox[4] - bbox[2] + 1

	cam_screen.vis_contents = visible_turfs
	cam_background.icon_state = "clear"
	cam_background.fill_rect(1, 1, size_x, size_y)
