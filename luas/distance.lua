local function distance3D(a, b)
	distance = vector_Distance(a, b)

	return {
		['normal'] = distance,
		['u']	   = string_format('%.0fu', distance),
		['ft']	   = string_format('%.0fft', distance*0.083333),
		['m']      = string_format('%.1fm', distance/39.370)
	}
end