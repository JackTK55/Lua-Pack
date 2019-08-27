-- csgo distance stuff
local function distance3D(a, b)
	--distance = math.sqrt( (b[1]-a[1])^2 + (b[2]-a[2])^2 + (b[3]-a[3])^2 )
	distance = vector.Distance(a, b)

	return {
		['normal'] = distance,
		['u']	   = string.format('%.0fu', distance),
		['ft']	   = string.format('%.0fft', distance*0.083333),
		['m']      = string.format('%.1fm', distance/39.370)
	}
end
