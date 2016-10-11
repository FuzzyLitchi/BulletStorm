local Collision = require "collision"

default = {
  x = 400, y = 300,
  velX = 0, velY = 0,
  acceleration = 300, friction = 2,
  rotation = 10, dead = false,
  radius = 8, points = 0
}
player = {}

function player:load()
  for i, v in pairs(default) do
    self[i] = v
  end
end

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

  self.x = math.clamp(self.x, 0, love.graphics.getWidth())
  self.y = math.clamp(self.y, 0, love.graphics.getHeight())

  for i, v in ipairs(agents) do
    if Collision:touching(self, v) then
      self.dead = true
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
