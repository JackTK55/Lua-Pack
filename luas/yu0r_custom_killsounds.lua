--[[
	Original by: yu0r
		info:
			fleshed out a post from script request thread https://aimware.net/forum/thread-89942-post-473509.html#pid473509
			seems to work best if you join the game/server and unplug your mic and plug it back in, otherwise it +voicerecords and you'll probably hear yourself or background noise when the sound plays

			make sure soundfiles are placed in  Steam/steamapps/common/Counter-Strike Global Offensive/csgo/sound/awcustom

		sounds: 
			extract zip to '\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\sound' <- put awcustom folder here
			http://www.mediafire.com/file/85bzyoaj7bxehwt/awcustom.rar/file

	Edited by: zack
		Updated to V5
--]]

local SOUNDS = {
-- 	['name']			 = {'location', length}
	['Visor Q3']		 = {'awcustom/visor', 2.8},
	['Keel Q3']			 = {'awcustom/keel', 2.2},
	['Hunter Q3']		 = {'awcustom/hunter', 2.2},
	['Bitch WTF']		 = {'awcustom/bitchwtf', 1.4},
	['Headshot CSGO']	 = {'awcustom/headshot', 0.1},
	['Boring'] 			 = {'awcustom/boring', 1.5},
	['I did it'] 		 = {'awcustom/didit1', 1.5},
	['BOOM Headshot'] 	 = {'awcustom/boom1', 1.0},
	['Pew']				 = {'awcustom/pew', 0.6},
	['What do you mean'] = {'awcustom/whatdoyoumean', 1.3},
	['MLG Horn'] 		 = {'awcustom/mlg', 2.6},
	['E-er'] 			 = {'awcustom/eer', 1.3},
	['I did it RNG'] 	 = {'awcustom/didit', 1.5},
	['Bonk']			 = {'awcustom/bonk', 1.0},
}


local RealTime, GetLocalPlayer, Combobox, Checkbox, pairs, SetConVar, Command, GetLocalPlayerIndex, GetPlayerIndexByUserID, random = globals.RealTime, entities.GetLocalPlayer, gui.Combobox, gui.Checkbox, pairs, client.SetConVar, client.Command, client.GetLocalPlayerIndex, client.GetPlayerIndexByUserID, math.random

local tab = gui.Tab(gui.Reference('Settings'), 'mic_say', 'Mic Kill Say')
local group = gui.Groupbox(tab, 'Kill Say Mic Spam', 17, 17)
local active = Checkbox(group, 'active', 'Active', false)
local currentTime, timer, enabled, snd_time, keys = 0, 0, true, 0, {}
for k in pairs(SOUNDS) do keys[#keys + 1] = k end

local menu = {
	DidKill = Combobox(group, 'Did_Kill', 'Did Kill', ''),
	DidHS = Combobox(group, 'Did_HS', 'Did Headshot', ''),
	DidBurn = Combobox(group, 'Did_Burn', 'Did Burn', ''),
	DidNade = Combobox(group, 'Did_Nade', 'Did Nade', ''),
	GotKilled = Combobox(group, 'Got_Killed', 'Got Killed', ''),
	GotHS = Combobox(group, 'Got_HS', 'Got Headshot', ''),
	GotBurned = Combobox(group, 'Got_Burned', 'Got Burned', ''),
	GotNaded = Combobox(group, 'Got_Naded', 'Got Naded', ''),
	BurnedSelf = Combobox(group, 'Burned_Self', 'Burned Self', ''),
	NadedSelf = Combobox(group, 'Naded_Self', 'Naded Self', '')
}

for k, v in pairs(menu) do
	v:SetOptions( 'None', unpack(keys) )
	v:SetWidth(133)
end
menu.GotKilled:SetPosX(149) menu.GotKilled:SetPosY(36)
menu.GotHS:SetPosX(149) menu.GotHS:SetPosY(92)
menu.GotBurned:SetPosX(149) menu.GotBurned:SetPosY(148)
menu.GotNaded:SetPosX(149) menu.GotNaded:SetPosY(204)
menu.BurnedSelf:SetPosX(298) menu.BurnedSelf:SetPosY(148)
menu.NadedSelf:SetPosX(298) menu.NadedSelf:SetPosY(204)

local function handler()
	local currentTime = RealTime()
	if currentTime >= timer then
		timer = currentTime + snd_time
		if enabled then
			SetConVar('voice_loopback', 0, true)
			SetConVar('voice_inputfromfile', 0, true)
			Command('-voicerecord', true)
			enabled = false
		end
	end
end

local function play_sound(val)
	local val2 = val and val:GetValue() or 0
	local sound = SOUNDS[ keys[val2] ]
	if not sound then
		return
	end

	local file = sound[1]
	snd_time = sound[2]

	SetConVar('voice_loopback', 1, true)
	SetConVar('voice_inputfromfile', 1, true)

	if file == 'awcustom/didit' then
		file = file.. random(1, 7)
	end

	Command('play '.. file, true)
	Command('+voicerecord', true)
	timer, enabled = RealTime() + snd_time, true
end

local tbl = { 
	inferno = {menu.DidBurn, menu.GotBurned, menu.BurnedSelf}, 
	hegrenade = {menu.DidNade, menu.GotNaded, menu.NadedSelf}, 
	[0] = {menu.DidKill, menu.GotKilled}, 
	[1] = {menu.DidHS, menu.GotHS}
}

local function on_event(e)
	if not active:GetValue() or e:GetName() ~= 'player_death' then
		return
	end

	local lp = GetLocalPlayerIndex()
	local v, a, weapon = GetPlayerIndexByUserID(e:GetInt('userid')), GetPlayerIndexByUserID(e:GetInt('attacker')), e:GetString('weapon')
	local id = (a == lp and v ~= lp and 1) or (a ~= lp and v == lp and 2) or (a == lp and v == lp and 3)

	play_sound( tbl[weapon] and tbl[weapon][id] or tbl[e:GetInt('headshot')][id] )
end

client.AllowListener('player_death')
callbacks.Register('FireGameEvent', on_event)
callbacks.Register('Draw', handler)
