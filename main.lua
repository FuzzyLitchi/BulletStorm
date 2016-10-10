local Game = require "game"
local Menu = require "menu"

local state = "game"

local State = {}

function love.load()
  if state == "game" then
    Game:load(State)
  end
end

function love.update(dt)
  if state == "game" then
    Game:update(dt)
  elseif state == "menu" then
    Menu:update(dt)
  end
end

function love.draw()
  if state == "game" then
    Game:draw()
  elseif state == "menu" then
    Menu:draw()
  end
end

function State:set(v)
  state = v
  love.load()
end
