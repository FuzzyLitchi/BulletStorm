local Game = require "game"
local Menu = require "menu"

local state = "game"

local State = {}

function love.load()
  Game:load(State)
  Menu:load(State)
end

function love.update(dt)
  if state == "game" then
    Game:update(dt)
  end
end

function love.textinput(t)
  if state == "menu" then
    Menu:textinput(t)
  end
end

function love.keypressed(key)
  if state == "menu" then
    Menu:keypressed(key)
  end
end

function love.draw()
  if state == "game" then
    Game:draw()
  elseif state == "menu" then
    Menu:draw()
  end
end

function State:end_game (points)
  State:set("menu")
  Menu.points = points
end

function State:set(v)
  state = v
  Game:load(State)
end
