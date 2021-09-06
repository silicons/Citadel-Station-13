/**
 * Static lighting placed in the environment
 */
/atom/movable/overmap_lighting
	icon = 'icons/overmaps/lighting.dmi'
	icon_state = "circle"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

	/// distance
	var/distance
	/// applied location
	var/turf/applied
	/// applied distance
	var/applied_dist

/atom/movable/overmap_lighting/Initialize(mapload, dist = 3)
	. = ..()
	SetRange(dist)

/atom/movable/overmap_lighting/Destroy()
	Remove()
	return ..()

/atom/movable/overmap_lighting/Moved(atom/OldLoc, Dir)
	. = ..()
	AssertLocation()

/atom/movable/overmap_lighting/proc/SetRange(newrange = 3)
	Remove()
	distance = newrange
	Apply()

/atom/movable/overmap_lighting/proc/AssertLocation()
	if(loc != applied)
		Remove()
		Apply()

/atom/movable/overmap_lighting/proc/Remove()
	if(!applied)
		return
	for(var/turf/overmap/T in range(applied, applied_dist))
		LAZYREMOVE(T.lit_by, src)
	applied = null
	applied_dist = null

/atom/movable/overmap_lighting/proc/Apply()
	if(!isturf(loc) || !(distance >= 0))
		return
	applied = loc
	applied_dist = distance
	for(var/turf/overmap/T in range(applied, distance))
		if(sqrt((T.x - x)**2 + (T.y - y)**2) > (distance * 1.49))
			continue
		LAZYADD(T.lit_by, src)
	UpdateTransform()

/atom/movable/overmap_lighting/proc/UpdateTransform()
	var/matrix/M = new
	M.Scale(applied_dist + 1, applied_dist + 1)
	transform = M
