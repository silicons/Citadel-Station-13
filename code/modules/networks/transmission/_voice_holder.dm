/**
 * Encapsulated voice data
 */
/datum/voice_data
	/// name of speaker
	VAR_PRIVATE/voice_name = "Unknown"
	/// what they said
	VAR_PRIVATE/voice_speech = "..."
	/// language they used
	VAR_PRIVATE/datum/language/voice_language
	/// voice volume
	VAR_PRIVATE/voice_volume = VOICE_VOLUME_NORMAL
	/// list of spans - not a private var because no one will POSSIBLY screw this up right
	var/list/voice_spans

/datum/voice_data/New(name, text, volume, datum/language/language, list/spans)
	voice_name = name
	voice_speech = text
	voice_volume = volume
	voice_language = language
	voice_spans = spans && spans.Copy()

/datum/voice_data/proc/get_language()
	return voice_language

/datum/voice_data/proc/get_volume()
	return voice_volume

/datum/voice_data/proc/get_message()
	return voice_speech

/datum/voice_data/proc/get_speaker_name()
	return voice_name

/atom/movable/proc/speak_voice_data(datum/voice_data/data)
	#warn impl
