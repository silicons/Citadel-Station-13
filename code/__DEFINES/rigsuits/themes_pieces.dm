// piece flags
/// piece inherits armor
#define RIG_PIECE_INHERITS_ARMOR			(1<<0)
/// piece inherits thermal/pressure protection
#define RIG_PIECE_INHERITS_ENVIRONMENTAL	(1<<1)
/// piece does NOT render using theme icon file for the given mob/species.
#define RIG_PIECE_STANDALONE_ICON			(1<<2)
/// piece will fit over any other clothing piece
#define RIG_PIECE_FIT_OVER_ALL				(1<<3)
/// piece will fit over any other non bulky (hardsuits, heavy armor, etc) clothing piece
#define RIG_PIECE_FIT_OVER_DEFAULT			(1<<4)
/// piece needs to be sealed to apply armor
#define RIG_PIECE_ARMOR_REQUIRES_SEAL			(1<<5)
/// piece needs to be sealed to apply environmental
#define RIG_PIECE_ENVIRONMENTAL_REQUIRES_SEAL	(1<<6)
/// piece autodpeloys during "deploy all"/quickdeploy
#define RIG_PIECE_AUTODEPLOYS					(1<<7)
/// piece becomes nodrop on deploy/requires effort to pry off
#define RIG_PIECE_RIGID							(1<<8)
