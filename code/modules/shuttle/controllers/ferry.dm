/**
 * basic point to point shuttles
 *
 * things like emergency shuttle/pods/cargo shuttle/gulag shuttle/lavaland shuttle are this!
 */
/datum/shuttle_controller/ferry
	/// state
	var/state = FERRY_STATE_IDLE
	/// home dock id - for emergency shuttle, this is centcom
	var/home_id
	/// docked state id - for emergency shuttle, this is the station
	var/docked_id
	///
