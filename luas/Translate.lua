local url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
local api_key = '' -- put your api key here
if api_key=='' then return error('api_key is empty.')end
local translate_url = url..'?key='..api_key

local format, pairs, concat, sort, ChatSay, Get, byte, tonumber, char, gsub, Command, gmatch, Text = string.format, pairs, table.concat, table.sort, client.ChatSay, http.Get, string.byte, tonumber, string.char, string.gsub, client.Command, string.gmatch, gui.Text
local get_languages=function(l)local list,N={},1 for f,a in pairs(l)do list[N],N=format('%s -> %s',f,a),N+1 end sort(list)return list end
local cth = function(c)return format("%%%02X",c:byte())end
local htc = function(x)return tonumber(x,16):char()end
local encode = function(u)return u:gsub("\n","\r\n"):gsub("([^%w ])",cth):gsub(" ","+")end
local decode = function(u)return u:gsub("+"," "):gsub("%%(%x%x)",htc)end

local menu_open, MENU = true, gui.Reference('MENU')
local w=gui.Window('lan_wm', 'Translation', 100, 100, 400, 405)
local g=gui.Groupbox(w,'Console Commands',15,15,185,125)Text(g,'-languages')Text(g,'-translate [from] [to] [text]')Text(g,'example:')Text(g,'-translate en ru Hello')
local g2,g3=gui.Groupbox(w,'Languages',215,15,170,345),gui.Groupbox(w,'Translate',15,150,185,210)
Text(g3,'From')local _FROM=gui.Editbox(g3,'translate_from','')Text(g3,'To')local _TO=gui.Editbox(g3,'translate_to','')Text(g3,'Text')local _TEXT=gui.Editbox(g3,'translate_text','')

local LANGUAGES = {}
Get('https://pastebin.com/raw/rzXDicve', function(cnt)
	local _lines = {}

	for line in cnt:gmatch('([^\n]*)\n') do
		_lines[#_lines + 1] = line
	end

	for i=1, #_lines do
		local words = {}

		for str in _lines[i]:gmatch('([^=]*)') do
			words[#words + 1] = str
		end

		LANGUAGES[ words[1] ] = words[2]
	end

	local lang = get_languages(LANGUAGES)
	for i=1, #lang do
		Text(g2, lang[i])
	end
end)

local get_translation = function(from, to, text)
	local text = '&text='.. encode(text)
	local from_to = '&lang='..from..'-'..to

	Get(translate_url.. text.. from_to, function(cnt)
		local txt = decode(cnt)
		local text = txt:match('\"text":(.*)\"'):gsub('[[]"','')
		ChatSay(text)
	end)
end

gui.Button(g3,'Say in Chat',function()
	get_translation( _FROM:GetValue(), _TO:GetValue(), _TEXT:GetValue() )
end)

local function OnSendStringCmd(CMD)
	local cmd = CMD:Get()

	if cmd:find('-languages') then
		local langs = get_languages(LANGUAGES)

		for i=1, #langs do
			print(langs[i])
		end

		return CMD:Set('Output_in_Aimware_Console.')
	end

	if cmd:sub(1, 10) == '-translate' then
		get_translation(cmd:sub(12, 13), cmd:sub(15, 16), cmd:sub(18))
		CMD:Set('')
	end
end

callbacks.Register('SendStringCmd', OnSendStringCmd)

gui.Button(gui.Reference('SETTINGS','Miscellaneous'),'Show/Hide Translation Window',function()menu_open=not menu_open end)
callbacks.Register('Draw', function()w:SetActive(menu_open and MENU:IsActive())end)