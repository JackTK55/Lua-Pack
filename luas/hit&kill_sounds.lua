--[[ 
	download -> https://www.mediafire.com/file/r14ygsi2iiyo59a/custom.rar/file

	make sure folder is placed in -> Steam/steamapps/common/Counter-Strike Global Offensive/csgo/sound

	should look like -> https://i.imgur.com/AVO17RS.png
]]

local dir = 'custom/'

local SOUNDS = {
-- 	['name']			 = 'location'
	['COD']			 	 = dir..'cod',
	['QBeep']			 = dir..'qbeep',
	['Windows Xp Error'] = dir..'windows xp error',
	['4'] 				 = dir..'4',
	['Bameware'] 		 = dir..'bameware',
	['Bubble'] 			 = dir..'Bubble',
	['Hammer'] 			 = dir..'hammer',
}

local Combobox, Checkbox, pairs, Command, GetLocalPlayerIndex, GetPlayerIndexByUserID = gui.Combobox, gui.Checkbox, pairs, client.Command, client.GetLocalPlayerIndex, client.GetPlayerIndexByUserID

local tab = gui.Tab(gui.Reference('Settings'), 'bruh_sounds', 'Hit/Kill Sounds')
local group = gui.Groupbox(tab, 'Kill & Hit Sounds', 17, 17)
local active = Checkbox(group, 'active', 'Active', false)
local keys = {}
for k in pairs(SOUNDS) do keys[#keys + 1] = k end

local kill_sound = Combobox(group, 'kill_sound', 'Kill Sound', 'None', unpack(keys))
local hit_sound = Combobox(group, 'hit_sound', 'Hit Sound', 'None', unpack(keys))

local function play_sound(val)
	local val = val and val:GetValue() or 0
	local sound = SOUNDS[ keys[val] ]

	if not sound then
		return
	end

	Command('playvol '.. sound.. ' 1', true)
end

local F = { player_death = kill_sound, player_hurt = hit_sound }
local function on_event(e)
	if not active:GetValue() then
		return
	end

	local event = e:GetName()
	if event ~= 'player_death' and event ~= 'player_hurt' then
		return
	end

	local lp = GetLocalPlayerIndex()
	local vic, att = GetPlayerIndexByUserID(e:GetInt('userid')), GetPlayerIndexByUserID(e:GetInt('attacker'))

	if att ~= lp or vic == lp then
		return
	end

	play_sound( F[event] )
end

client.AllowListener('player_death')
client.AllowListener('player_hurt')
callbacks.Register('FireGameEvent', on_event)
