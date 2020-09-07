local items = {}

client.set_callback = function( element, unique, callback )
    items[ unique ] = { element, callback, element:GetValue() }
end

client.unset_callback = function( unique )
    items[ unique ] = nil
end

callbacks.Register('Draw', function()
    for unique_id, item in pairs( items ) do
        local val, val2, val3, val4 = item[1]:GetValue()

        if val == nil then
            items [ unique_id ] = nil
        else
            if val ~= item[3] or val2 ~= item[4] or val3 ~= item[5] or val4 ~= item[6] then
                item[2]( item[1] )
                items[unique_id] = { item[1], item[2], val, val2, val3, val4 }
            end
        end
    end
end)


--[[
    -- Minified
    local a={}client.set_callback=function(b,c,d)a[c]={b,d,b:GetValue()}end;client.unset_callback=function(c)a[c]=nil end;callbacks.Register('Draw',function()for e,f in next,a do local g,h,i,j=f[1]:GetValue()if g==nil then a[e]=nil else if g~=f[3]or h~=f[4]or i~=f[5]or j~=f[6]then f[2](f[1])a[e]={f[1],f[2],g,h,i,j}end end end end)
]]