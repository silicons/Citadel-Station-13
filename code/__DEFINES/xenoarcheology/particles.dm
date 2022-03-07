// Intensities - how much an effect happens
/// Minimum particle intensity - code will not run under this
#define PARTICLE_INTENSITY_MIN				0
/// "edge" particle intensity - anything below this should be weak effects/messages only
#define PARTICLE_INTENSITY_ANNOYANCE		10
/// Nominal maximum particle intensity
#define PARTICLE_INTENSITY_MAX				100
/// Hard cap particle intensity - code will not support above this
#define PARTICLE_INTENSITY_CAP				1000

// powers - how hard it is to jam an effect. it becomes exponentially harder as anomalies increase in power,
// while good nullifying equipment will completely block out lower power anomalies
/// minimum particle power considered "dead"
#define PARTICLE_POWER_MIN			0
/// low power
#define PARTICLE_POWER_LOW			10
/// medium power
#define PARTICLE_POWER_MEDIUM		100
/// high power
#define PARTICLE_POWER_HIGH			1000
/// extreme power
#define PARTICLE_POWER_EXTREME		10000

/// falloff usually is calculated with powers directly, and intensity is going to be power / original_power
/// it's recommended to use only exp falloff
#define EXOTIC_PARTICLE_FALLOFF(power, exp, lin) max(0, (power * (1 / (1 + exp))) - power * lin)
