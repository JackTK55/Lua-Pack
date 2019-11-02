local MaxClients, GetPlayerInfo, Reg, GetMousePos, IsButtonPressed, GetValue, Command, get_local_player, GetByUserID, Text, Color, GetTextSize, OutRect, RectFill, SetFont = globals.MaxClients, client.GetPlayerInfo, callbacks.Register, input.GetMousePos, input.IsButtonPressed, gui.GetValue, client.Command, entities.GetLocalPlayer, entities.GetByUserID, draw.Text, draw.Color, draw.GetTextSize, draw.OutlinedRect, draw.FilledRect, draw.SetFont

local font = draw.CreateFont('Tahoma', 14)
local list_of_players = {}

local Window = gui.Window('lua_player_list_admin_notify_window', 'Admin Notify', 200, 200, 200, 360)
local custom_sound = gui.Editbox(Window, 'lua_player_list_admin_notify_sound', 'custom_sound.mp3')

local table_contains=function(t,a) for i=1,#t do if t[i] == a then return true end end return false end
local inside_box=function(x,y,x1,y1,x2,y2) local X,Y = x > x1 and x < x2, y > y1 and y < y2 return X and Y end

-- https://github.com/SzymonLisowiec/node-CSGODemoReader#all-possible-events
local listen_for = {'game_init', 'player_disconnect', 'player_connect', 'player_changename'}
for i=1,#listen_for do client.AllowListener(listen_for[i]) end

local get_players = function()
	list_of_players = {}

	local local_player = get_local_player()
	if local_player == nil then return end
	local localplayerindex = local_player:GetIndex()

	for i=1, MaxClients() do
		local player_info = GetPlayerInfo(i)
		if player_info ~= nil and localplayerindex ~= i then
			player_info['IsSelected'] = false
			player_info['IsSpectatingMe'] = false
			local is_bot = player_info['isBot']
			local is_gotv = player_info['isGOTV']

			if not is_gotv then
				if not table_contains(list_of_players, i) then
					list_of_players[i] = player_info
				end
			end
		end
	end
end

local update_list = function(x, y, w, h, a)
	local mX, mY = GetMousePos()
	
	local x = x - 16
	local y = y - 16
	
	for i,v in pairs(list_of_players) do
		local player_name = v['Name']

		SetFont(font)
		local tW, tH = GetTextSize(player_name)
		local tWh = tW / 2
		local xMath = x + 16
		local g = y + (i*tH)
		local yMath = g - (tH/2)
		local hMath = g + (tH/2)
		local width = ( (w-xMath)/2 ) - tWh 

		if inside_box(mX,mY, xMath,yMath,w,hMath) then
			if IsButtonPressed(1) then
				v['IsSelected'] = not v['IsSelected']
			else
				Color(GetValue('clr_gui_hover'))
				RectFill(xMath, yMath, w, hMath)
			end
		end

		if v['IsSelected'] then
			Color(GetValue('clr_gui_listbox_active'))
			RectFill(xMath, yMath, w, hMath)
		end

		Color(GetValue('clr_gui_text2'))
		Text(xMath+width, yMath, player_name)
	end

	Color(GetValue('clr_gui_groupbox_outline'))
	OutRect(x+16,y+16,w,h-34)
end

local group = gui.Groupbox(Window, 'Players', 16, 44, 168, 204)
local Custom = gui.Custom(group, 'lua_player_list_admin_notify_custom', 0, 0, 135, 310, update_list)
local Button = gui.Button(gui.Groupbox(Window, '', 16, 250, 168, 64), 'Refresh', get_players)

Reg('Draw', function()
	Window:SetActive(gui.Reference('MENU'):IsActive())

	local local_player = get_local_player()
	if local_player == nil then
		if #list_of_players ~= 0 then
			list_of_players = {}
		end
		return
	end

	local localplayerindex = local_player:GetIndex()

	if not local_player:IsAlive() then
		return
	end

	for _,v in pairs(list_of_players) do
		if v['IsSelected'] then
			local ent = GetByUserID(v['UserID'])
			if ent ~= nil then
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
	local e_name = e:GetName()
	for i=1,#listen_for do
		if e_name == listen_for[i] then
			get_players()
		end
	end
end)

get_players()