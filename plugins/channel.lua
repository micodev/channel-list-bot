--[[ 
     Here you can see the settings and how the bot works please do not forget to set up the bot by adding your main-group for the re-change ads between channels 
    and to put the id of document that contain gif file about how can the user sign in with the bot  by the way there is some messages u should edit it below like ur main-channel etc and the replays . 
    *important* put same messages in line (48,108,180,477) put the main group id in line (33) put welcome message in line (275) 
    do not forget to have a copy of multi-part-post oon ur server 
    give this project star to push me to do the best. 
    for more suggestion and question please do not be lazy to chat with me here telegram.me/mico_iq . 
    just keep in mind it is beta version. 
    if u have any idea go ahead and do pull request or just fork it. 
    do not change the copy right of my own MICO . 
    shared on github on 2016/10/20 

]] 
function is_add(msg,text) 
channel = load_data("./channel_data.db") 

if not channel[tostring(msg.from.id)] then 

return false 
end 
local number = #channel[tostring(msg.from.id)] 
local var = false 
for i = 1,number do 
if channel[tostring(msg.from.id)][i].username == text then 
var  =  true 

end 
end 
var = var 

return var 
end 
main_group = config.main_group --add number of your main group 
function run(msg,matches) 
channel = load_data("./channel_data.db") 

if matches[1] == "send" and is_admin(msg) then 
channel = load_data("./channel_data.db") 

channel.time = channel.time or 0 
channel.often = channel.often or 61 
channel.time = channel.time or 0 
local time_up = 60 
if channel.time then 
time_up = channel.often - 1 or 60 
channel.often = channel.often - 1 or 60 
save_data("./channel_data.db",channel) 

 text_send = tostring(time_up):gsub("-1","") ..config.pinned_message -- put the message that u want to send it with the inline_keyboard 

print("os.time less") 
local keyboard = {} 
keyboard.inline_keyboard = {} 
for ac ,dc in pairs(channel.ids) do 
num = #channel[dc] 
for i = 1,num do 
keyboard_size = #keyboard.inline_keyboard + 1 
if channel[tostring(dc)][i].name and channel[tostring(dc)][i].username then 

keyboard.inline_keyboard[keyboard_size] = keyboard.inline_keyboard[keyboard_size] or {} 
keyboard.inline_keyboard[keyboard_size][1] = keyboard.inline_keyboard[keyboard_size][1] or {} 
keyboard.inline_keyboard[keyboard_size][1].text = channel[tostring(dc)][i].name:gsub(" ","-"):gsub("\n","-"):gsub('"',"") 
keyboard.inline_keyboard[keyboard_size][1].url = "telegram.me/"..channel[tostring(dc)][i].username:gsub(" ","_"):gsub("\n",""):gsub('"',"") 
end 
end 
end 

 for ss,fd in pairs(channel.channel_name) do 
msg_id = sendMessage("@"..ss,text_send,true,false,true,JSON:encode(keyboard)) 

if msg_id.result then 
if not channel.msg_id then 
channel.msg_id = {} 
save_data("./channel_data.db",channel) 
end 
channel.msg_id[msg_id.result.chat.username] = msg_id.result.message_id 
save_data("./channel_data.db",channel) 
end 
end 

channel.time = os.time() + 1440 * 60 
channel.often = 60 
save_data("./channel_data.db",channel) 
keyboard = {} 
keyboard.inline_keyboard = {} 

print(channel.time,os.time(),channel.often,time_up) 
return 
end 
end 
if matches[1] == "check" and is_admin(msg) then 
channel = load_data("./channel_data.db") 
if not channel.time then 
return 
end 
channel.time = channel.time or 0 
channel.often = channel.often or 61 
channel.time = channel.time or 0 
local time_up = 60 
if channel.time ~= 0  then 
time_up = channel.often - 1 or 60 
channel.often = channel.often - 1 or 60 
save_data("./channel_data.db",channel) 

 text_send = tostring(time_up):gsub("-1","") ..config.pinned_message -- put the message that u want to send it with the inline_keyboard that once to be sure no error will happens 

 sendMessage(msg.chat.id,"جاري التحقق.....") 
for k ,v in pairs(channel.ids) do 
num = #channel[v] 
local channel_delist = "" 
local channel_dem = "" 
local channel_change = "" 
local del1 = "" 
local del2 = "" 
for i = 1,num do 
local channel_username = "" 
if getChatAdministrators("@"..channel[tostring(v)][i].username) == false then 
for kv,vv in pairs(channel.channel_user) do 
if vv == tostring(v) then 
del1 = kv 
channel_username = kv 
end 
end 
for kk,vk in pairs(channel.channel_name) do 
if kk == tostring(channel_username) then 
del2 = kk 
end 
end 

save_data("./channel_data.db",channel) 
if channel[tostring(v)] and channel[tostring(v)][i] and channel.channel_name and channel.channel_name[channel[tostring(v)][i].username] and channel[tostring(v)][i].username then 
channel_delist = channel_delist.."@"..channel[tostring(v)][i].username.." الادمن: " ..channel.channel_name[ channel[tostring(v)][i].username].."\n" 
end 

channel.channel_user[del1] = nil 
channel.channel_name[del2] = nil 
channel[tostring(v)][i] = nil 
save_data("./channel_data.db",channel) 
end 
if channel[tostring(v)] and channel[tostring(v)][i] and  channel[tostring(v)][i].name ~= getChat("@"..channel[tostring(v)][i].username).result.title.." " then 
channel_change = channel_change .. "تم تغيير اسم القناه من "..channel[tostring(v)][i].name.." الى "..getChat("@"..channel[tostring(v)][i].username).result.title.."\n" 
channel[tostring(v)][i].name = getChat("@"..channel[tostring(v)][i].username).result.title.." " 
save_data("./channel_data.db",channel) 
end 
if channel[tostring(v)][i] and getChatMembersCount("@"..channel[tostring(v)][i].username) < 1000 then 
for kv,vv in pairs(channel.channel_user) do 
if vv == tostring(v) then 
channel.channel_user[kv] = nil 
channel_username = kv 
end 
end 
for kk,vk in pairs(channel.channel_name) do 
if kk == tostring(channel_username) then 
channel_dem = channel_dem.."@"..channel[tostring(v)][i].username.." - الادمن: " ..channel.channel_name[ channel[tostring(v)][i].username].."\n" 
channel.channel_name[kk] = nil 
end 
end 

channel[tostring(v)][i] = nil 
save_data("./channel_data.db",channel) 
end 
end 
if channel_change ~= "" then 
 sendMessage(main_group,channel_change) 
end 

if channel_delist ~= "" then 
sendMessage(main_group,"الرجاء ارجاع البوت ك ادمن لانه تم مسحها من اللسته يرجى الاشتراك بعد ذلك من جديد\n"..channel_delist) 
end 
if channel_dem ~= "" then 
sendMessage(main_group,"يتطلب 1000 عضو للدخول \n" ..channel_dem.."سيتم ممسحها") 
end 
end 

end 
local text_send = tostring(time_up):gsub("-1","") ..config.pinned_message -- put the message that u want to send it with the inline_keyboard this one to check the cheater that delete their messages 
if channel.time > os.time() and channel.often and tonumber(time_up) > 0 then 

local keyboard = {} 
keyboard.inline_keyboard = {} 
for ac ,dc in pairs(channel.ids) do 
num = #channel[dc] 
for i = 1,num do 
keyboard_size = #keyboard.inline_keyboard + 1 
if channel[tostring(dc)][i].name then 

keyboard.inline_keyboard[keyboard_size] = keyboard.inline_keyboard[keyboard_size] or {} 
keyboard.inline_keyboard[keyboard_size][1] = keyboard.inline_keyboard[keyboard_size][1] or {} 
keyboard.inline_keyboard[keyboard_size][1].text = channel[tostring(dc)][i].name:gsub(" ","-"):gsub("\n","-"):gsub('"',"") 
keyboard.inline_keyboard[keyboard_size][1].url = "telegram.me/"..channel[tostring(dc)][i].username:gsub(" ","_"):gsub("\n",""):gsub('"',"") 
end 
end 
end 
if channel.msg_id then 
for kd,vd in pairs(channel.msg_id) do 
keyboard = keyboard 

editMessageText("@"..kd,vd,text_send,JSON:encode(keyboard),false) 
end 
end 
if channel.msg_id then 

local keyboard = {} 
keyboard.inline_keyboard = {} 
for ac ,dc in pairs(channel.ids) do 
num = #channel[dc] 
for i = 1,num do 
keyboard_size = #keyboard.inline_keyboard + 1 
if channel[tostring(dc)][i].name then 

keyboard.inline_keyboard[keyboard_size] = keyboard.inline_keyboard[keyboard_size] or {} 
keyboard.inline_keyboard[keyboard_size][1] = keyboard.inline_keyboard[keyboard_size][1] or {} 
keyboard.inline_keyboard[keyboard_size][1].text = channel[tostring(dc)][i].name 
keyboard.inline_keyboard[keyboard_size][1].url = "telegram.me/"..channel[tostring(dc)][i].username 
end 
end 
end 
local test_fake = "" 
for kd,vd in pairs(channel.msg_id) do 
check_edit = editMessageText("@"..kd,vd,text_send,JSON:encode(keyboard),false) 
if check_edit.description and check_edit.description == "Bad Request: message not found" or check_edit.description and check_edit.description == "Bad Request: MESSAGE_ID_INVALID" then 
test_fake = test_fake .."@"..kd.."\n" 
end 

end 
if test_fake ~= "" then 
sendMessage(main_group,"هؤلاء مسحوا النشر قبل الوقت\n"..test_fake) 
test_fake = "" 
end 
end 

end 
 sendMessage(212561811,"انتهى التحقق....") 
return 
end 
if matches[1] == "users" then 
channel = load_data("./channel_data.db") 
channels = channel.channel_name 
local i = 0 
for k,v in pairs(channels) do 
i = i + 1 

end 

sendMessage(msg.chat.id,tostring(i)) 
return 
end 
if matches[1] == "commands" then 
order = [[*               🔲 قائمه الcommands 🔲              * 
🔙 للأدمن فقط :- 
----------------------------------------------- 
1⃣. /set  : لset وقت الارسال بعد يوم من الset 
2⃣. /remove (معرف قناة) :- remove الاشتراك بسبب مخالفه 
☑️ للمشتركين :- 
----------------------------------------------- 
3⃣. /deletemych : لمسح كل الاشتراكات 
4⃣. /helpme : للحصول على مساعده 
5⃣. /start : للحصول على قائمه بعمل البوت 
6⃣. /commands : لعرض الcommands 
7⃣. /mychs : للحصول على قائمه قنواتك 
⛔️ يرجى الانتباه لوجود /  في الcommands 
البوت تابع لقناه :- @Takween 
المبرمج :- @U_A_U]] 
sendMessage(msg.chat.id,order) 
return 
end 
if matches[1] == "start" and msg.chat.type == "private" or matches[1] =="##new_chat_member##" then 
help = config.welcome_message --welcome message 
sendMessage(msg.chat.id,help,true,false,true) 
return 
end 
if msg.chat.id ~= main_group then 
sendMessage(msg.chat.id,"لا يسمح لك بأستخدام البوت خارج المجموعه") 
kickChatMember(msg.chat.id,257229198) 
return 
end 
if  matches[1]:match("@%g+") then 
matches[1] = matches[1]:gsub("@","") 

if type(getChat("@"..matches[1])) == "table" and getChat("@"..matches[1]).result.type == "channel" then 
sendMessage(msg.chat.id,"ارسل الجمله التي سارسلها لك بعد هذه") 
sendMessage(msg.chat.id,getChat("@"..matches[1]).result.title.." - ".."@"..matches[1]) 
return 
end 
end 
if msg.text and not  msg.text:find("remove") and matches[1] and matches[3] and matches[3]:find("@") then 
matches[3] = matches[3]:gsub("@",""):gsub(" ","") 
matches[1] = matches[1]:gsub("\n",""):gsub("-","") 

if type(getChat("@"..matches[3])) == "boolean" or getChat("@"..matches[3]).result.type ~= "channel" then 
sendMessage(msg.chat.id,"الرجاء اضافه قناه لا شيء غير") 
return 
end 
if getChatAdministrators("@"..matches[3]) == false then 
sendMessage(msg.chat.id,"الرجاء اضاف البوت كأدمن ثم بعد ذلك اشترك") 
return 
end 
if getChatMembersCount("@"..matches[3]) < 1000 then 
sendMessage(msg.chat.id,"يتطلب 1000 عضو للدخول") 
return 
end 
if not channel[tostring(msg.from.id)] and not is_add(msg,matches[3]) or  channel[tostring(msg.from.id)] and not is_add(msg,matches[3]) then -- not is_add(msg,matches[3]) then 
if not channel.channel_user then 
channel.channel_user = channel.channel_user or {} 
save_data("./channel_data.db",channel) 
end 
if not channel.channel_name then 
channel.channel_name = channel.channel_name or {} 
save_data("./channel_data.db",channel) 
end 

channel.ids = channel.ids or {} 
ids = #channel.ids + 1 
local de = false 
for k,v in pairs(channel.ids) do 
if v == tostring(msg.from.id) then 
de = true 
end 
end 
if not de then 
channel.ids[ids] = tostring(msg.from.id) 
end 

channel.channel_name[matches[3]] = tostring(msg.from.first_name) 
channel.channel_user[tostring(matches[3])] = tostring(msg.from.id) 
channel[tostring(msg.from.id)] = channel[tostring(msg.from.id)] or {} 
num = #channel[tostring(msg.from.id)] + 1 
channel[tostring(msg.from.id)][num] = channel[tostring(msg.from.id)][num] or {} 
channel[tostring(msg.from.id)][num].name = matches[1] 
channel[tostring(msg.from.id)][num].username = matches[3] 
sendMessage(msg.chat.id,"تم اشتراكك") 
save_data("./channel_data.db",channel) 
return 
else 
sendMessage(msg.chat.id,"يوجد اشتراك مع هذه القناه") 
return 
end 
return 
end 

if matches[1] == "remove"  and is_admin(msg) then 
 matches[2] = matches[2]:gsub("@","") 

id = channel.channel_user[matches[2]] 
local channel_username = "" 
local channel_owner = "" 

for k,v in pairs(channel.channel_user) do 
if v == tostring(id) then 
 channel_username = k 
 channel.channel_user[k] = nil 
end 
end 
for kd,vd in pairs(channel.channel_name) do 

if kd == tostring(channel_username) then 
 channel_owner = channel.channel_name[matches[2]] 

 channel.channel_name[matches[2]] = nil 
end 
end 
if #channel[tostring(id)] == 1 then 
 for k,v in pairs(channel.ids) do 
if v== tostring(msg.from.id) then 
table.remove(channel.ids,k) 
end 
end 
end 
for i=1,#channel[tostring(id)] do 
if channel[tostring(id)][i].username == matches[2] then 
if channel.msg_id then 
for kl,vl in pairs(channel.msg_id) do 
 if matches[2] == kl then 
  channel.msg_id[kl] = nil 
 end 
end 
end 
channel[tostring(id)][i] = nil 
end 
end 
save_data("./channel_data.db",channel) 
sendMessage(msg.chat.id,"تم حذف قناه @"..matches[2].." للأدمن : "..channel_owner) 
return 
end 
if matches[1] ==  "mychs" then 
channel = load_data("./channel_data.db") 
if not channel[tostring(msg.from.id)] or channel[tostring(msg.from.id)] and #channel[tostring(msg.from.id)] == 0 then 
sendMessage(msg.chat.id,"لا يوجد لديك اشتراك") 
return 
end 
num = #channel[tostring(msg.from.id)] 

 local shtrak = "" 
 for i =1,num do 
  shtrak = shtrak ..i.." :-\nاسم القناة : "..channel[tostring(msg.from.id)][i].name .."\nمعرف القناة : @"..channel[tostring(msg.from.id)][i].username.."\n" 
 end 
sendMessage(msg.chat.id,shtrak) 
return 
end 
if matches[1] == "deletemych" then 
local channel_username = "" 
for k,v in pairs(channel.ids) do 
if v== tostring(msg.from.id) then 
table.remove(channel.ids,k) 
end 
end 
for k,v in pairs(channel.channel_user) do 
if v == tostring(msg.from.id) then 
 channel.channel_user[k] = nil 
channel_username = k 
end 
end 
for k,v in pairs(channel.channel_name) do 
if k == tostring(channel_username) then 
 channel.channel_name[k] = nil 
end 
end 
channel[tostring(msg.from.id)] = nil 
save_data("./channel_data.db",channel) 
sendMessage(msg.chat.id,"تم حذف كل قنواتك !") 

return 

end 
if matches[1] ==  "set" and is_admin(msg) then 
channel = load_data("./channel_data.db") 
channel.time = channel.time or 0 
channel.time = os.time() + 1440 * 60 
channel.often  = 60 
save_data("./channel_data.db",channel) 
return 
end 
if matches[1] == "helpme" then 

sendDocumentID(msg.chat.id,"BQADBQADoQUAApNvqwzXHN3_RzUsRgI","اسم القناه ثم مسافه ثم - ثم مسافه ثم  معرف القناه مع وجود @\n او ارسل معرف قناتك مع وجود @ وسوف يرسل لك البوت الطريقه") --put id of gif file or delete the function 
return 
end 
end 
function timer() 

channel = load_data("./channel_data.db") 
channel.ids = channel.ids or {} 
channel.time = channel.time or 0 
channel.often = channel.often or 61 
channel.time = channel.time or 0 
local time_up = 60 
if channel.time then 
time_up = channel.often - 1 or 60 
channel.often = channel.often - 1 or 60 
save_data("./channel_data.db",channel) 
--print(time_up) 

 text_send = tostring(time_up):gsub("-1","") ..config.pinned_message -- put the message that u want to send it with the inline_keyboard for timer 
if tonumber(channel.time) < os.time() then 
print("os.time less") 
local keyboard = {} 
keyboard.inline_keyboard = {} 
for ac ,dc in pairs(channel.ids) do 
num = #channel[dc] 
for i = 1,num do 
keyboard_size = #keyboard.inline_keyboard + 1 
if channel[tostring(dc)][i].name and channel[tostring(dc)][i].username then 

keyboard.inline_keyboard[keyboard_size] = keyboard.inline_keyboard[keyboard_size] or {} 
keyboard.inline_keyboard[keyboard_size][1] = keyboard.inline_keyboard[keyboard_size][1] or {} 
keyboard.inline_keyboard[keyboard_size][1].text = channel[tostring(dc)][i].name:gsub(" ","-"):gsub("\n","-"):gsub('"',"") 
keyboard.inline_keyboard[keyboard_size][1].url = "telegram.me/"..channel[tostring(dc)][i].username:gsub(" ","_"):gsub("\n",""):gsub('"',"") 
end 
end 
end 
channel.channel_name = channel.channel_name or {} 
 for ss,fd in pairs(channel.channel_name) do 
msg_id = sendMessage("@"..ss,text_send,true,false,true,JSON:encode(keyboard)) 

if msg_id.result then 
if not channel.msg_id then 
channel.msg_id = {} 
save_data("./channel_data.db",channel) 
end 
channel.msg_id[msg_id.result.chat.username] = msg_id.result.message_id 
save_data("./channel_data.db",channel) 
end 
end 

channel.time = os.time() + 1440 * 60 
channel.often = 60 
save_data("./channel_data.db",channel) 
keyboard = {} 
keyboard.inline_keyboard = {} 
return 
end 

print(channel.time,os.time(),channel.often,time_up) 
if channel.time > os.time() and channel.often and tonumber(time_up) == 0 then 
keyboard = keyboard 
if channel.msg_id then 
print("table") 
if#channel.msg_id ~= 0 then 
for kd,vd in pairs(channel.msg_id) do 
editMessageText("@"..kd,vd,"يمكنكم مسح الرساله \n @chlistsbot ") 
end 
end 
end 
channel.msg_id = {} 
save_data("./channel_data.db",channel) 
return 
end 

return 
end 
end 
return { 

patterns = { 
"^(.*)(%G-%G)(@.+)$", 
"^(@%g+)$", 
"^/(set)$", 
"^/() (.+)$", 
"^/(deletemych)$", 
"^/(helpme)$", 
"^(##new_chat_member##)$", 
"^/(start)$", 
"^/(users)$", 
"^/(check)$", 
"^/(commands)$", 
"^/(send)$", 
"^/(mychs)" 
}, 
run = run, 
timer = timer 
} 
