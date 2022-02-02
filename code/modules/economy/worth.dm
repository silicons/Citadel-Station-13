/atom/proc/get_economic_data()
	return list(
		ECONOMIC_DATA_WORTH = get_economic_worth(),
		ECONOMIC_DATA_TYPES = get_economic_types(),
	)

/atom/proc/get_economic_worth()
	return list(
		ECONOMIC_WORTH_RAW_MATERIAL = get_raw_material_worth(),
		EOCNOMIC_WORTH_RAW_REAGENTS = get_raw_reagents_worth(),
		ECONOMIC_WORTH_TRADE_VALUE = get_trade_value()
	)

/atom/proc/get_economic_types()
	return NONE

/atom/proc/get_raw_material_worth()
	#warn impl

/atom/proc/get_raw_reagents_worth()
	#warn impl

/atom/proc/get_trade_value()
	return 0
