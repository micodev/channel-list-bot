-- some function copied from otouto (to finished things fast it does not mean I can not make it.)
HTTP = HTTP or require('socket.http')
HTTPS = HTTPS or require('ssl.https')
http =  require('socket.http')
https = require('ssl.https')
JSON = JSON or require('./dkjson')
mimetype = (loadfile "./mimetype.lua")()


function is_admin(msg)
  local var = false
  local admins = config.admins
  for k,v in pairs(admins) do
    if msg.from.id == tonumber(v) then
      var = true
    end
  end
  return var
end

function load_from_file(file, default_data)
  local f = io.open(file, "r+")

  if f == nil then

    default_data = default_data or {}
    serialize_to_file(default_data, file)
    print ('Created file', file)
  else
    print ('Data loaded from file', file)
    f:close()
  end
  return loadfile (file)()
end

function string:input()
	if not self:find(' ') then
		return false
	end
	return self:sub(self:find(' ')+1)
end


function string:trim()
	local s = self:gsub('^%s*(.-)%s*$', '%1')
	return s
end


load_data = function(filename)

	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = JSON:decode(s)

	return data

end


save_data = function(filename, data)

	local s = JSON:encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()

end


get_coords = function(input)

	local url = 'http://maps.googleapis.com/maps/api/geocode/json?address=' .. URL.escape(input)

	local jstr, res = HTTP.request(url)
	if res ~= 200 then
		return config.errors.connection
	end

	local jdat = JSON.decode(jstr)
	if jdat.status == 'ZERO_RESULTS' then
		return config.errors.results
	end

	return {
		lat = jdat.results[1].geometry.location.lat,
		lon = jdat.results[1].geometry.location.lng
	}

end
table_size = function(tab)

	local i = 0
	for k,v in pairs(tab) do
		i = i + 1
	end
	return i

end

resolve_username = function(usr)

	local input = tostring(usr):lower()
	if input:match('^@') then
		local uname = input:gsub('^@', '')
		return dat.username[uname]
	else
		return tonumber(usr) or false
	end

end
resolve_id = function(usr)
print(usr)
print(type(usr))
	local input = tostring(usr)
    if dat.id[input] ~= nil then
		return dat.id[input]
	else
		return  "empty"
	end

end
handle_exception = function(err, message)

	if not err then err = '' end

	local output = '\n[' .. os.date('%F %T', os.time()) .. ']\n : ' .. err .. '\n' .. message .. '\n'

	if config.log_chat then
		output = '```' .. output .. '```'
		sendMessage(config.log_chat, output, true, nil, true)
	else
		print(output)
	end

end


t = load_data("./manager/groupsup.json")
function admin(msg,mid)
t = load_data("./manager/groupsup.json")
  local var = false
   admins = t.GM[tostring(msg.chat.id)][1].admins
   if admins == nil then
   return false
   end
  for k,v in pairs(admins) do
    if mid == tonumber(v) then
      var = true
    end
  end
  return var
end
function mas(msg,mid)

  local var = false
  if t.GM[tostring(msg.chat.id)] then
  local admins = t.GM[tostring(msg.chat.id)][1].master
  for k,v in pairs(admins) do
    if mid == tonumber(v) then
      var = true
    end
  end
  else
  var  = false
  end
  return var
end


function sendInline(inline_id, result, disable_web_page_preview)

	local url = BASE_URL .. '/answerInlineQuery?inline_query_id=' .. inline_id .. '&results=' .. result.."&switch_pm_text=made by @mico_iq&switch_pm_parameter=/p"

	if disable_web_page_preview == true then
		url = url .. '&disable_web_page_preview=true'
	end
   -- print(url)
	for k,v in pairs(JSON:decode(HTTPS.request(url))) do
	print(k,v)
	end
    return
end
function inline_block(title, text,disable_web_page_preview)
	local ran = math.random(1 ,100)
	local inline = '{"type":"article", "id":"'.. ran ..'", "title":"'.. title ..'", "message_text": "'.. text ..'", "parse_mode":"Markdown","disable_web_page_preview":true}'
	return inline
end
local i = 1
function inline_sticker(sticker_file_id)
	local ran = i
	local inline = '{"type":"sticker", "id":"'.. ran ..'", "sticker_file_id":"'.. sticker_file_id ..'"}'
		i = i + 1
	return inline
end
function inline_key(title, text,disable_web_page_preview,reply_markup)

	local ran = math.random(1 ,100)
	local inline = '{"type":"article", "id":"'.. ran ..'", "title":"'.. title ..'", "message_text": "'.. text ..'", "parse_mode":"Markdown","disable_web_page_preview":true,"reply_markup":'..reply_markup..'}'
	return inline
end
local i = 1
function inline_photo(photo_url,thumb_url)
	 ran = i
	local inline = '{"type":"photo", "id":"'.. ran ..'", "photo_url": "'.. photo_url ..'", "thumb_url":"'..thumb_url..'","photo_width":300,"photo_height":300}'
	i = i + 1
	return inline
end
function inline_photo_c(photo_url,thumb_url,description,caption,reply_markup)
	 ran = i
	local inline = '{"type":"photo", "id":"'.. ran ..'", "photo_url": "'.. photo_url ..'", "thumb_url":"'..thumb_url..'","photo_width":300,"photo_height":300,"description":"'..description..'","caption":"'..caption..'","reply_markup":'..reply_markup..'}'
	i = i + 1
	return inline
end


