/**
 * overmaps area
 *
 * special snowflake moment
 */
/area/overmap
	/**
	 * overmaps don't use regular lighting
	 *
	 * we only have snowflake static lights
	 * first, the entire area is overlaid with a darkifier
	 * then, ship "passive detection" radius appears as a static light rendering ontop of it
	 * special scanbeams/whatnot can be done using static lights
	 *
	 * HOWEVER
	 * the entire area IS lit - this way we don't need to ever reset luminosity.
	 * on one hand, someone could theoretically cheat easier
	 * on the other hand if they went through that effort literally just memory hack byond 4head, not that hard :joy:
	 * i'd rather save the memory!
	 */
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	luminosity = 1
