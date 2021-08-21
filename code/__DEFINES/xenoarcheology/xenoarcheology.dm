// Exotic Particles System

// Projection modes
/// Destructive, harmful, damaging
#define EXOTIC_MODE_DESTRUCTIVE			(1<<0)
/// Constructing, helpful, healing
#define EXOTIC_MODE_CONSTRUCTIVE			(1<<1)
/// Synchronizing, stabilizing, structured
#define EXOTIC_MODE_ORDERED				(1<<2)
/// Disrupting, destabilizing, chaotic
#define EXOTIC_MODE_CHAOTIC				(1<<3)
/// Dampening, interfering, nullifying
#define EXOTIC_MODE_NULLING				(1<<4)

// Projection types
/// Affect self
#define EXOTIC_PROJECT_SELF						(1<<0)
/// Affect someone by touch
#define EXOTIC_PROJECT_TOUCH					(1<<1)
/// Shoot out a beam
#define EXOTIC_PROJECT_BEAM						(1<<2)
/// Emit a field
#define EXOTIC_PROJECT_FIELD					(1<<3)
/// Directly afflict a target
#define EXOTIC_PROJECT_TARGEt					(1<<4)

// projection properties
/// stopped by airtight
#define EXOTIC_NO_AIRTIGHT						(1<<0)
/// stopped by density
#define EXOTIC_NO_DENSE							(1<<1)
	/// passes through glass regardless
	#define EXOTIC_YES_GLASS					(1<<2)
/// stopped by opaque
#define EXOTIC_NO_OPAQUE						(1<<3)
/// stopped by mobs
#define EXOTIC_NO_MOBS							(1<<4)
/// For fields, attempt to simulate a radial burst
#define EXOTIC_YES_WAVE							(1<<5)
