
package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'
URL = require('socket.url')
assert(JSON)
--pcall(require, "luarocks.loader")
--local htmlparser = require("htmlparser")
http = require "socket.http"
HTTPS = require('ssl.https')
ltn12 = require("ltn12")
BASE_URL = 'https://api.telegram.org/bot' .. config.bot_api_key
function getFile(file_id)
  local url = BASE_URL .."/getFile?file_id="..file_id
  check = JSON:decode(HTTPS.request(url)).ok
  local file_path = ""
  if check == true then
   file_path = JSON:decode(HTTPS.request(url)).result.file_path
  end
  if file_path ~= "" then
  file_ul = "https://api.telegram.org/file/bot"..config.bot_api_key.."/"..file_path
  end
return file_ul or nil

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
 function sendRequest(url)
--print(url)
  local dat, res = HTTPS.request(url)
  
  local tab = JSON:decode(dat)
  --if tab.result[1] then
  --for k,v in pairs(tab.result[1]) do
  --print(tostring(k),tostring(v))
  --end
  --end
  if res ~= 200 then
    return false, res
  end

  if not tab.ok then
    return false, tab.description
  end

  return tab

end

 function getMe()

   local url = BASE_URL .. '/getMe'
   return sendRequest(url)

end
 function getUpdates(offset)

  local url = BASE_URL .. '/getUpdates?timeout=20'

  if offset then

    url = url .. '&offset=' .. offset

  end

  return sendRequest(url)

end
function leaveChat(chat_id)

  local url = BASE_URL .. '/leaveChat?&chat_id=' .. chat_id

  return sendRequest(url)

end
 function sendSticker(chat_id, sticker, reply_to_message_id)

   local url = BASE_URL .. '/sendSticker'

   local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "sticker=@' .. sticker .. '"'

   if reply_to_message_id then
      curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
   end

   JS = io.popen(curl_command):read("*all")

   return JSON:decode(JS) end
 function sendPhoto(chat_id, photo, caption, reply_to_message_id)

   local url = BASE_URL .. '/sendPhoto'

   local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "photo=@' .. photo .. '"'

   if reply_to_message_id then
      curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
   end

   if caption then
      curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
   end

   io.popen(curl_command):read("*all")
   return end
 function forwardMessage(chat_id, from_chat_id, message_id)

   local url = BASE_URL .. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id

   return sendRequest(url)

end
function Hide(selective)
  res = {}
  res.force_reply = true
  res.selective = selective or false
  return res
end
function Markup(keyboard, resize_keyboard, one_time_keyboard,   selective)
  if not keyboard then
    print ("keyboard not specified")
    return nil
    end
  if #keyboard < 1 then
    print ("keyboard is empty")
    return nil
    end
  res = {}
  res.keyboard = {keyboard}
  res.resize_keyboard = resize_keyboard or false
  res.one_time_keyboard = one_time_keyboard or true
  res.selective = selective or true
  return res
 end
 function sendMessage(chat_id, text, disable_web_page_preview, reply_to_message_id, use_markdown, reply_markup )

   local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)

   if disable_web_page_preview == true then
      url = url .. '&disable_web_page_preview=true'
   end

   if reply_to_message_id then
      url = url .. '&reply_to_message_id=' .. reply_to_message_id
   end

   if use_markdown then
      url = url .. '&parse_mode=Markdown'
   end
   if reply_markup then
   url = url .. "&reply_markup="..URL.escape(reply_markup)
end

   print(url)
   return JSON:decode(HTTPS.request(url))

end
function getChat(chat_id)
local url = BASE_URL .. '/getChat?chat_id=' .. chat_id
return sendRequest(url)
end
function getChatAdministrators(chat_id)

local url = BASE_URL .. '/getChatAdministrators?chat_id=' .. chat_id
return sendRequest(url)
end
function getChatMembersCount(chat_id)

local url = BASE_URL .. '/getChatMembersCount?chat_id=' .. chat_id
return JSON:decode(HTTPS.request(url)).result
end
function getChatMember(chat_id, user_id)
   local url = BASE_URL .. '/getChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id
   return JSON:decode(HTTPS.request(url))
end
 function sendDocument(chat_id, document, reply_to_message_id)

   local url = BASE_URL .. '/sendDocument'

   local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "document=@' .. document .. '"'

   if reply_to_message_id then
      curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
   end

   io.popen(curl_command):read("*all")
   return

end
 function sendDocumentID(chat_id, document,caption, reply_to_message_id)
              local url = BASE_URL .. '/sendDocument?chat_id=' .. chat_id .. '&document=' .. document

   if reply_to_message_id then
      url = url .. '&reply_to_message_id=' .. reply_to_message_id
   end
 if caption then
      url = url .. '&caption=' .. URL.escape(caption)
   end
   return sendRequest(url)
 end
 function sendPhotoID(chat_id, file_id, caption, reply_to_message_id, disable_notification)

   local url = BASE_URL .. '/sendPhoto?chat_id=' .. chat_id .. '&photo=' .. file_id

   if caption then
      url = url .. '&caption=' .. URL.escape(caption)
   end

   if reply_to_message_id then
      url = url .. '&reply_to_message_id=' .. reply_to_message_id
   end

   if disable_notification then
      url = url .. '&disable_notification=true'
   end

   return sendRequest(url)

end
 function getUserProfilePhotos(user_id)
if user_id == nil then
return
else
local url = BASE_URL .. '/getUserProfilePhotos?user_id='..user_id

return sendRequest(url)
end
end
 function download_to_file(url, file_name)

  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }

  -- nil, code, headers, status
  local response = nil

  if string.find(url,'https') then
    options.redirect = false
    response = {HTTPS.request(options)}
  else
    response = {HTTP.request(options)}
  end

  local code = response[2]
  local headers = response[3]
  local status = response[4]

  if code ~= 200 then return nil end

  file_name = file_name or get_http_file_name(url, headers)

  local file_path = file_name

  file = io.open(file_path, "w+")
  file:write(table.concat(respbody))
  file:close()

  return file_path
end
 function sendVideo(chat_id, video, reply_to_message_id, duration, caption, disable_notification)

   local url = BASE_URL .. '/sendVideo'

   local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "video=@' .. video .. '"'

   if reply_to_message_id then
      curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
   end

   if caption then
      curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
   end

   if duration then
      curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
   end

   if disable_notification then
      curl_command = curl_command .. ' -F "disable_notification=true"'
   end

io.popen(curl_command):read("*all")

end
 function sendVoice(chat_id, voice, reply_to_message_id, duration, disable_notification)

   local url = BASE_URL .. '/sendVoice'

   local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "voice=@' .. voice .. '"'

   if reply_to_message_id then
      curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
   end

   if duration then
      curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
   end

   if disable_notification then
      curl_command = curl_command .. ' -F "disable_notification=true"'
   end

 JS = io.popen(curl_command):read("*all")
 return JSON:decode(JS)
end
 function sendChatAction(chat_id, action)
 -- Support actions are typing, upload_photo, record_video, upload_video, record_audio, upload_audio, upload_document, find_location

   local url = BASE_URL .. '/sendChatAction?chat_id=' .. chat_id .. '&action=' .. action
   return sendRequest(url)

end
 function sendLocation(chat_id, latitude, longitude, reply_to_message_id, disable_notification)

   if latitude == 0 then latitude = 0.001 end
   if longitude == 0 then longitude = 0.001 end

   local url = BASE_URL .. '/sendLocation?chat_id=' .. chat_id .. '&latitude=' .. latitude .. '&longitude=' .. longitude

   if reply_to_message_id then
      url = url .. '&reply_to_message_id=' .. reply_to_message_id
   end

   if disable_notification then
      url = url .. '&disable_notification=true'
   end

   return sendRequest(url)

end
 function sendVenue(chat_id, latitude, longitude, title, address, foursquare_id, reply_to_message_id, disable_notification)

   if latitude == 0 then latitude = 0.001 end
   if longitude == 0 then longitude = 0.001 end

   local url = BASE_URL .. '/sendVenue?chat_id=' .. chat_id .. '&latitude=' .. latitude .. '&longitude=' .. longitude .. '&title=' .. title .. '&address=' .. address

   if foursquare_id then
      url = url .. '&foursquare_id=' .. foursquare_id
   end

   if reply_to_message_id then
      url = url .. '&reply_to_message_id=' .. reply_to_message_id
   end

   if disable_notification then
      url = url .. '&disable_notification=true'
   end

   return sendRequest(url)

end
 function sendContact(chat_id, phone_number, first_name, last_name, reply_to_message_id, disable_notification)

   local url = BASE_URL .. '/sendContact?chat_id=' .. chat_id .. '&phone_number=' .. phone_number .. '&first_name=' .. first_name

   if last_name then
      url = url .. '&last_name=' .. last_name
   end

   if reply_to_message_id then
      url = url .. '&reply_to_message_id=' .. reply_to_message_id
   end

   if disable_notification then
      url = url .. '&disable_notification=true'
   end

   return sendRequest(url)

end
 function kickChatMember(chat_id, user_id)
   local url = BASE_URL .. '/kickChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id
   return sendRequest(url)
end
 function unbanChatMember(chat_id, user_id)
   local url = BASE_URL .. '/unbanChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id
   return sendRequest(url)
end
 function sendAudio(chat_id, audio, reply_to_message_id, duration, performer,reply_markup, title, disable_notification)

   local url = BASE_URL .. '/sendAudio'

   local curl_command = 'curl -s "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "audio=@' .. audio .. '"'

   if reply_to_message_id then
      curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
   end

   if duration then
      curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
   end

   if performer then
      curl_command = curl_command .. ' -F "performer=' .. performer .. '"'
   end

   if title then
      curl_command = curl_command .. ' -F "title=' .. title .. '"'
   end

   if disable_notification then
      curl_command = curl_command .. ' -F "disable_notification=true"'
   end
    if reply_markup then
   curl_command = curl_command .. ' -F "reply_markup='..URL.escape(reply_markup)..'"'
end
print(curl_command)
print(io.popen(curl_command):read("*all"))

end

 function editMessageReplyMarkup(chat_id, message_id, keyboard)

	local url = BASE_URL .. '/editMessageReplyMarkup?chat_id=' .. chat_id .. '&message_id='..message_id



	if keyboard then
		url = url..'&reply_markup='..keyboard
	end
 print(url)
	return JSON:decode(HTTPS.request(url))

end
 function editMessageText(chat_id, message_id, text, keyboard, markdown)

	local url = BASE_URL .. '/editMessageText?chat_id=' .. chat_id .. '&message_id='..message_id..'&text=' .. URL.escape(text)

	if markdown then
		url = url .. '&parse_mode=Markdown'
	end

	url = url .. '&disable_web_page_preview=true'

	if keyboard then
		url = url..'&reply_markup='..keyboard
	end
 print(url)
	return JSON:decode(HTTPS.request(url))

end
function editMessageKey(message_id, text, keyboard, markdown)

	local url = BASE_URL .. '/editMessageText?inline_message_id='..message_id.."&text=" .. URL.escape(text)

	if markdown then
		url = url .. '&parse_mode=Markdown'
	end

	url = url .. '&disable_web_page_preview=true'

	if keyboard then
		url = url..'&reply_markup='..URL.escape(keyboard)
	end

	return sendRequest(url)

end
function answerCallbackQuery(callback_query_id, text, show_alert)

	local url = BASE_URL .. '/answerCallbackQuery?callback_query_id=' .. callback_query_id .. '&text=' .. URL.escape(text)

	if show_alert then
		url = url..'&show_alert=true'
	end

	return sendRequest(url)

end
function deleteMessage(chat_id,message_id)
  local second_url = 'https://api.pwrtelegram.xyz/bot' .. config.bot_api_key
  local url = second_url .. '/deleteMessage?chat_id=' .. chat_id .. '&message_id=' .. message_id
   return sendRequest(url)
end
local M = {} -- Main Bot Framework
local E = {} -- Extension Framework
local C = {} -- Configure Constructor
function makeRequest(method, request_body)

  local response = {}
  local body, boundary = encode(request_body)
  local success, code, headers, status = https.request{
    url = "https://api.telegram.org/bot" .. config.bot_api_key .. "/" .. method,
    method = "POST",
    headers = {
      ["Content-Type"] =  "multipart/form-data; boundary=" .. boundary,
    	["Content-Length"] = string.len(body),
    },
    source = ltn12.source.string(body),
    sink = ltn12.sink.table(response),
  }

  local r = {
    success = success or "false",
    code = code or "0",
    headers = table.concat(headers or {"no headers"}),
    status = status or "0",
    body = table.concat(response or {"no response"}),
  }
  for k,v in pairs(r) do
  print(k,v)
  end
  return r
end

function send(chat_id, audio, duration, performer, title, reply_markup)

  if not chat_id then return nil, "chat_id not specified" end
  if not audio then return nil, "audio not specified" end

  local request_body = {}
  local file_id = ""
  local audio_data = {}

  if not(string.find(audio, "%.mp3")) then
    file_id = audio
  else
    file_id = nil
    local audio_file = io.open(audio, "r")

    audio_data.filename = audio
    audio_data.data = audio_file:read("*a")
    audio_data.content_type = "audio/mpeg"

    audio_file:close()
  end

  request_body.chat_id = chat_id
  request_body.audio = file_id or audio_data
  request_body.duration = duration
  request_body.performer = performer
  request_body.title = title
  request_body.disable_notification = tostring(disable_notification)
  request_body.reply_to_message_id = tonumber(reply_to_message_id)
  request_body.reply_markup = reply_markup

  local response = makeRequest("sendAudio",request_body)

  if (response.success == 1) then
    return JSON:decode(response.body)
  else
    return nil, "Request Error"
  end
end
function Photo(chat_id, photo, caption, disable_notification, reply_to_message_id, reply_markup)

  if not chat_id then return nil, "chat_id not specified" end
  if not photo then return nil, "photo not specified" end

  local request_body = {""}
  local file_id = ""
  local photo_data = {}

  if not(string.find(photo, "%.")) then
    file_id = photo
  else
    file_id = nil
    local photo_file = io.open(photo, "r")

    photo_data.filename = photo
    photo_data.data = photo_file:read("*a")
    photo_data.content_type = "image"

    photo_file:close()
  end

  request_body.chat_id = chat_id
  request_body.photo = file_id or photo_data
  request_body.caption = caption
  request_body.disable_notification = tostring(disable_notification)
  request_body.reply_to_message_id = tonumber(reply_to_message_id)
  request_body.reply_markup = reply_markup

  local response = makeRequest("sendPhoto",request_body)

  if (response.success == 1) then
    return JSON:decode(response.body)
  else
    return nil, "Request Error"
  end
end
function Document(chat_id, document, caption, disable_notification, reply_to_message_id, reply_markup)

  if not chat_id then return nil, "chat_id not specified" end
  if not document then return nil, "document not specified" end

  local request_body = {}
  local file_id = ""
  local document_data = {}

  if not(string.find(document, "%.")) then
    file_id = document
  else
    file_id = nil
    local document_file = io.open(document, "r")

    document_data.filename = document
    document_data.data = document_file:read("*a")

    document_file:close()
  end

  request_body.chat_id = chat_id
  request_body.document = file_id or document_data
  request_body.caption = caption
  request_body.disable_notification = tostring(disable_notification)
  request_body.reply_to_message_id = tonumber(reply_to_message_id)
  request_body.reply_markup = reply_markup

  local response = makeRequest("sendDocument",request_body)

  if (response.success == 1) then
    return JSON:decode(response.body)
  else
    return nil, "Request Error"
  end
end
function Sticker(chat_id, sticker, disable_notification, reply_to_message_id, reply_markup)

  if not chat_id then return nil, "chat_id not specified" end
  if not sticker then return nil, "sticker not specified" end

  local request_body = {}
  local file_id = ""
  local sticker_data = {}

  if not(string.find(sticker, "%.webp")) then
    file_id = sticker
  else
    file_id = nil
    local sticker_file = io.open(sticker, "r")

    sticker_data.filename = sticker
    sticker_data.data = sticker_file:read("*a")
    sticker_data.content_type = "image/webp"

    sticker_file:close()
  end

  request_body.chat_id = chat_id
  request_body.sticker = file_id or sticker_data
  request_body.disable_notification = tostring(disable_notification)
  request_body.reply_to_message_id = tonumber(reply_to_message_id)
  request_body.reply_markup = reply_markup

  local response = makeRequest("sendSticker",request_body)

  if (response.success == 1) then
    return JSON:decode(response.body)
  else
    return nil, "Request Error"
  end
end
function Voice(chat_id, voice, duration, disable_notification, reply_to_message_id, reply_markup)

  if not chat_id then return nil, "chat_id not specified" end
  if not voice then return nil, "voice not specified" end

  local request_body = {}
  local file_id = ""
  local voice_data = {}

  if not(string.find(voice, "%.ogg")) then
    file_id = voice
  else
    file_id = nil
    local voice_file = io.open(voice, "r")

    voice_data.filename = voice
    voice_data.data = voice_file:read("*a")
    voice_data.content_type = "audio/ogg"

    voice_file:close()
  end

  request_body.chat_id = chat_id
  request_body.voice = file_id or voice_data
  request_body.duration = duration
  request_body.disable_notification = tostring(disable_notification)
  request_body.reply_to_message_id = tonumber(reply_to_message_id)
  request_body.reply_markup = reply_markup

  local response = makeRequest("sendVoice",request_body)

  if (response.success == 1) then
    return JSON:decode(response.body)
  else
    return nil, "Request Error"
  end
end
