local player = require "player"
local Agent = require "agent"
local socket = require "socket"
local utf8 = require "utf8"

address, port = "10.22.2.183", 7788
playing = true
text = ""

function math.clamp(val, min, max)
  if val < min then
    return min
  elseif val > max then
    return max
  else
    return val
  end
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function reset()
  agents = {}

  player:load()

  for i = 0, 10 do
    local agent = Agent:make(math.random(0, love.graphics.getWidth()), 10)
    table.insert(agents, agent)
    agent:load(player)
  end

  for i = 0, 10 do
    local agent = Agent:make(0, math.random(0, love.graphics.getHeight()) - 26)
    table.insert(agents, agent)
    agent:load(player)
  end
end

function love.load()

  udp = socket.udp()
  udp:settimeout(0)
  udp:setpeername(address, port)

  reset()
end

function love.update(dt)
  if playing then
    player:update(dt, agents)
    at = math.sqrt(player.velX^2 + player.velY^2) / (35E4 * dt)
    for i, v in ipairs(agents) do
      v:update(at, player)
    end
  else

  end

  if player.dead then
    playing = false
  end
end

function love.draw()
  if playing then
    player:draw()
    for i, v in ipairs(agents) do
      v:draw()
    end
  else
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(player.points, 100, 100)
    love.graphics.print(text, 100, 150)
  end
end

function love.textinput(t)
  if not playing then
    text = text .. t
  end
end

function love.keypressed(key)
  if not playing then
    if key == "backspace" then
      -- get the byte offset to the last UTF-8 character in the string.
      local byteoffset = utf8.offset(text, -1)

      if byteoffset then
        -- remove the last UTF-8 character.
        -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
        text = string.sub(text, 1, byteoffset - 1)
      end
    elseif key == "return" then
      if text == "" then
      else
        print(text .. ":" .. round(player.points, 3))
        udp:send(text .. ":" .. round(player.points, 3))
      end
      text = ""
      playing = true
      reset()
    end
  end
end
