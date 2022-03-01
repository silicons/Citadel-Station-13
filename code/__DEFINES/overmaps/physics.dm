/// steps in a tile - half the world icon size
#define OVERMAPS_TILE_STEPS			16
/// max speed in pixels per second
#define OVERMAPS_MAX_SPEED_PIXELS	64
/// max speed in units per second
#define OVERMAPS_MAX_SPEED			OVERMAPS_MAX_SPEED_PIXELS
/// speed unit in text
#define OVERMAPS_SPEED_UNIT			"Gm/h"
/// actual step x/y velocity to text speed
#define OVERMAPS_SPEED_REAL_TO_UI(s)		(s * (100 / OVERMAPS_MAX_SPEED_PIXELS))
