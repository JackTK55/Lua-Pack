local str = http.Get( 'https://pastebin.com/raw/sS9AM34A' ) -- random config

local vars = {}
for line in str:gmatch('([^\n]*)\n') do
	local var = line:match('[a-z0-9.]* [^.?]')
	if var then
		vars[#vars + 1] = var:sub(0, -3)
	end
end

local but = gui.Button( gui.Reference('Settings', 'Configurations', 'Manage configurations'), 'Config to Ghostbin', function()
	local cfg = ''

	for i=1, #vars do
		local v = vars[i]
		local vs = { gui.GetValue(v) }
		local value = ''

		for a=1, #vs do
			value = value .. ' ' .. tostring( vs[a] )
		end

		cfg = cfg .. ( v .. value .. '\\n' )
	end

	panorama.RunScript([[
		$.AsyncWebRequest( 'https://ghostbin.co/paste/new', {
			type: 'POST',
			data: { "text": ']].. cfg ..[[' },
			success: ( body ) => {
				var title = body.search( '<title>' ) + 7
				var title2 = body.search( ' - Ghostbin</title>' )
				var id = body.slice( title, title2 )
				SteamOverlayAPI.CopyTextToClipboard( 'https://ghostbin.co/paste/' + id )
			}
		})
	]])
end)

but:SetPosX( 440 )
but:SetPosY( 364 )
but:SetWidth( 135 )
but:SetHeight( 28 )