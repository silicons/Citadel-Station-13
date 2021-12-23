/**
 * We manually store generator variables because generators
 * create binary objects that we can't directly read.
 */
/generator
	/// Read only
	var/_type
	/// Read only
	var/_A
	/// Read only
	var/_B
	/// Read only
	var/_rand

/generator/New(_type, _A, _B, _rand)
	. = ..()
	src._type = _type
	src._A = _A
	src._B = _B
	src._rand = _rand
	run_assertions()

#define ASSERT_NUM(var)			if(!isnum(var)) stack_trace("[#var] wasn't a number.")
#define ASSERT_VECTOR3(var)		if(!is_vector(var, 3)) stack_trace("[#var] wasn't a 3D vector.")
#define ASSERT_VECTOR2(var)		if(!is_vector(var, 2)) stack_trace("[#var] wasn't a 2D vector.")
#define ASSERT_COLOR(var)		if(!is_hexcolor(var)) stack_trace("[#var] wasn't a hexcolor.")
#define ASSERT_COLORMATRIX(var)	if(!is_colormatrix(var)) stack_trace("[#var] wasn't a color matrix.")
#define ASSERT_COLOR_ANY(var)	if(!is_hexcolor(var) && !iscolormatrix(var)) stack_trace("[#var] wasn't a hexcolor or color matrix.")

/generator/proc/run_assertions()
	if(_rand != UNIFORM_RAND && _rand != NORMAL_RAND && _rand != LINEAR_RAND && _rand != SQUARE_RAND && rand)
		stack_trace("_rand wasn't a proper define.")
	switch(_type)
		if("num")
			ASSERT_NUM(_A)
			ASSERT_NUM(_B)
		if("vector")
			ASSERT_VECTOR3(_A)
			ASSERT_VECTOR3(_B)
		if("box")
			ASSERT_VECTOR3(_A)
			ASSERT_VECTOR3(_B)
		if("color")
			ASSERT_COLOR_ANY(_A)
			ASSERT_COLOR_ANY(_B)
		if("circle")
			ASSERT_VECTOR2(_A)
			ASSERT_VECTOR2(_B)
		if("sphere")
			ASSERT_VECTOR3(_A)
			ASSERT_VECTOR3(_B)
		if("square")
			ASSERT_VECTOR2(_A)
			ASSERT_VECTOR2(_B)
		if("cube")
			ASSERT_VECTOR3(_A)
			ASSERT_VECTOR3(_B)
