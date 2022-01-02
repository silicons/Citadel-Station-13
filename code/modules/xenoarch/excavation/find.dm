/datum/component/archeology

/datum/component/archeology/Initialize()
	if(!isturf(parent))
		return COMPONENT_INCOMPATIBLE
	if((. = ..()) == COMPONENT_INCOMPATIBLE)
		return

