/**
 * Represents a network device.
 */
/datum/network_interface
	/// Active network connections
	var/list/datum/network_connection/connections
	/// unique ID
	var/id
	/// next unique ID
	var/static/id_next = 0

/datum/network_interface/New()
	id = ++id_next

/datum/network_interface/Destroy()
	
	return ..()

