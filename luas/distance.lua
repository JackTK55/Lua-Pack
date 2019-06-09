local function distance3D(a, b)
	distance = vector.Distance(a, b)

	return {
		['normal'] = distance,
		['u']	   = string.format('%.0fu', distance),
		['ft']	   = string.format('%.0fft', distance*0.083333),
		['m']      = string.format('%.1fm', distance/39.370)
	}
end
