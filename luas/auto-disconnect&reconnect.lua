if not client.delay_call then
	local a,b,c,d,e=table.insert,common.Time,coroutine.create,coroutine.resume,{}client.delay_call=function(g,h,i)a(e,{delay=b()+g,func=i and i or c(h)})end;callbacks.Register('Draw','Function caller for delay_call',function()local j=b()for k,l in next,e do if j>=l.delay then if type(l.func)=='function'then l.func()else d(l.func)end;e[k]=nil end end end)
end

local eval, exec, delay_call = panorama.RunScript, client.Command, client.delay_call
local ref = gui.Reference('Settings', 'Advanced')
local enable = gui.Checkbox(ref, 'dis_join_enable', 'Auto - Disconnect/ Reconnect', 0)
local dis_delay = gui.Slider(ref, 'dis_slide', 'Disconnect Delay', 15, 0, 30)
local join_delay = gui.Slider(ref, 'join_slide', 'Reconnect Delay', 15, 0, 30)

local function on_event(e)
	if not enable:GetValue() then
		return
	end

	if e:GetName() ~= 'round_start' then
		return
	end

    local dis = dis_delay:GetValue()
    local new_time = dis + join_delay:GetValue()

    delay_call(dis, '', function()
		exec('disconnect')
	end)

    delay_call(new_time, '', function()
        eval("CompetitiveMatchAPI.ActionReconnectToOngoingMatch('', '', '', '')")
    end)
end

client.AllowListener('round_start')
callbacks.Register('FireGameEvent', on_event)
