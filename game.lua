local Player = require "player"
local Agent = require "agent"

local Game = {}

Game.player = {}
Game.agents = {}

function Game:load(state)

  self.agents = {}

  self.player = Player:make(400, 300, state)

  for i = 0, 10 do
    local agent = Agent:make(math.random(0, love.graphics.getWidth()), 10)
    table.insert(self.agents, agent)
    agent:load(self.player)
  end

  for i = 0, 10 do
    local agent = Agent:make(0, math.random(0, love.graphics.getHeight()) - 26)
    table.insert(self.agents, agent)
    agent:load(self.player)
  end
end

function Game:update(dt)
  self.player:update(dt, self.agents)
  for i, v in ipairs(self.agents) do
    at = math.sqrt(self.player.velX^2 + self.player.velY^2) / (35E4 * dt)
    v:update(at, player)
  end
end

function Game:draw()
  self.player:draw()
  for i, v in ipairs(self.agents) do
    v:draw()
  end
end

return Game
