--[[
	Original by: yu0r
		info:
			checkbox for the menu is under Settings on the right side under DPI scale and shit

			fleshed out a post from script request thread https://aimware.net/forum/thread-89942-post-473509.html#pid473509
			seems to work best if you join the game/server and unplug your mic and plug it back in, otherwise it +voicerecords and you'll probably hear yourself or background noise when the sound plays

			make sure soundfiles are placed in  Steam/steamapps/common/Counter-Strike Global Offensive/csgo/sound/awcustom

		sounds: 
			extract zip to "\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\sound" <- put awcustom folder here
			http://www.mediafire.com/file/85bzyoaj7bxehwt/awcustom.rar/file

	Edited by: zack
--]]


local RealTime, GetLocalPlayer, Reference, Combobox, Checkbox, pairs, SetConVar, Command, GetLocalPlayerIndex, GetPlayerIndexByUserID, random = globals.RealTime, entities.GetLocalPlayer, gui.Reference, gui.Combobox, gui.Checkbox, pairs, client.SetConVar, client.Command, client.GetLocalPlayerIndex, client.GetPlayerIndexByUserID, math.random

local M_Ref1 = Reference("SETTINGS", "Miscellaneous")
local f12killsound = Checkbox(M_Ref1, "f12killsound", "F12killsound", 1)
local currentTime, timer, enabled = 0, 0, true
local snd_time = 0 -- set sound file length default f12 sound = 0.6 .

local MENU = Reference('MENU')
local show_window = Checkbox(M_Ref1, 'lua_chickenshit_show_window', 'Show Kill Say Mic Menu', true)
local window = gui.Window('lua_chickenshit_window', 'KillMic', 200, 200, 250, 575)
local gb = gui.Groupbox(window, 'Kill Say Mic Spam', 16, 16)

local lua_DidKill = Combobox( gb, "lua_DidKill", "Did Kill","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_DidHS = Combobox( gb, "lua_DidHS", "Did HeadShot","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_DidBurn = Combobox( gb, "lua_DidBurn", "Did Burn","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_DidNade = Combobox( gb, "lua_DidNade", "Did Nade","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_GotKilled = Combobox( gb, "lua_GotKilled", "Got Killed", "None","Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_GotHS = Combobox( gb, "lua_GotHS", "Got HeadShot","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_GotBurned = Combobox( gb, "lua_GotBurned", "Got Burned","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_GotNaded = Combobox( gb, "lua_GotNaded", "Got Naded","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_BurnedSelf = Combobox( gb, "lua_BurnedSelf", "Burned Self","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')
local lua_NadedSelf = Combobox( gb, "lua_NadedSelf", "Naded Self","None", "Visor Q3", "Keel Q3","Hunter Q3","Bitch WTF","Headshot CSGO","Boring","I did it","BOOM Headshot","Pew","What do you mean","MLG Horn","E-er", "I did it RNG", 'Bonk')

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
	['Bonk']			 = {'awcustom/bonk', LENGTH_HERE},
}

local dict = {
	'Visor Q3', 
	'Keel Q3', 
	'Hunter Q3', 
	'Bitch WTF', 
	'Headshot CSGO', 
	'Boring', 
	'I did it', 
	'BOOM Headshot', 
	'Pew', 
	'What do you mean', 
	'MLG Horn', 
	'E-er', 
	'I did it RNG',
	'Bonk',
}

local function handler()
	window:SetActive(show_window:GetValue() and MENU:IsActive())

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
	if val:GetValue() == 0 then
		return
	end

	SetConVar('voice_loopback', 1, true)
	SetConVar('voice_inputfromfile', 1, true)

	local sound = SOUNDS[ dict[val:GetValue()] ]
	local file = sound[1]
	snd_time = sound[2]

	if file == 'awcustom/didit' then
		file = file.. random(1, 7)
	end

	Command('play '.. file, true)
	Command('+voicerecord', true)
	timer, enabled = RealTime() + snd_time, true
end

local function on_event(e)
	if not f12killsound:GetValue() or e:GetName() ~= 'player_death' then
		return
	end

	local local_player, userid, attacker = GetLocalPlayerIndex(), e:GetInt('userid'), e:GetInt('attacker')
	local vic, att = GetPlayerIndexByUserID(userid), GetPlayerIndexByUserID(attacker)
	local weapon, headshot = e:GetString('weapon'), e:GetInt('headshot')

	if att == local_player and vic ~= local_player then
		if weapon ~= 'hegrenade' and weapon ~= 'inferno' then
			play_sound( (headshot < 1 and lua_DidKill) or (headshot > 0 and lua_DidHS) )
		elseif weapon == 'inferno' or weapon == 'hegrenade' then
			play_sound( (weapon == 'inferno' and lua_DidBurn) or (weapon == 'hegrenade' and lua_DidNade) ) 
		end

	elseif att ~= local_player and vic == local_player then
		if weapon ~= 'hegrenade' and weapon ~= 'inferno' then
			play_sound( (headshot < 1 and lua_GotKilled) or (headshot > 0 and lua_GotHS) )
		elseif weapon == 'inferno' or weapon == 'hegrenade' then
			play_sound( (weapon == 'inferno' and lua_GotBurned) or (weapon == 'hegrenade' and lua_GotNaded) ) 
		end

	elseif att == local_player and vic == local_player then
		if weapon == 'inferno' or weapon == 'hegrenade' then
			play_sound( (weapon == 'inferno' and lua_BurnedSelf) or (weapon == 'hegrenade' and lua_NadedSelf) ) 
		end
	end

end

client.AllowListener("player_death")
callbacks.Register('FireGameEvent', on_event)
callbacks.Register("Draw", handler)
