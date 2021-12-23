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
/// command response from a control command
#define SERVICE_TYPE_RESPONSE		2

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

// response codes
/// timed out - receiving machinery is not pinging back
#define STATUS_CODE_TRANSMIT_FAILURE		0
/// OK - done as asked
#define STATUS_CODE_OK						1
/// Permission denied
#define STATUS_CODE_UNAUTHORIZED			2
/// timed out (but receiving machinery is active)
#define STATUS_CODE_TIMEOUT					3
/// invalid command
#define STATUS_CODE_INVALID_COMMAND			4
