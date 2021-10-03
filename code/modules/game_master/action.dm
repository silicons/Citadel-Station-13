/**
 * A single action the GM can perform
 *
 * These should only be hard-referenced by the gamemaster itself, and processes it spawns. Everything else should use IDs.
 *
 * Config section: "actions"
 */
/datum/gm_action
	/// abstract type
	var/abstract_type = /datum/gm_action
	/// name
	var/name = "Action"
	/// desc
	var/desc = "A broken action. Contact coders."
	/// unique ID
	var/id
	/// are we going to spawn a process
	var/will_process = FALSE
	/// are we going to telegraph
	var/will_telegraph = FALSE
	/// default telegraph delay
	var/default_telegraph_delay = 0

/datum/gm_action/New()
	if(!id)
		id = "[type]"

/datum/gm_action/Destroy()

	return ..()

/**
 * called to telegraph
 *
 * include a data list for stateful events
 */
/datum/gm_action/proc/telegraph(list/data)



/**
 * Process holder for GM actions, for those that require ticking.
 */
/datum/gm_process
	/// name
	var/name = "Ticking Process"
	/// UID next
	var/static/id_next = 0
	//// id - number
	var/id

	// running vars - managed by gamemaster
	/// backreference to action that spawned it
	var/datum/gm_action/parent
	/// generic blackboard for state information
	var/list/blackboard
	/// start has been called
	var/started = FALSE

	// running vars - modified by caller
	/// delay start by this much
	var/delay_start = 0
	/// delay end by this much (after process kill is reached)
	var/delay_end = 0

/datum/gm_process/New(list/data)
	id = ++id_next
	blackboard = data || list()

/**
 * Called on action begin
 */
/datum/gm_process/proc/start()

/datum/gm_process/process()
	return PROCESS_KILL

/**
 * Called on process kill
 */
/datum/gm_process/proc/end()
