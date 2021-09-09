/proc/verifyIFF(theirIFF, list/validIFF)
	if (!validIFF)
		return FALSE
	if (theirIFF in validIFF)
		return TRUE

	return FALSE
