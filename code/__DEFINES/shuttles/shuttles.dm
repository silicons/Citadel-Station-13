// CheckDock and CanDock values.
/// we can dock
#define SHUTTLE_CAN_DOCK					"can dock"
// things that force can't ignore
/// out of world bounds
#define SHUTTLE_FATAL_OUT_OF_WORLD			"out of bounds of world"
/// this isn't even a docking port
#define SHUTTLE_FATAL_NOT_DOCK				"not a docking port"
/// already has a shuttle docked, if we dock we would smash it
#define SHUTTLE_FATAL_COLLISION				"would collide with existing shuttle"

// things that force can ignore
/// obstructing turf
#define SHUTTLE_OBSTRUCTED_BY_TURF			"obstructed by dense wall"
/// obstructing object
#define SHUTTLE_OBSTRUCTED_BY_OBJ			"obstructed by dense object"
/// we are already docked
#define SHUTTLE_OBSTRUCTED_DOCKED			"we are already docked"
/// shuttle wouldn't fit in bounds of dock
#define SHUTTLE_OBSTRUCTED_OUT_OF_BOUNDS	"we don't fit in dock"

// shuttle_state
/// in realspace/docked somewhere on the map
#define SHUTTLE_STATE_DOCKED			"docked"
/// in dynamic transit/short jump
#define SHUTTLE_STATE_TRANSIT			"transit"
/// in long jump/in its own zlevel for overmaps
#define SHUTTLE_STATE_LONG_JUMP			"long_jump"

// /datum/shuttle_controller/standard



//shuttle mode defines
#define SHUTTLE_IDLE		"idle"
#define SHUTTLE_IGNITING	"igniting"
#define SHUTTLE_RECALL		"recall"
#define SHUTTLE_CALL		"call"
#define SHUTTLE_DOCKED		"docked"
#define SHUTTLE_STRANDED	"stranded"
#define SHUTTLE_ESCAPE		"escape"
#define SHUTTLE_ENDGAME		"endgame: game over"
#define SHUTTLE_RECHARGING		"recharging"
#define SHUTTLE_PREARRIVAL		"landing"

#define EMERGENCY_IDLE_OR_RECALLED (SSshuttle.emergency && ((SSshuttle.emergency.mode == SHUTTLE_IDLE) || (SSshuttle.emergency.mode == SHUTTLE_RECALL)))
#define EMERGENCY_ESCAPED_OR_ENDGAMED (SSshuttle.emergency && ((SSshuttle.emergency.mode == SHUTTLE_ESCAPE) || (SSshuttle.emergency.mode == SHUTTLE_ENDGAME)))
#define EMERGENCY_AT_LEAST_DOCKED (SSshuttle.emergency && SSshuttle.emergency.mode != SHUTTLE_IDLE && SSshuttle.emergency.mode != SHUTTLE_RECALL && SSshuttle.emergency.mode != SHUTTLE_CALL)

//Launching Shuttles to CentCom
#define NOLAUNCH -1
#define UNLAUNCHED 0
#define ENDGAME_LAUNCHED 1
#define EARLY_LAUNCHED 2
#define ENDGAME_TRANSIT 3

//positive value = cannot puchase
#define SHUTTLEPURCHASE_PURCHASABLE 0 //station can buy a shuttle
#define SHUTTLEPURCHASE_PURCHASED 1 //station has already bought a shuttle, so cannot
#define SHUTTLEPURCHASE_FORCED 2 //station was given a new shuttle through events or other shenanigans

// Ripples, effects that signal a shuttle's arrival
#define SHUTTLE_RIPPLE_TIME 100

#define TRANSIT_REQUEST 1
#define TRANSIT_READY 2

#define SHUTTLE_TRANSIT_BORDER 10

#define HYPERSPACE_END_TIME 5

#define HYPERSPACE_WARMUP 1
#define HYPERSPACE_LAUNCH 2
#define HYPERSPACE_END 3

#define CALL_SHUTTLE_REASON_LENGTH 12

//Engine related
#define ENGINE_COEFF_MIN 0.5
#define ENGINE_COEFF_MAX 2
#define ENGINE_DEFAULT_MAXSPEED_ENGINES 5

//Docking error flags
#define DOCKING_SUCCESS				0
#define DOCKING_BLOCKED				(1<<0)
#define DOCKING_IMMOBILIZED			(1<<1)
#define DOCKING_AREA_EMPTY			(1<<2)
#define DOCKING_NULL_DESTINATION	(1<<3)
#define DOCKING_NULL_SOURCE			(1<<4)

//Docking turf movements
#define MOVE_TURF 1
#define MOVE_AREA 2
#define MOVE_CONTENTS 4

//Rotation params
#define ROTATE_DIR 		1
#define ROTATE_SMOOTH 	2
#define ROTATE_OFFSET	4

#define SHUTTLE_DOCKER_LANDING_CLEAR 1
#define SHUTTLE_DOCKER_BLOCKED_BY_HIDDEN_PORT 2
#define SHUTTLE_DOCKER_BLOCKED 3

//Shuttle defaults
#define SHUTTLE_DEFAULT_SHUTTLE_AREA_TYPE /area/shuttle
#define SHUTTLE_DEFAULT_UNDERLYING_AREA /area/space
