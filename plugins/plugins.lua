do

function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  for filename in popen('ls -a "'..directory..'"'):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end

function plugins_names( )
  local files = {}
  for k, v in pairs(scandir("plugins")) do
    -- Ends with .lua
    if (v:match(".lua$")) then
      table.insert(files, v)
    end
  end
  return files
end

function list_plugins(msg,only_enabled )

  local tt = #plugins_names( )
  local r = 0
  local text = ''
  for k, v in pairs( plugins_names( )) do

    local status = '🔴'
    plug = load_data ("plugins.db")
    -- Check if is enabled
    for k2, v2 in pairs(plug) do
      if v == v2 then
        status = '🔵'
        r = r +1
      end
    end
    if not only_enabled or status == '🔵' then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..'*'..k.."-* `"..v..'` '..status..'\n'
    end
  end
local ttr = #plugins_names( ) - r
   text = text .."`There are "..r.." plugins enabled from "..tt.." and "..ttr.." not enabled`"
  sendMessage(msg.chat.id, text,true,false,true)
end
local function dplugins(msg)
plug = load_data ("plugins.db")
while #plug ~= 0 do
table.remove(plug,#plug)
save_data("plugins.db",plug)
end
if #plug == 0 then

sendMessage(msg.chat.id,"No plugins availabe")
return
end
return
end
    local function reload_plugins( )
  plugins = {}
  load_plugins()
  return
end
function is_a(file)-- Check if file is add
  local var = false
  plug = load_data ("plugins.db")
  local i = 0
  local admins = plug
  for l = 1,#plug do
    if  plug[l] == file then
      var = true

    end
end

  return var

end
function run(msg,matches)
if not is_admin(msg) then
sendMessage(msg.chat.id,"require Admin/Developer .")
return
end
    plug = load_data("plugins.db")
if matches[1] == "add" then
      local receive = get_receiver(msg)
      local plug = load_data("plugins.db")
      local file = matches[2]..".lua"
      local pluginer = #plug

    if io.open("./plugins/"..file,"r") == nil then
     sendMessage(receive,"***no such file here.....***",true,false,true)

else

    if is_a(file) then
        sendMessage(receive,"***there is already one in same name***",true,false,true)
    end
    if not is_a(file) then
     plug[#plug+1] = file
     save_data("plugins.db", plug)
      local call = ""
           for k, v in pairs(dofile("./plugins/"..file)) do
          if k == "patterns" then
              for ka,va in pairs(v) do
                  call = call .."*"..ka.."*".." - ["..va.."]\n"
                  end
          end
    end

      sendMessage(receive,"*call me by *\n"..call.."\n*please send* [ /reload]",true,false,true)
      save_data("plugins.db", plug)
     print(#plug)

    end
  end
end

if matches[1] == "reload" then
     local receive = get_receiver(msg)
     reload_plugins(true)
     local text = ""
 for k,v in pairs(plug) do
     text = text .."`"..k.."-` *"..v.."*\n"
 end
  print(#plug)
 sendMessage(receive,text,true,false,true)
end
if matches[1] == "remplugins" then
return dplugins(msg)
end
if matches[1] == "plugins" then
return list_plugins(msg)
end
if matches[1] == "list" then
     local receive = get_receiver(msg)
local text = ""
 for k,v in pairs(plug) do
     text = text .."`"..k.."-` *"..v.."*\n"
 end
 sendMessage(receive,text,true,false,true)
end
if matches[1] == "rem" then

    local receive = get_receiver(msg)
    local file = "/plugins/"..matches[2]..".lua"
    for k, v in pairs(plug) do
if  v == matches[2]..".lua" then
table.remove(plug, k)
save_data("plugins.db",plug)
local text = ""
 for k,v in pairs(plug) do
     text = text .."`"..k.."-` *"..v.."*\n"
 end
sendMessage(receive,text,true,false,true)
end
end
end
end
return {

    patterns = {

        "/(add) (.*)",
        "/(reload)",
        "/(list)",
        "/(rem) (.*)",
        "/(remplugins)",
        "/(plugins)"
    },

    run = run
}
end
