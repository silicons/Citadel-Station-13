/**
 * Since we want remote control to be a thing, the rig must be able to abstractly call procs for mouse/item attacks
 *
 * This file contains all wrappers for rigsuit control.
 */

/**
 * reinitializes all users
 */
/obj/item/rig/proc/rebuild_control_system()
	for(var/mob/M in users)
		set_control_flags(M, isnum(users[M])? users[M] : NONE)
		initialize_user(M)

/**
 * cleans up all users
 */
/obj/item/rig/proc/cleanup_control_system()
	for(var/mob/M in users)
		remove_user(M)
	users.Cut()

/**
 * add user
 */
/obj/item/rig/proc/add_user(mob/M, control_flags)
	RegisterSignal(M, COMSIG_PARENT_QDELETING, .proc/remove_user)
	if(isnull(control_flags))
		if(M == wearer)
			control_flags = RIG_CONTROL_FLAGS_DEFAULT
		else
			control_flags = RIG_CONTROL_FLAGS_OBSERVER
	if(M in users)
		set_control_flags(M, control_flags)
		return
	users += M
	set_control_flags(M, control_flags)
	initialize_user(M)
	SEND_SIGNAL(src, COMSIG_RIG_USER_ADD, M, control_flags)

/**
 * remove user
 */
/obj/item/rig/proc/remove_user(mob/M)
	set_control_flags(M, NONE)
	users -= M
	cleanup_user(M)
	SEND_SIGNAL(src, COMSIG_RIG_USER_DEL, M)


/**
 * set uesr control flags
 */
/obj/item/rig/proc/set_control_flags(mob/M, flags)
	if(!(M in users))
		return
	users[M] = flags
	SEND_SIGNAL(src, COMSIG_RIG_CONTROL_FLAGS_SET, M, flags)

/**
 * check user control flags for any
 */
/obj/item/rig/proc/check_control_flags(mob/M, flags)
	return users[M] & flags

/**
 * check user control flags for all
 */
/obj/item/rig/proc/check_all_control_flags(mob/M, flags)
	return (users[M] & flags) == flags

/**
 * initialize an user
 */
/obj/item/rig/proc/initialize_user(mob/M)

/**
 * cleans up an user
 */
/obj/item/rig/proc/cleanup_user(mob/M)

