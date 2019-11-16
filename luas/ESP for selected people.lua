local GetPlayerInfo, Reg, GetMousePos, IsButtonPressed, GetValue, get_local_player, GetByUserID, Text, Color, GetTextSize, RoundedRect, RoundedRectFill = client.GetPlayerInfo, callbacks.Register, input.GetMousePos, input.IsButtonPressed, gui.GetValue, entities.GetLocalPlayer, entities.GetByUserID, draw.Text, draw.Color, draw.GetTextSize, draw.RoundedRect, draw.RoundedRectFill

local listen = {'game_init', 'round_prestart', 'player_connect', 'player_team', 'player_changename', 'player_disconnect'}
for i=1, #listen do client.AllowListener(listen[i]) end

local Window = gui.Window('lua_custom_playerlist_window', 'Player List', 200, 200, 200, 246)

local inside_area=function(x,y,x1,y1,x2,y2) local X,Y = x > x1 and x < x2, y > y1 and y < y2 return X and Y end
local in_my_game=function(s) for a=1, 64 do local pInfo = GetPlayerInfo(a) if pInfo ~= nil then if s == pInfo['SteamID'] then return true end end end return false end

local list_of_players = {}
local function get_players()
	local lp = get_local_player()
	if lp == nil then return end
	local lpi = lp:GetIndex()
	local t = lp:GetTeamNumber()

	for i=1, 64 do
		local player_info = GetPlayerInfo(i)
		if player_info ~= nil and lpi ~= i then
			player_info['IsSelected'] = false
			player_info['Index'] = i

			local SteamID = player_info['SteamID']
			local IsBot = player_info['IsBot']
			local IsGOTV = player_info['IsGOTV']
			local ent = GetByUserID(player_info['UserID'])

			if not IsGOTV then
				if ent == nil or ent:GetTeamNumber() == nil or ent:GetTeamNumber() ~= t then
					if list_of_players[SteamID] == nil then
						list_of_players[SteamID] = player_info
					end
				end
			end
		end
	end
end

local function update_list(x, y, w, h, a)
	local mX, mY = GetMousePos()
	local y = y - 16
	local gap = 7

	for s,v in pairs(list_of_players) do
		local name = v['Name']
		local tW, tH = GetTextSize(name)
		local tWh = tW * 0.5
		gap = gap + tH + 2
		local g = y + gap
		local yMath = g - (tH*0.5)
		local hMath = g + (tH*0.5)
		local width = ( (w-x)*0.5 ) - tWh

		if inside_area(mX,mY, x,yMath,w,hMath) then
			if IsButtonPressed(1) then
				v['IsSelected'] = not v['IsSelected']
			else
				Color(GetValue('clr_gui_hover'))
				RoundedRectFill(x, yMath, w, hMath)
			end
		end

		if v['IsSelected'] then
			Color(GetValue('clr_gui_listbox_active'))
			RoundedRectFill(x+2, yMath, w-2, hMath)
		end

		Color(GetValue('clr_gui_text2'))
		Text(x+width, yMath, name)

		if not in_my_game(v['SteamID']) then
			list_of_players[s] = nil
		end
	end

	Color(GetValue('clr_gui_listbox_outline'))
	RoundedRect(x,y+12,w, (y+gap+9)+(#list_of_players*gap))
end

local Custom = gui.Custom(gui.Groupbox(Window,'Players',16,16,168,186),'lua_custom_playerlist_list',0,2,136,152,update_list)

Reg('Draw', function()
	Window:SetActive(gui.Reference('MENU'):IsActive())
	if get_local_player() == nil then
		if #list_of_players ~= 0 then
			list_of_players = {}
		end
	end
end)

Reg('DrawESP', function(b)
	local x,y,w,h = b:GetRect()
	local ent = b:GetEntity()
	local ind, hp = ent:GetIndex(), ent:GetHealth()*0.01
	local c = 255*hp
	for _,v in pairs(list_of_players) do
		if v['IsSelected'] then
			local name, i = v['Name'], v['Index']
			if ind == i then
				b:AddTextTop(name)
				RoundedRect(x,y,w,h)
				b:Color(-c,c,0,220)
				b:AddBarLeft(hp)
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