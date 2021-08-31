// system ids
#define OVERMAP_UI_SHIELDS		"SHLD"
#define OVERMAP_UI_HELM			"HELM"
#define OVERMAP_UI_DOCKING		"DOCK"
#define OVERMAP_UI_UtILITY		"UTIL"
#define OVERMAP_UI_WEAPONS		"WEAP"
#define OVERMAP_UI_SENSORS		"SENS"
#define OVERMAP_UI_VIEW			"VIEW"

// get id for normal
#define OVERMAP_UI_KEY(str)			("[str]")
// get id for static
#define OVERMAP_UI_KEY_STATIC(str)	("[str]_s")
// inject overmap data
#define OVERMAP_DATA_INJECT(L, system, user)				L[OVERMAP_UI_KEY(system.ui_key)] = system.ui_data(user)
// inject overmap data
#define OVERMAP_STATIC_DATA_INJECT(L, system, user)			L[OVERMAP_UI_KEY_STATIC(system.ui_key)] = system.ui_static_data(user)
