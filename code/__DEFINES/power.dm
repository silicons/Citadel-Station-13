#define SOLAR_TRACK_OFF 0
#define SOLAR_TRACK_TIMED 1
#define SOLAR_TRACK_AUTO 2

///conversion ratio from joules to watts
#define WATTS / 0.002
///conversion ratio from watts to joules
#define JOULES * 0.002

// cell types
/// normal power cells
#define CELL_TYPE_DEFAULT	(1<<0)
/// Rig power cells
#define CELL_TYPE_RIG		(1<<1)
