/particles
	var/static/list/ui_vars = list(

	)
	var/static/list/generator_vars = list(

	)
	var/static/list/num_vars = list(

	)
	var/static/list/

/particles/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_PARTICLE_PANEL, "Particle Editor")

/particles/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_PARTICLE_PANEL] && check_rights(R_DEBUG))		// why debug? because people are IDIOTS
		ui_interact(usr)

/particles/ui_interact(mob/user, datum/tgui/ui)
	. = ..()w

/particles/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

/particles/ui_state(mob/user)
	return GLOB.admin_state

/particles/ui_data(mob/user)
	. = ..()

/particles/proc/ui_wrap_generator(generator/G)

/particles/proc/ui_wrap_vector2(list/L)
	return list("V2", L[1], L[2])

/particles/proc/ui_wrap_vector3(list/L)
	return list("V3", L[1], L[2], L[3])
