local MaxClients, GetPlayerInfo, Reg, GetMousePos, IsButtonPressed, GetValue, Command, get_local_player, GetByUserID, Text, Color, GetTextSize, OutRect, RectFill = globals.MaxClients, client.GetPlayerInfo, callbacks.Register, input.GetMousePos, input.IsButtonPressed, gui.GetValue, client.Command, entities.GetLocalPlayer, entities.GetByUserID, draw.Text, draw.Color, draw.GetTextSize, draw.OutlinedRect, draw.FilledRect

local Window = gui.Window('lua_custom_playerlist_window', 'Player List', 200, 200, 200, 277)
local custom_sound = gui.Editbox(Window, 'lua_player_list_admin_notify_sound', 'custom_sound.mp3')

local listen = {'game_init', 'player_disconnect', 'player_connect', 'player_changename'}
for i=1, #listen do client.AllowListener(listen[i]) end

local inside_area=function(x,y,x1,y1,x2,y2) local X,Y = x > x1 and x < x2, y > y1 and y < y2 return X and Y end
local in_my_game=function(i) for a=1, MaxClients() do local pInfo = GetPlayerInfo(a) if pInfo ~= nil then if i == pInfo['SteamID'] then return true end end end return false end

local list_of_players = {}
local function get_players()
	local lp = get_local_player()
	if lp == nil then return end
	local lpi = lp:GetIndex()

	for i=1, MaxClients() do
		local player_info = GetPlayerInfo(i)
		if player_info ~= nil and lpi ~= i then
			player_info['IsSelected'] = false
			player_info['IsSpectatingMe'] = false

			local SteamID = player_info['SteamID']
			local IsBot = player_info['IsBot']
			local IsGOTV = player_info['IsGOTV']

			if not IsGOTV then -- if not IsGOTV and not IsBot then
				if list_of_players[SteamID] == nil then
					list_of_players[SteamID] = player_info
				end
			end
		end
	end
end

local function update_list(x, y, w, h, a)
	local mX, mY = GetMousePos()
	local y = y - 16
	local gap = 12

	for s,v in pairs(list_of_players) do
		local name = v['Name']

		local tW, tH = GetTextSize(name)
		local tWh = tW / 2
		gap = gap + tH
		local g = y + gap
		local yMath = g - (tH/2)
		local hMath = g + (tH/2)
		local width = ( (w-x)/2 ) - tWh

		if inside_area(mX,mY, x,yMath,w,hMath) then
			if IsButtonPressed(1) then
				list_of_players[s]['IsSelected'] = not v['IsSelected']
			else
				Color(GetValue('clr_gui_hover'))
				RectFill(x, yMath, w, hMath)
			end
		end

		if v['IsSelected'] then
			Color(GetValue('clr_gui_listbox_active'))
			RectFill(x+2, yMath, w-2, hMath)
		end

		Color(GetValue('clr_gui_text2'))
		Text(x+width, yMath, name)

		if not in_my_game(v['SteamID']) then
			list_of_players[s] = nil
		end
	end

	Color(GetValue('clr_gui_listbox_outline'))
	OutRect(x,y+12,w, (y+gap+13)+(#list_of_players*gap))
end

local group = gui.Groupbox(Window, 'Players', 16, 50, 168, 180)
local Custom = gui.Custom(group, 'lua_custom_playerlist_list', 0, 0, 135, 261, update_list)

Reg('Draw', function()
	Window:SetActive(gui.Reference('MENU'):IsActive())

	local local_player = get_local_player()
	if local_player == nil then
		if #list_of_players ~= 0 then list_of_players = {} end
		return
	end

	local localplayerindex = local_player:GetIndex()

	if not local_player:IsAlive() then
		return
	end

	for _,v in pairs(list_of_players) do
		if v['IsSelected'] then
			local ent = GetByUserID(v['UserID'])
			if ent ~= nil and in_my_game(v['SteamID']) then
				local ObserverTarget = ent:GetPropEntity("m_hObserverTarget")
				if ObserverTarget ~= nil then
					local TargetIndex = ObserverTarget:GetIndex()
					if TargetIndex == localplayerindex then
						if not v['IsSpectatingMe'] then
							Command('playvol '..custom_sound:GetValue()..' 1', true)
							v['IsSpectatingMe'] = true
						end
					end
				end
			end
		end
	end
end)

Reg('FireGameEvent', function(e)
	local en = e:GetName()
	for i=1,#listen do
		if listen[i] == en then
			get_players()
		end
	end
end)

get_players()