local Collision = require "collision"

local Player = {}

function Player:make(x, y, state)
  player = {
    x = x, y = y,
    velX = 0, velY = 0,
    acceleration = 300, friction = 2,
    rotation = 10,
    radius = 8, state = state,
    points = 0
  }

  function player:update(dt, agents)

    self.points = self.points + math.sqrt(self.velX^2 + self.velY^2) / (35E4 * dt)

    if love.keyboard.isDown("w") then
      self.velY = self.velY - self.acceleration * dt
    elseif love.keyboard.isDown("s") then
      self.velY = self.velY + self.acceleration * dt
    end

    if love.keyboard.isDown("a") then
      self.velX = self.velX - self.acceleration * dt
    elseif love.keyboard.isDown("d") then
      self.velX = self.velX + self.acceleration * dt
    end

    self.rotation = math.atan2(self.velY, self.velX)

    self.velX = self.velX - (self.velX / self.friction) * dt
    self.velY = self.velY - (self.velY / self.friction) * dt

    self.x = self.x + self.velX * dt
    self.y = self.y + self.velY * dt

    self.x = Player:clamp(self.x, 0, love.graphics.getWidth())
    self.y = Player:clamp(self.y, 0, love.graphics.getHeight())

    for i, v in ipairs(agents) do
      if Collision:touching(self, v) then
        state:set("game")
        break
      end
    end
  end

  function player:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.line(self.x, self.y, self.x + math.cos(self.rotation) * 75, self.y + math.sin(self.rotation) * 75)
    love.graphics.print(self.points, love.graphics.getWidth()/2-60, 10)
  end

  return player
end

function Player:clamp(val, min, max)
  if val < min then
    return min
  elseif val > max then
    return max
  else
    return val
  end
end

return Player
