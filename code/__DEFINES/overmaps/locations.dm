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
