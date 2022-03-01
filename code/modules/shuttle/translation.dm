// common helpers
/proc/_shuttle_bounding_box(_x, _y, _dir, width, height, dwidth, dheight)

/proc/_shuttle_bounding_turfs(list/bounding_box)

/proc/_shuttle_ordered_turfs(list/bounding_box)


	///size of covered area, perpendicular to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/width = 0
	///size of covered area, parallel to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/height = 0
	///position relative to covered area, perpendicular to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/dwidth = 0
	///position relative to covered area, parallel to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/dheight = 0

/**
 * gets area instances in us
 */
/atom/movable/shuttle/proc/GetAreas()

/**
 * Gets ordered turfs to translate from
 */
/atom/movable/shuttle/proc/GetTurfs()

/**
 * Get ordered turfs to translate to
 */
/atom/movable/shuttle/proc/GetDestinationTurfs(atom/movable/shuttle_dock/dock)

/**
 * Get an estimated list of turfs that would be affected at a destination
 */
/atom/movable/shuttle/proc/EstimateDestinationIntersection(atom/moable/shuttle_dock/dock)
	. = list()
	var/list/L1 = GetTurfs()
	var/list/L2 = GetDestinationTurfs(dock)
	for(var/i in 1 to L1.len)
		var/turf/T = L1[i]
		if(!(T.loc in areas))
			continue
		if(T.baseturfs = T.type)
			continue	// bottom of transit, we don't care
		. += L2[i]


///returns a list(x0,y0, x1,y1) where points 0 and 1 are bounding corners of the projected rectangle
/obj/docking_port/proc/return_coords(_x, _y, _dir)
	if(_dir == null)
		_dir = dir
	if(_x == null)
		_x = x
	if(_y == null)
		_y = y

	//byond's sin and cos functions are inaccurate. This is faster and perfectly accurate
	var/cos = 1
	var/sin = 0
	switch(_dir)
		if(WEST)
			cos = 0
			sin = 1
		if(SOUTH)
			cos = -1
			sin = 0
		if(EAST)
			cos = 0
			sin = -1

	return list(
		_x + (-dwidth*cos) - (-dheight*sin),
		_y + (-dwidth*sin) + (-dheight*cos),
		_x + (-dwidth+width-1)*cos - (-dheight+height-1)*sin,
		_y + (-dwidth+width-1)*sin + (-dheight+height-1)*cos
		)

///returns turfs within our projected rectangle in no particular order
/obj/docking_port/proc/return_turfs()
	var/list/L = return_coords()
	var/turf/T0 = locate(L[1],L[2],z)
	var/turf/T1 = locate(L[3],L[4],z)
	return block(T0,T1)

///returns turfs within our projected rectangle in a specific order.this ensures that turfs are copied over in the same order, regardless of any rotation
/obj/docking_port/proc/return_ordered_turfs(_x, _y, _z, _dir)
	var/cos = 1
	var/sin = 0
	switch(_dir)
		if(WEST)
			cos = 0
			sin = 1
		if(SOUTH)
			cos = -1
			sin = 0
		if(EAST)
			cos = 0
			sin = -1

	. = list()

	for(var/dx in 0 to width-1)
		var/compX = dx-dwidth
		for(var/dy in 0 to height-1)
			var/compY = dy-dheight
			// realX = _x + compX*cos - compY*sin
			// realY = _y + compY*cos - compX*sin
			// locate(realX, realY, _z)
			var/turf/T = locate(_x + compX*cos - compY*sin, _y + compY*cos + compX*sin, _z)
			.[T] = NONE
