/**
 * File contains debug procs for ui
 */

/atom/movable/overmap_object/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OvermapObjectStandalone")
	view_holder.Show(user, src)

/atom/movable/overmap_object/ui_close(mob/user)
	. = ..()
	view_holder.Hide(user, src)

/atom/movable/overmap_object/ui_static_data(mob/user)
	. = ..()
	.[OVERMAP_UI_VIEW] = view_holder.ui_static_data(user)
