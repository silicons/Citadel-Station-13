// Data types - players CAN screw with this, however they can't sometimes always construct the data properly (for example data type voice doesn't work with text lmao)
/// none
#define DATA_TYPE_INVALID		0
/// Text - actual data is text
#define DATA_TYPE_PLAINTEXT		1
/// Number - actual data is float
#define DATA_TYPE_NUMBER		2
/// base64 - actual data is text
#define DATA_TYPE_BASE64		3
/// voice data as md5 - actual data is /datum/voice_data
#define DATA_TYPE_VOICE			4

// service types - players CAN screw with this
/// invalid service type
#define SERVICE_TYPE_INVALID		0
/// control command - accepted by most network peripherals
#define SERVICE_TYPE_COMMAND		1
/// text messages whether for IRC or for PDAs/etc
#define SERVICE_TYPE_TEXT			2
/// voice message packets for radio/etc
#define SERVICE_TYPE_VOICE			3

// header types
/// sender ID - number
#define DATA_HEADER_SENDER			"src"
/// receiver IDs - number or list of numbers
#define DATA_HEADER_TARGET			"target"

// /datum/voice_data
/// whispering - "soft" but very obviously whisper
#define VOICE_VOLUME_WHISPER		1
/// soft-overhear
#define VOICE_VOLUME_SOFT			2
/// normal talk
#define VOICE_VOLUME_NORMAL			3
/// shouting
#define VOICE_VOLUME_LOUD			4
