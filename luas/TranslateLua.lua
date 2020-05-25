--[[
	How to use:
		Go to: https://passport.yandex.com/
		if you don't have an account, create one.
		After that go to: https://translate.yandex.com/developers/keys
		Click: https://i.imgur.com/hT36B17.png [Create a new key]
		Once you've done that click: https://i.imgur.com/0TGozfg.png
		After you've done that, paste the key into
			local api_key = ''
		
		So it should look like:
			https://i.imgur.com/giMswWQ.png
	Found in:
		Misc -> Translator

	To avoid translating literally every message that gets logged, 
	You must click on a message in the list for it to translate.
--]]
local api_key = ''

------------------------------------
-----------	IGNORE BELOW -----------
------------------------------------

if api_key=='' then return error('api_key is empty.')end
local url = 'https://translate.yandex.net/api/v1.5/tr.json/translate?key='..api_key

local cth = function(c)return string.format("%%%02X",c:byte()or'')end
local htc = function(x)return tonumber(x,16):char()end
local encode = function(u)return u:gsub("\n","\r\n"):gsub("([^%w ])",cth):gsub(" ","+")end
local decode = function(u)return u:gsub("+"," "):gsub("%%(%x%x)",htc)end

local MENU = gui.Reference('MENU')
local tab = gui.Tab(gui.Reference('Misc'), 'translator', 'Translator')
local group = gui.Groupbox(tab, 'Translator', 16, 16)

local file_exists = function(n)local e file.Enumerate(function(c)if c==n then e=1 return end end)return e end
local function download_file(name)http.Get('https://raw.githubusercontent.com/Zack2kl/Lua-Pack/master/luas/'..name,function(c)local f=file.Open(name,'w')f:Write(c)f:Close()end)end

local langs, keys = {}, {}
local messages = {}

local languages = file_exists('languages.txt')
if not languages then
	download_file('languages.txt')
end

if languages then
	local f = file.Open('languages.txt', 'r')

	for line in f:Read():gmatch('([^\n]*)\n') do
		langs[ line:match('([^\n]*)=') ] = line:gsub('([^\n]*)=', '')
		keys[#keys + 1] = line:match('([^\n]*)=')
	end

	f:Close()
end

if #keys == 0 then gui.Text(group, 'If you see this message,  reload the lua.') return end

local space = ''
for i=1, 112 do
	space = space..'-'
end

local list = gui.Listbox(group, 'messages', 338, space)
	list:SetPosY(66)

local from = gui.Combobox(group, 'from', 'From Language', 'Auto', unpack(keys))
	from:SetDescription('Language to translate from.') from:SetPosY(-2) from:SetWidth(133) from:SetHeight(38)

local to = gui.Combobox(group, 'to', 'To Language', 'Auto', unpack(keys))
	to:SetDescription('Language to translate to.') to:SetPosX(149) to:SetPosY(-2) to:SetWidth(133) to:SetHeight(38)

local function ok()
	local opts = {}

	for i = 1, #messages do
		local v = messages[i]
		opts[1 + (#messages - i) ] = string.format('%s: %s', v[1], v[2])
		print(i, 1 + (#messages - i))
	end

	list:SetOptions(space, unpack(opts))
	list:SetValue(0)
end

local function update_list(a)
	local text = '&text='.. encode( type(a) == 'number' and (messages[a][2]) or a )
	local to, from = langs[keys[to:GetValue()]], langs[keys[from:GetValue()]]
	local lang = to and to or 'en'

	if to and from then
		lang = from.. '-'.. to
	end

	http.Get(url..text..'&lang='..lang, function(c)
		local msg = decode(c):match('\"text":(.*)\"'):gsub('[[]"', '')
		if type(a) == 'number' then
			messages[a][2] = msg
			ok()
		else
			client.ChatSay( msg )
		end
	end)
end

local custom = gui.Editbox(group, 'custom_text', '')
	custom:SetPosX(298) custom:SetPosY(30) custom:SetWidth(200) custom:SetHeight(20)

local send = gui.Button(group, 'Send', function() if custom:GetValue() ~= '' then update_list(custom:GetValue()) end custom:SetValue('') end)
	send:SetPosX(504) send:SetPosY(30) send:SetWidth(72) send:SetHeight(20) 

local clear = gui.Button(group, 'Clear Messages', function() messages = {} ok() end)
	clear:SetPosY(412) clear:SetWidth(576) clear:SetHeight(20)

local last_val
callbacks.Register('Draw', function()
	local val = list:GetValue()
	if last_val ~= val then
		if val > 0 then
			update_list(1 + (#messages - val))
		end
		last_val = val
	end
end)

local function main(msg)
	if msg:GetID() == 6 then
		messages[#messages + 1] = { client.GetPlayerNameByIndex( msg:GetInt(1) ), msg:GetString(4, 1) }
		ok()
	end
end

callbacks.Register('DispatchUserMessage', main)
