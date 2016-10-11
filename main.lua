local player = require "player"
local Agent = require "agent"

function math.clamp(val, min, max)
  if val < min then
    return min
  elseif val > max then
    return max
  else
    return val
  end
end

function love.load()

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

function love.update(dt)
  player:update(dt, agents)
  for i, v in ipairs(agents) do
    at = math.sqrt(player.velX^2 + player.velY^2) / (35E4 * dt)
    v:update(at, player)
  end

  if player.dead then
    love.load()
  end
end

function love.draw()
  player:draw()
  for i, v in ipairs(agents) do
    v:draw()
  end
end
