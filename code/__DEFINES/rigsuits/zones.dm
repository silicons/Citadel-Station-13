// Rig zones
#define RIG_ZONE_HEAD	"head"
#define RIG_ZONE_CHEST	"chest"
#define RIG_ZONE_L_ARM	"l_arm"
#define RIG_ZONE_R_ARM	"r_arm"
#define RIG_ZONE_L_LEG	"l_leg"
#define RIG_ZONE_R_LEG	"r_leg"

// Rig zones as flags
#define RIG_FLAG_HEAD		(1<<0)
#define RIG_FLAG_CHEST		(1<<1)
#define RIG_FLAG_L_ARM		(1<<2)
#define RIG_FLAG_R_ARM		(1<<3)
#define RIG_FLAG_ARMS		(RIG_FLAG_L_ARM | RIG_FLAG_R_ARM)
#define RIG_FLAG_L_LEG		(1<<4)
#define RIG_FLAG_R_LEG		(1<<5)
#define RIG_FLAG_LEGS		(RIG_FLAG_L_LEG | RIG_FLAG_R_LEG)
#define RIG_FLAG_FULLBODY	(RIG_FLAG_HEAD | RIG_FLAG_CHEST | RIG_FLAG_ARMS | RIG_FLAG_LEGS)
