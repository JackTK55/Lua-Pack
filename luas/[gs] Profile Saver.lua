local http = require 'gamesense/http'

-- https://steamcommunity.com/dev/apikey
local API_KEY = ''


----------- This lua is a work in progress -----------

----------- EDIT NOTHING BELOW -----------
----------- EDIT NOTHING BELOW -----------
----------- EDIT NOTHING BELOW -----------
----------- EDIT NOTHING BELOW -----------


local saved_profiles = (function()
	local f, profiles = pcall( readfile, 'saved_profiles.json' )

	if not f then
		writefile( 'saved_profiles.json', '{}' )
	end

	return f and json.parse(profiles) or {}
end)()


local refs = {}
local js = panorama.open()
local get_date = panorama.loadstring("return [unix => {let date = new Date(unix*1000); let d = date.toString().split(' ').slice(0,5).join(' '); return d}]")()[0]
local in_tbl = panorama.loadstring("return [(item, tbl) => (tbl.indexOf(item) != -1)]")()[0]

local function remove_items(tbl)
	for _, ref in next, tbl do
		ui.set_visible(ref, false)
	end
end

local api_key = API_KEY
local url = 'https://api.steampowered.com/ISteamUser/GetPlayerBans/v1/?key=' .. api_key
local url2 = 'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=' .. api_key
local options = {
	headers = {
		Accept='application/json', 
		['Content-Type']='application/json'
	}
}

local separator = string.rep('-', 67)
local persona_states = { [0] = 'Offline', [1] = 'Online', [2] = 'Busy', [3] = 'Away', [4] = 'Snooze', [5] = 'Looking to Trade', [6] = 'Looking to Play' }
local gen_players = nil

local saved = {}
local function update_saved()
	local to_lookup = {}
	for xuid, info in next, saved_profiles do
		if not saved[xuid] then
			saved[xuid] = {
				ui.new_label ( 'lua', 'a', 'Name: ' .. info.name ),
				ui.new_label ( 'lua', 'a', 'Profile Status: ' .. (info.status or '') ),
				ui.new_label ( 'lua', 'a', 'Vac banned: ' .. (info.vac_ban or '') ),
				ui.new_label ( 'lua', 'a', 'Game Banned: ' .. (info.game_ban or '')),
				ui.new_label ( 'lua', 'a', 'Community Banned: ' .. (info.comm_ban or '')),
				ui.new_label ( 'lua', 'a', 'Days Since Last Ban: ' .. (info.dayssince or '')),
				ui.new_label ( 'lua', 'a', 'Account Created: ' .. (info.created_on or '') ),
				ui.new_label ( 'lua', 'a', 'Saved at: ' .. info.saved_at ),

				ui.new_button( 'lua', 'a', 'Open profile in browser', function() js.SteamOverlayAPI.ShowUserProfilePage(xuid) end),
				ui.new_button( 'lua', 'a', 'Invite Player', function()
					js.FriendsListAPI.ActionInviteFriend( xuid, '' )
				end),

				ui.new_button( 'lua', 'a', 'Remove Player', function()
					remove_items( saved[xuid] )
					saved_profiles[xuid] = nil
					saved[xuid] = nil
					update_saved()
					gen_players()
				end),

				ui.new_label ( 'lua', 'a', separator ),
			}

			to_lookup[#to_lookup+1] = xuid
		end
	end

	local num = #to_lookup
	if num >= 100 then
		print( 'Too many IDs to look up! ['..num..'/100]' )
	elseif num == 0 then
		return
	end

	http.get( url .. '&steamids=' .. table.concat(to_lookup, ','), options, function(success, response)
		if not success or response.status ~= 200 then
			return
		end

		local res = json.parse(response.body)
		for _, person in next, res.players do
			local tbl = saved[ person.SteamId ]

			ui.set( tbl[3], 'VAC Bans: ' .. person.NumberOfVACBans )
			ui.set( tbl[4], 'Game Bans: ' .. person.NumberOfGameBans )
			ui.set( tbl[5], 'Community Banned: ' .. (person.CommunityBanned and 'Yes' or 'No') )
			ui.set( tbl[6], 'Days Since Last Ban: ' .. person.DaysSinceLastBan )
		end
	end)

	http.get( url2 .. '&steamids=' .. table.concat(to_lookup, ','), options, function(success, response)
		if not success or response.status ~= 200 then
			return
		end

		local res = json.parse(response.body).response
		for _, person in next, res.players do
			local tbl = saved[ person.steamid ]
			local public = person.communityvisibilitystate == 3

			ui.set( tbl[1], 'Name: ' .. person.personaname )
			ui.set( tbl[2], 'Profile Status: ' .. (public and persona_states[person.personastate] or 'Private') )
			ui.set( tbl[7], 'Account Created: ' .. (public and get_date(person.timecreated) or 'Private') )
		end
	end)
end


local hidden = true
local function on_change(self)
	if not hidden then
		return
	end

	local selected = ui.get(self)

	for xuid, info in next, saved do
		ui.set_visible( info[1], in_tbl('Name', selected) )
		ui.set_visible( info[2], in_tbl('Profile Status', selected) )
		ui.set_visible( info[3], in_tbl('Vac Bans', selected) )
		ui.set_visible( info[4], in_tbl('Game Bans', selected) )
		ui.set_visible( info[5], in_tbl('Community Banned', selected) )
		ui.set_visible( info[6], in_tbl('Days since last ban', selected) )
		ui.set_visible( info[7], in_tbl('Account Created', selected) )
		ui.set_visible( info[8], in_tbl('Saved at', selected) )

		ui.set_visible( info[9], in_tbl('Open Profile', selected) )
		ui.set_visible( info[10], in_tbl('Invite Player', selected) )
		ui.set_visible( info[11], in_tbl('Remove Player', selected) )

		ui.set_visible( info[#info], #selected > 0 )
	end
end

ui.new_label( 'lua', 'a', '----------------- Save Player Profile Settings -----------------' )
local sets = ui.new_multiselect( 'lua', 'a', 'Show Information:', {
	'Name', 'Profile Status', 'Vac Bans', 'Game Bans', 'Community Banned', 
	'Days since last ban', 'Account Created', 'Saved at', 'Open Profile', 
	'Invite Player', 'Remove Player'
})
ui.set_callback(sets, on_change)

local function visible_change()
	for _, tbl in next, saved do
		for _, ref in next, tbl do
			ui.set_visible(ref, hidden)
		end
	end

	if hidden then
		on_change(sets)
	end
end

local show_but, hide_but
local function vis_func()
	hidden = not hidden

	ui.set_visible(show_but, not hidden)
	ui.set_visible(hide_but, hidden)

	visible_change()
end

show_but = ui.new_button( 'lua', 'a', 'Show Saved Profiles', vis_func )
hide_but = ui.new_button( 'lua', 'a', 'Hide Saved Profiles', vis_func )
ui.set_visible(show_but, false)

ui.new_label( 'lua', 'a', ' ' )
local sav_lab = ui.new_label( 'lua', 'b', '------------------------  Save Player Profiles  ------------------------' )


gen_players = function()
	local ignore_ent = entity.get_local_player()

	for i=0, globals.maxplayers() do
		if i ~= ignore_ent then
			local xuid = js.GameStateAPI.GetPlayerXuidStringFromEntIndex( i )

			if xuid ~= '0' and not refs[xuid] then
				local name = js.GameStateAPI.GetPlayerName( xuid )

				refs[xuid] = {
					ui.new_label ( 'lua', 'b', 'Name: ' .. name ),
					ui.new_button( 'lua', 'b', 'Open profile in browser', function() js.SteamOverlayAPI.ShowUserProfilePage(xuid) end),
					ui.new_button( 'lua', 'b', 'Invite Player', function()
						js.FriendsListAPI.ActionInviteFriend( xuid, '' )
					end),
					ui.new_button( 'lua', 'b', 'Save Player', function()
						remove_items( refs[xuid] )

						local unix = client.unix_time()
						saved_profiles[xuid] = {
							name = name,
							status='',
							vac_ban = '',
							game_ban = '',
							comm_ban = '',
							dayssince = '',
							created_on = '',
							saved_at = get_date(unix),
						}

						update_saved()
						visible_change()
					end),
					ui.new_label ( 'lua', 'b', ' ' ),
				}
			end
		end
	end
end

gen_players()
client.set_event_callback( 'player_connect_full', gen_players )
client.set_event_callback( 'level_init', function()
	for i, tbl in next, refs do
		for key, ref in next, tbl do
			ui.set_visible(ref, hidden)
		end

		refs[i] = nil
	end
end)

update_saved()
client.set_event_callback( 'shutdown', function()
	writefile( 'saved_profiles.json', json.stringify(saved_profiles) )
end)

vis_func()