-- http://www.voicerss.org/api/
local API_KEY = ''


----------- This lua is a work in progress -----------

----------- EDIT NOTHING BELOW -----------
----------- EDIT NOTHING BELOW -----------
----------- EDIT NOTHING BELOW -----------
----------- EDIT NOTHING BELOW -----------

local http = require 'gamesense/http'

local data = (function()
	local success, data = pcall( readfile, 'csgo/sound/tts/data.json' )

	if not success then
		writefile( 'csgo/sound/tts/data.json', '{}' )
	end

	return data and json.parse(data) or {}
end)()

local get_desc = function( tbl )
	local info = {}

	for index, item in next, tbl do
		info[index] = item[1]
	end

	return info
end

local random_name = function()
	local s = ''

	for i=1, 10 do
		s = s .. client.random_int(0, 9)
	end

	return s
end

local item_in_tbl = function(v, t)
	for i=1, #t do
		if v == t[i] then
			return true
		end
	end
	return false
end

local opts = {
	'Console Input (tts "msg")',
	'Game Chat Input (/tts "msg")',
	'Auto TTS Sent Team Chat ("msg")',
	'Show Saved Text-To-Speech',
	'Output Info in Console'
}

local options = ui.new_multiselect( 'misc', 'miscellaneous', 'Text-To-Speech Options:', opts )
local descriptions = get_desc( data )
local previous_sounds = ui.new_listbox( 'misc', 'miscellaneous', 'Previous Text-To-Speech', descriptions )

local play_sound_t = vtable_bind( 'vguimatsurface.dll', 'VGUI_Surface031', 82, 'void(__thiscall*)(void*, const char*)' )
local console_output = false

local function printf(endl, ...)
	return console_output and print( table.concat({...}, '') .. (endl == 1 and '\n' or '') )
end

local loop_back = 0
cvar.snd_restart:invoke_callback()
local function play_sound( file, dur )
	loop_back = cvar.voice_loopback:get_int()

	cvar.voice_inputfromfile:set_int( 1 )
	cvar.voice_loopback:set_int( 1 )
	cvar['+voicerecord']:invoke_callback()

	printf( 1, 'Playing Sound: ', file )
	play_sound_t( file )

	client.delay_call( tonumber(dur), function()
		cvar['-voicerecord']:invoke_callback()
		cvar.voice_inputfromfile:set_int( 0 )
		cvar.voice_loopback:set_int( loop_back )
	end)
end

local send_button = ui.new_button( 'misc', 'miscellaneous', 'Send Selected TTS', function()
	local sel = (ui.get(previous_sounds) or -1) + 1
	local info = data[sel]

	if not info or not info[1] then
		return
	end

	printf( 0, 'Text-To-Speech: ', info[1] )
	printf( 0, ('Sound has a duration of: %0.3f seconds!'):format(info[3]) )
	play_sound( 'tts/'.. info[2] ..'.mp3', info[3] )
end)

local remove_button = ui.new_button( 'misc', 'miscellaneous', 'Remove Selected TTS', function()
	local sel = (ui.get(previous_sounds) or -1) + 1
	local info = data[sel]

	if not info or not info[1] then
		return
	end

	table.remove( descriptions, sel )
	table.remove( data, sel )

	writefile( 'csgo/sound/tts/'.. info[2] ..'.mp3', ' ' )
	printf( 0, 'Removed: ', info[1] )

	ui.update( previous_sounds, descriptions )
	ui.set( previous_sounds, sel - 2 )
end)

local function send_request( text )
	if not text then
		return
	end

	local url = 'https://api.voicerss.org/'
	local key = API_KEY
	local lang = 'en-us'
	local voice = 'Mike'
	local start = globals.curtime()
	local file_name = random_name()

	http.get( url, {params = {key=key, lang=lang, c='mp3', f='22khz_8bit_mono', v=voice, src=text}}, function(success, response)
		if not success or response.status ~= 200 then
			printf( 1, 'ERROR: Failed to get TTS' )

			for k, v in pairs( response ) do
				printf( 0, 'ERROR: ', k, ' ', v )
			end

			return
		end

		local file_src = response.body
		local file_size = #file_src

		if file_size < 75 then
			return error( file_src, 2 )
		end

		printf( 0, ('Downloaded sound in: %0.3f seconds!'):format(globals.curtime() - start) )

		local dur = (file_size * 8) / 48000
		local dur_f = ('%0.3f'):format(dur)

		printf( nil, ('Sound has a duration of: %s seconds!'):format(dur_f) )
		writefile( 'csgo/sound/tts/'.. file_name ..'.mp3', file_src )

		descriptions[#descriptions + 1] = text
		data[#data + 1] = { text, file_name, dur_f }
		ui.update( previous_sounds, descriptions )

		play_sound( 'tts/'.. file_name ..'.mp3', dur )
	end)
end

local function on_console_input(input)
	repeat
		local tts_text = input:match( 'tts (.*)' )

		if not tts_text then
			break
		end

		printf( 0, 'Text-To-Speech: ', tts_text )
		send_request( tts_text )

		return true
	until 1
end

local function on_string_cmd(input)
	repeat
		local cmd = input.text

		local all_text = cmd:match( 'say "/tts(.*)"' )
		local team_text = cmd:match( 'say_team "/tts(.*)"' )
		local team_text_2 = auto_tts and cmd:match( 'say_team "(.*)"' )

		if not all_text and not team_text and not team_text_2 then
			break
		end

		local str = all_text or team_text or (auto_tts and team_text_2) and team_text_2
		printf( 0, 'Text-To-Speech: ', str )
		send_request( str )

		return true
	until 1
end

local callbacks = {
	[true] = client.set_event_callback,
	[false] = client.unset_event_callback
}

local function on_selection_change()
	local tbl = ui.get(options)

	local v1 = item_in_tbl( opts[1], tbl )
	local v2 = item_in_tbl( opts[2], tbl )
	auto_tts = item_in_tbl( opts[3], tbl )
	console_output = item_in_tbl( opts[5], tbl )

	callbacks[v1]( 'console_input', on_console_input )
	callbacks[v2]( 'string_cmd', on_string_cmd )

	local list = item_in_tbl( opts[4], tbl )
	ui.set_visible( previous_sounds, list )
	ui.set_visible( send_button, list )
	ui.set_visible( remove_button, list )
end

on_selection_change()
ui.set_callback( options, on_selection_change )

client.set_event_callback( 'shutdown', function()
	for i, info in next, data do
		printf( 0, i, ' = {', table.concat(info, ', '), '}' )
	end

	writefile( 'csgo/sound/tts/data.json', json.stringify(data) )
end)