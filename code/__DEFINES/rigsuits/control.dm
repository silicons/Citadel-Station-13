// Control flags
/// Default control flags
#define RIG_CONTROL_FLAGS_DEFAULT						ALL
/// Default for observing users
#define RIG_CONTROL_FLAGS_OBSERVER				(RIG_CONTROL_UI_VIEW | RIG_CONTROL_REMOTE)

/// Can move the suit
#define RIG_CONTROL_MOVEMENT					(1<<0)
/// Can use hands
#define RIG_CONTROL_HANDS						(1<<1)
/// Can activate/deactivate the rig
#define RIG_CONTROL_ACTIVATION					(1<<2)
/// Can view UI
#define RIG_CONTROL_UI_VIEW						(1<<3)
/// Can control UI other than modules (modules is UI_MODULES)
#define RIG_CONTROL_UI_CONTROL					(1<<4)
/// Can interact with hotbinds
#define RIG_CONTROL_USE_HOTBINDS				(1<<4)
/// Can activate/configure non hotbound modules
#define RIG_CONTROL_UI_MODULES					(1<<5)
/// Can deploy/undeploy pieces
#define RIG_CONTROL_DEPLOY						(1<<6)
/// Can deploy the suit unmanned
#define RIG_CONTROL_UNMANNED_ACTIVATION			(1<<7)
/// Can modify control flags of other controllers that do not have this flag
#define RIG_CONTROL_PERMISSION_PANEL			(1<<8)
/// Can use the command line interface - someone with access to the back panel can ALWAYS do this!
#define RIG_CONTROL_DEBUG_INTERFACE				(1<<9)
/// Can set hotbinds
#define RIG_CONTROL_SET_HOTBINDS				(1<<10)
/// Can access visual remote access from anywhere!
#define RIG_CONTROL_REMOTE						(1<<11)
