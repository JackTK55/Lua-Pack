local a,b,c,d,e,f,A,B,C=client.GetPlayerIndexByUserID,client.GetLocalPlayerIndex,entities.GetLocalPlayer,table.concat,client.Command,callbacks.Register,gui.Reference,gui.Checkbox,gui.Combobox

local h = B(A("MISC","GENERAL","Main"),"msc_autobuy","AutoBuy",false)
local i = gui.Window("AB_W","AutoBuy",100,200,200,306)
local j = gui.Groupbox(i,"AutoBuy Settings",16,17)
local k = B(j,"AB_Active","Active",false)
local l = C(j,"AB_Primary_Weapons","Primary Weapons",'-',"AK | M4","Scout","SG553 | AUG","AWP","Auto")
local m = C(j,"AB_Secondary_Weapons","Secondary Weapons",'-',"Elite","P250","Tec-9 | Five-Seven","R8 | Deagle")
local n = gui.Multibox(j,'Gear')
local o = {B(n,"AB_Armor_K","Kevlar",false),B(n,"AB_Armor_KH","Helmet",false),B(n,"AB_Defuser","Defuse Kit",false),B(n,"AB_GNade","Grenade",false),B(n,"AB_MNade","Molotov",false),B(n,"AB_SNade","Smoke",false),B(n,"AB_FNade","Flashbang",false),B(n,"AB_Zeus","Zeus",false)}
local p = gui.Slider(j,'AB_buyAboveAmount','Buy if $ is Above(value*1000)',3.7,0,16)
local q,r,s = {'','buy"ak47"','buy"ssg08"','buy"sg556"','buy"awp"','buy"scar20"'},{'','buy"elite"','buy"p250"','buy"tec9"','buy"deagle"'},{'buy"vest"','buy"vesthelm"','buy"defuser"','buy"hegrenade"','buy"molotov";buy"incgrenade"','buy"smokegrenade"','buy"flashbang"','buy"taser"'}

f('Draw',function() i:SetActive(h:GetValue() and A('MENU'):IsActive()) end)

client.AllowListener('player_spawn')
f("FireGameEvent",'autobuy',function(y)
	local t, u = y:GetName(), y:GetInt("userid")
	if not k:GetValue() or c() == nil or t ~= 'player_spawn' or a(u) ~= b() then
		return
	end

	local v, x = {}, c():GetProp('m_iAccount')
	v[1], v[2] = q[l:GetValue()+1], r[m:GetValue()+1]

	for z=1,#o do
		if o[z]:GetValue()then
			v[#v+1] = s[z]
		end
	end

	local v = d(v,';')
	if x >= p:GetValue()*1000 or x < 1 then
		e(v,true)
	end
end)