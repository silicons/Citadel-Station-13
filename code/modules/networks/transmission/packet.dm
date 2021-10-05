/**
 * A discrete piece of network data, used by packets
 *
 * WARNING: These are not read only, because I *trust* that people won't be idiots,
 * so I won't inconvenience people with immutability enforced through VAR_PRIVATE.
 * If you change a data packet, you better be doing it to a copy. Use copy() for that.
 */
/datum/network_data
	/// headers - key = value
	var/list/headers
	/// special data type header - here instead of headers - always number
	var/data_type
	/// special data service header - here instead of headers - always number
	var/service_type
	/// player-facing text render of data
	var/data_render
	/// actual data
	var/actual_data

/datum/network_data/New(datatype, service, data, list/headers, data_text)
	src.headers = headers.Copy()
	src.actual_data = data
	src.data_type = datatype
	src.service_type = service
	src.data_type = data_text

/datum/network_data/proc/set_header(key, value)
	LAZYSET(headers, key, value)

/datum/network_data/proc/get_header(key)
	return LAZYACCESS(headers, key)

/datum/network_data/proc/get_data()
	return actual_data

/datum/network_data/proc/get_text()
	return data_render || actual_data

/datum/network_data/proc/copy()
	return new /datum/network_data(data_type, service_type, actual_data, headers, data_render)

/**
 * Player facing json
 * This is useless to you as a coder as it intentionally doesn't encode, say, voices properly.
 */
/datum/network_data/proc/json()
	return json_encode(
		"head" = headers,
		"service" = service_type,
		"type" = data_type,
		"data" = get_text()
	)

/datum/network_data/proc/log_json()
	return json_encode(
		"head" = headers,
		"service" = service_type,
		"type" = data_type,
		"data" = get_data(),
		"text" = get_text()
	)

/proc/network_data_from_player_json(json)
	var/list/decoded = safe_json_decode(json)
	return new /datum/network_data(
		isnum(decoded["type"])? decoded["type"] : DATA_TYPE_INVALID,
		isnum(decoded["service"])? decoded["service"] : SERVICE_TYPE_INVALID,
		istext(decoded["data"])? decoded["data"] : null,
		islist(decoded["head"])? decoded["head"] : list()
	)

/**
 * Represents a discrete data packet to be sent
 */
/datum/network_packet
	/// real sender ID
	VAR_PRIVATE/sender_id
	/// data encapsulated
	var/datum/network_data/data

/datum/network_packet/New()
	

/datum/network_packet/proc/get_sender()
	return sender_id
