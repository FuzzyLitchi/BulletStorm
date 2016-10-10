local socket = require "socket"
local Menu = {player_name = "", points = 0}

function Menu:load(State)
  local address, port = "localhost", 7788 --NOTE change this to server local ip
  local udp = socket:udp()
  udp:settimeout(0)
  udp:setpeername(address, port)
  math.randomseed(os.time())
end

function Menu:textinput (t)
  self.player_name = self.player_name .. t
end

function Menu:keypressed (key)
  if key == "enter" then
    udp:send(self.player_name .. " " .. self.points)
    State:set("game")
  end

  if key == "backspace" then
    -- get the byte offset to the last UTF-8 character in the string.
    local byteoffset = utf8.offset(text, -1)

    if byteoffset then
      -- remove the last UTF-8 character.
      -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
      self.player_name = string.sub(self.player_name, 1, byteoffset - 1)
    end
  end
end

function Menu:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(self.points, love.graphics.getWidth()/2-60, 10)
  love.graphics.print("INSERT NAME: " .. self.player_name, love.graphics.getWidth()/2-60, 40)
end

return Menu
