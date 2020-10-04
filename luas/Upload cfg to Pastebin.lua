local api_key = '' -- https://pastebin.com/doc_api#1

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

	-- Still doesn't work 100% correctly
	for i=1, #vars do
		local v = vars[i]
		local vs = { gui.GetValue(v) }
		local value = ''

		for a=1, #vs do
			local val = tostring( vs[a] )
			value = value .. ' ' .. ( (val == 'false' and '"Off"') or (val == 'true' and '"On"') or val )
		end

		cfg = cfg .. ( v .. value .. '\\n' )
	end

	panorama.RunScript([[
		$.AsyncWebRequest('https://pastebin.com/api/api_post.php', {
			type: 'POST',
			headers: {
				"Content-Type": 'application/x-www-form-urlencoded'
			},
			data: {
				api_option: 'paste',
				api_dev_key: ']].. api_key ..[[',
				api_paste_code: ']].. cfg ..[['
			},
			success: ( body ) => {
				var link = 'https://pastebin.com/raw/' + body.split('/')[3]
				$.Msg( link )
				SteamOverlayAPI.CopyTextToClipboard( link )
			}
		})
	]])
end)

but:SetPosX( 440 )
but:SetPosY( 364 )
but:SetWidth( 135 )
but:SetHeight( 28 )
