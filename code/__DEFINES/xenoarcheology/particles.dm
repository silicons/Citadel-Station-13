// Intensities - how much effect happens
/// Minimum particle intensity - code will not run under this
#define PARTICLE_INTENSITY_MIN		0
/// Nominal maximum particle intensity
#define PARTICLE_INTENSITY_MAX		200
/// Hard cap particle intensity - code will not support above this
#define PARTICLE_INTENSITY_CAP		1000

#define EXOTIC_PARTICLE_FALLOFF(power, exp, lin) max(0, (power ** exp) - power * lin)
