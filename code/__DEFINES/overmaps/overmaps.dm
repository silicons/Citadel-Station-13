/// overmaps turf type
#define OVERMAPS_TURF_TYPE						/turf/open/overmap
/// overmaps area type
#define OVERMAPS_AREA_TYPE						/area/overmap

// control flags for what a console can access
/// control helm/pilot
#define OVERMAP_CONTROL_HELM						(1<<0)
/// view map and sensor contacts
#define OVERMAP_CONTROL_MAP							(1<<1)
/// control sensors and run ship scans
#define OVERMAP_CONTROL_SENSORS						(1<<2)
/// control weapons
#define OVERMAP_CONTROL_WEAPONS						(1<<3)
/// access docking controls
#define OVERMAP_CONTROL_DOCKING						(1<<4)
/// control engines
#define OVERMAP_CONTROL_ENGINE						(1<<5)
/// control shields
#define OVERMAP_CONTROL_SHIELDS						(1<<6)
/// control misc equipment
#define OVERMAP_CONTROL_UTILITY						(1<<7)

// overmap docking mode - determines arguments for /datum/overmap_location/proc/dock(mode, ...)
/// ship to planet - (planet - atom/movable/overmap_object)
#define OVERMAP_DOCK_SHIP_VIRTUaL					1
/// shuttle to ship/planet dock - (ship - atom/movable/overmap_object, dock - atom/movable/docking_port)
#define OVERMAP_DOCK_SHUTTLE_NORMAL					2
/// shuttle interdictions
#define OVERMAP_DOCK_SHUTTLE_INTERDICTION			3

// OVERMAP PLANES - commented out by default, example implementation

/*

/// background
#define OVERMAP_BACKGROUND_PLANE			82
/// turfs
#define OVERMAP_BASE_PLANE					83
/// parallax
#define OVERMAP_PARALLAX_PLANE				84
/// objects
#define OVERMAP_OBJECT_PLANE				85
/// effect renders
#define OVERMAP_EFFECT_PLANE				86
/// Lighting
#define OVERMAP_LIGHTING_PLANE				87
/// sensors
#define OVERMAP_SENSOR_PLANE				88
/// master
#define OVERMAP_RENDER_PLANE				89
*/

// OVERMAP LAYERS - commented out by default, example implementation

/*
/// planets
#define OVERMAP_LAYER_DESTINATION				1
/// hazard
#define OVERMAP_LAYER_HAZARD					1.5
/// ships
#define OVERMAP_LAYER_SHIP						2
/// shuttles
#define OVERMAP_LAYER_SHUTTLE					3
/// combat
#define OVERMAP_LAYER_WEAPONS					3.5
/// effects
#define OVERMAP_LAYER_EFFECTS					4
*/

/// overmap view range
#define OVERMAPS_VIEW_RANGE			7

// helpers
/// quantize velocity
#define OVERMAPS_QUANTIZE_VELOCITY(val)			(round(val, 0.001))

// IFFS
/// NT Faction
#define OVERMAP_IFF_NT "nt"
/// Syndies
#define OVERMAP_IFF_SYNDIE "syndicate"
/// wizard federation
#define OVERMAP_IFF_WIZARD "wizard"
/// unknown
#define OVERMAP_IFF_UNKNOWN "unknown"
