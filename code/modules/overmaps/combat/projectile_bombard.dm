/**
 * master proc - do orbital bombardment
 *
 * the alternate to [projectile_onmap.dm] projectile objects simulating an actual strike
 * intended for planetary surfaces where cardinal/angular directions don't make much sense
 * picks a spot biased at a certain xo/yo to perform standard impact calculations at
 *
 * this should only be called post impact/after shield checks/hits are done.
 */
/atom/movable/overmap_object/projectile/proc/Bombard(atom/movable/overmap_object/O, x_bias = 0, y_bias = 0, dispersion = max(world.maxx, world.maxy))
	// assert that there's a location to hit
	if(!O.location)
		return FALSE
	// calculate distance to ground
	var/dist_to_ground = O
