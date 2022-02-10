/**
 * Since we want remote control to be a thing, the rig must be able to abstractly call procs for mouse/item attacks
 *
 * This file contains all wrappers for rigsuit control.
 */

/**
 * reinitializes all users
 */
/obj/item/rig/proc/reload_control_system()
	for(var/mob/M in users)
		set_control_flags(i, isnum(users[i])? users[i] : NONE)
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

/**
 * remove user
 */
/obj/item/rig/proc/remove_user(mob/M)
	set_control_flags(M, NONE)
	users -= M
	cleanup_user(M)


/**
 * set uesr control flags
 */
/obj/item/rig/proc/set_control_flags(mob/M, flags)
	if(!(M in users))
		return
	users[M] = flags

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
/obj/item/rig/proc/initailize_user(mob/M)

/**
 * remove an user
 */
/obj/item/rig/proc/remove_user(mob/M)

