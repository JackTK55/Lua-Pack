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
	You must select a message in the list and press "Translate Selected".
	https://i.imgur.com/OCeVbTG.png
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

local list = gui.Listbox(group, 'translated', 340, '-')
	list:SetPosY(66)

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

local active = gui.Checkbox(group, 'active', 'Active', false)
	active:SetDescription('Log sent messages.') active:SetPosX(17) active:SetPosY(-2)

local from = gui.Combobox(group, 'from', 'From Language', 'Auto', unpack(keys))
	from:SetDescription('Language to translate from.') from:SetPosX(126) from:SetPosY(-2) from:SetWidth(133) from:SetHeight(38)

local to = gui.Combobox(group, 'to', 'To Language', 'Auto', unpack(keys))
	to:SetDescription('Language to translate to.') to:SetPosX(275) to:SetPosY(-2) to:SetWidth(133) to:SetHeight(38)

local function ok()
	local opts = {}

	for i=1, #messages do
		local v = messages[i]
		opts[i] = string.format('%s: %s', v[1], v[2])
	end

	list:SetOptions('-', unpack(opts))
end

local function update_list(skip, chat)
	local text = '&text='.. encode( chat and chat or messages[skip][2] )
	local to, from = langs[keys[to:GetValue()]], langs[keys[from:GetValue()]]
	local lang = to and to or 'en'

	if to and from then
		lang = from.. '-'.. to
	end

	http.Get(url..text..'&lang='..lang, function(c)
		local msg = decode(c):match('\"text":(.*)\"'):gsub('[[]"', '')
		if not chat then
			messages[skip] = { messages[skip][1], msg }
			ok()
		else
			client.ChatSay( msg )
		end
	end)
end

local custom = gui.Editbox(group, 'custom_text', '')
	custom:SetPosY(410) custom:SetWidth(500) custom:SetHeight(20) 

local send = gui.Button(group, 'Send', function() update_list(nil, custom:GetValue()) custom:SetValue('') end)
	send:SetPosY(410) send:SetPosX(504) send:SetWidth(72) send:SetHeight(20) 

local tra = gui.Button(group, 'Translate Selected', function() if list:GetValue() > 0 then update_list(list:GetValue()) end end)
	tra:SetPosX(444) tra:SetPosY(0) tra:SetHeight(50) tra:SetWidth(133)

local function main(msg)
	if not active:GetValue() then
		return
	end

	if msg:GetID() == 6 then
		if #messages == 14 then
			table.remove(messages, 1)
		end

		messages[#messages + 1] = { client.GetPlayerNameByIndex( msg:GetInt(1) ), msg:GetString(4, 1) }
		ok()
	end
end

callbacks.Register('DispatchUserMessage', main)
