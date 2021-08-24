// overmap location types
/// planetary-like location - can dock shuttles using standard shuttle dock/variable dock system, or can 'dock' larger ships by loading in under it
#define OVERMAP_LOCATION_PLANET				0
/// ship-like location - can dock onto planets, and dock shuttles. cannot dock ships.
#define OVERMAP_LOCATION_SHIP				1
/// shuttle-like location - can dock onto others, cannot dock others to self other than shuttle interdictions
#define OVERMAP_LOCATION_SHUTTLE			2

// overmap location load status
/// this location is purely virtual
#define OVERMAP_INSTANTIATION_VIRTUAL				0
/// this location is lazy-init but hasn't initialized yet
#define OVERMAP_INSTANTIATION_NO					1
/// this location is initialized and locations can be grabbed from this
#define OVERMAP_INSTNATIATION_YES					2

// control flags for what a console can access
/// control helm/pilot
#define OVERMAP_CONTROL_HELM						(1<<0)
/// view map
#define OVERMAP_CONTROL_MAP							(1<<1)
/// control sensors
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
/// turfs
#define OVERMAP_BASE_PLANE					85
/// objects
#define OVERMAP_OBJECT_PLANE				86
/// effect renders
#define OVERMAP_EFFECT_PLANE				87
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

/// overmap unit ratio to pixel ratio - don't change this
#define OVERMAP_UNIT_PIXELS			1
/// overmap view range
#define OVERMAP_VIEW_RANGE			7
