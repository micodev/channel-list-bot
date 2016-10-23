package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'
URL = require('socket.url')
JSON = (loadfile "./dkjson.lua")()
HTTP = require("socket.http")
HTTPS = require('ssl.https')
HTTPU = require("socket.http")
HTTPSU = require('ssl.https')
HTTPY = require("socket.http")
HTTPSY = require('ssl.https')
ltn12 = require("ltn12")
 ---redis = require("./redis/redwis")
mimetype = (loadfile "./mimetype.lua")()
encode = require("./lua-multipart-post.multipart-post").encode
 config = dofile('config.lua')
  dofile('utilities.lua')
  dofile("method.lua")
function get_receiver(msg)
  if msg.chat.type == 'private' then
    return msg.from.id
  end
  if msg.chat.type == 'group' then
    return msg.chat.id
  end
  if msg.chat.type == 'channel' then
    return msg.chat.id
  end
  if msg.chat.type == "supergroup" then
    return msg.chat.id
  end
end
function load_plugins()
  plug = load_data("plugins.db")
  for k, v in pairs(plug) do
    print("Loading plugin", v)

    local ok, err =  pcall(function()
      local t = loadfile("plugins/"..v)()
      plugins[k] = t
    end)
  if not ok then
     print('\27[31mError loading plugin '..v..'\27[39m')
      print('\27[31m'..err..'\27[39m')
    end
end
end
-------- @MICO_IQ
function bot_run()
	bot = nil

repeat bot = getMe() until bot

	bot = bot.result
  if not add then
		add = load_data('mico.db')
	end
	if not ban then
		ban = load_data('ban.db')
	end
    if not dat then
	dat = load_data("./manager/userdata.json")
	end
	local bot_info = "Username = @"..bot.username.."\nName = "..bot.first_name.."\nId = "..bot.id.." \nBASED BY :- @mico_iq"

	print(bot_info)

    dat.username = dat.username or {}
	dat.id = dat.id or {}
	last_update = last_update or 0

 currect_folder = ""

 is_running = true
	math.randomseed(os.time())
	math.random()

if not plug then plug = load_data("plugins.db") end
if plug[1] == nil then plug[1] = "plugins.lua" save_data("plugins.db",plug) end
	last_cron = last_cron or os.date('%M') -- the time of the last cron job,
	is_started = true -- and whether or not the bot should be running.
  config = dofile('config.lua')
  dofile('utilities.lua')
  dofile("method.lua")
  plugins = {} -- Load plugins.
  load_plugins()
end
function get_http_file_name(url, headers)
  -- Eg: foo.var
  local file_name = url:match("[^%w]+([%.%w]+)$")
  -- Any delimited alphanumeric on the url
  file_name = file_name or url:match("[^%w]+(%w+)[^%w]+$")
  -- Random name, hope content-type works
  file_name = file_name or str:random(5)

  local content_type = headers["content-type"]

  local extension = nil
  if content_type then
    extension = mimetype.get_mime_extension(content_type)
  end
  if extension then
    file_name = file_name.."."..extension
  end

  local disposition = headers["content-disposition"]
  if disposition then
    -- attachment; filename=CodeCogsEqn.png
    file_name = disposition:match('filename=([^;]+)') or file_name
  end

  return file_name
end
function match_pattern(pattern , msg , text)
   local text  = ""
  if msg.forward_from or msg.forward_from_chat then
    text = "##forward##"
  elseif msg.text then
    text = msg.text
  elseif msg.audio then
    text = "##audio##"

     elseif msg.photo then
    text = "##photo##"
  --   print(text)
  elseif msg.video then
    text = "##video##"
  --   print(text)
  elseif msg.document then
    text = "##document##"
--     print(text)
  elseif msg.sticker then
    text = "##sticker##"
  --   print(text)
  elseif msg.voice then
    text = "##voice##"
  --   print(text)
  elseif msg.contact then
    text = "##contact##"
  --   print(text)
  elseif msg.new_chat_member then
    text = "##new_chat_member##"
   --  print(text)
  end
   if text then

      matches = { string.match(text, pattern) }
      if next(matches) then
        return matches
      end
  end
  -- nil
 end
function inline_msg_receive(inline) -- run whenever a inline query is received.
	msg = {
		id = inline.id,
		chat = {
			['id'] = inline.from.id,
			['title'] = 'inline',
			['type'] = 'inline',
			['title'] = inline.from.fisrt_name
			},
		from = inline.from,
		message_id = math.random(100, 800),
		text = '/!/inline '..inline.query,
		date = os.time() + 20
	}
	-- Convent to message
	msg_processor(msg)
end
function handle_inline_keyboards(msg)

	msg.text = '#in:'..msg.data
	t = {}
	t["id"] = 0
	if msg.message then
	msg.old_text =  msg.message.text
	msg.old_date =  msg.message.date
	msg.message_id = msg.message.message_id
	--msg.chat.type = "inline_keyboard"
	msg.chat = msg.message.chat
	else
	msg.old_text =  "test"
	msg.old_date =  9
	msg.message_id = 9
	msg.chat = t
	end
	if msg.inline_message_id then
	msg.inline = msg.inline_message_id
	end
	msg.date = os.time()
	msg.cb = true
	msg.cb_id = msg.id
	msg.message = nil
	return msg_processor(msg)

end

function msg_valid(msg)
now = os.time()
  -- Don't process outgoing messages
  if msg.out then
    print('\27[36mNot valid: msg from us\27[39m')
    return false
  end

  -- Before bot was started
  if msg.date == now - 5 then
    print('\27[36mNot valid: old msg\27[39m')
    return false
  end

  if msg.unread == 0 then
    print('\27[36mNot valid: readed\27[39m')
    return false
  end

  if not msg.chat.id then
    print('\27[36mNot valid: To id not provided\27[39m')
    return false
  end

  if not msg.from.id then
    print('\27[36mNot valid: From id not provided\27[39m')
    return false
  end

  if msg.from.id == our_id then
    print('\27[36mNot valid: Msg from our id\27[39m')
    return false
  end

  if msg.chat.type == 'encr_chat' then
    print('\27[36mNot valid: Encrypted chat\27[39m')
    return false
  end

  if msg.from.id == 777000 then
    print('\27[36mNot valid: Telegram message\27[39m')
    return false
  end

  return true
end

function pre_process_service_msg(msg)
   if msg.service then
      local action = msg.action or {type=""}
      -- Double ! to discriminate of normal actions
      msg.text = "!!tgservice " .. action.type

      -- wipe the data to allow the bot to read service messages
      if msg.out then
         msg.out = false
      end
      if msg.from.id == our_id then
         msg.from.id = 0
      end
   end
   return msg
end

function pre_process_msg(msg)
  for name,plugin in pairs(plugins) do
    if plugin.pre_process and msg then
      print('Preprocess', name)
      msg = plugin.pre_process(msg)
    end
  end

  return msg
end
function msg_processor(msg)
if msg.chat then
  chatid = msg.chat.id
   receiver = chatid
   else
    chatid = 0
   receiver = 0
end
if msg.date < os.time() - 5 then return end -- Do not process old messages.
local pat = ""

if msg.from.username and resolve_username("@"..msg.from.username) ~= nil then
	patch = "@"..msg.from.username
	else
	patch  = msg.from.id
	end
	local msg_text = msg.text or "media"
	if msg_text:find("[ا-ي]") then
	msg_text = "arabic string"
	else
	msg_text = msg.text or "media"
	end
      print(patch.." msg matches: ", msg.chat.type .. " : "..msg.chat.id.." : "..msg_text)
  msg = pre_process_service_msg(msg)
  if msg_valid(msg) then
    msg = pre_process_msg(msg)
    if msg then
        for k, v in ipairs(plugins) do
 for i, pattern in pairs(v.patterns) do
    local matches = match_pattern(pattern, msg)
    if matches then
      pat  = pattern
      	local success, result = pcall(function()
					return v.run(msg,matches)
				end)
				if not success then print("fucked up") handle_exception(result, msg.from.id .. ': ' .. tostring(msg.text))  end


    end
    end
end


    end
  end
end



bot_run()
while is_running do
	local response = getUpdates(last_update+1)
	if response then
		for i,v in ipairs(response.result) do
			last_update = v.update_id
	    if v.message then
				msg_processor(v.message)
	    elseif v.inline_query then
				inline_msg_receive (v.inline_query)
		elseif v.callback_query then
		       handle_inline_keyboards(v.callback_query)
			end
		end
	else
		print("Conection failed")
	end

	if last_cron ~= os.date('%M') then
			last_cron = os.date('%M')

			for i,v in ipairs(plugins) do
				if v.timer then

					local result, err = pcall(function() v.timer(config) end)
					if not result then
						print("Erorr")
						handle_exception(err, 'timer: ' .. i, config)
					end
				end
			end
		end
	end

print("Bot halted")
