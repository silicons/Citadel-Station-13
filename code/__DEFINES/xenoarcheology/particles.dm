// Projection /supported_methods
/// Directly apply to an atom - calls Inflict()
#define PROJECTION_DIRECT			(1<<0)
/// Centered AoE - Calls Burst()
#define PROJECTION_AOE				(1<<1)
/// AoE constant ticked field - calls Field(), returns /datum/exotic_field
#define PROJECTION_FIELD			(1<<2)
/// Directional raycast - calls Raycast()
#define PROJECTION_RAYCAST			(1<<3)

// Intensities - how much effect happens
/// Minimum particle intensity - code will not run under this
#define PARTICLE_INTENSITY_MIN		0
/// Nominal maximum particle intensity
#define PARTICLE_INTENSITY_MAX		100
/// Hard cap particle intensity - code will not support above this
#define PARTICLE_INTENSITY_CAP		1000
