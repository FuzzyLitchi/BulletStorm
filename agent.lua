local Agent = {}

function Agent:make(x, y)
  agent = {
    x = x, y = y,
    speed = 200, rotation = 0,
    radius = 16
  }

  function agent:load(player)
    self.rotation = math.atan2(player.y - self.y, player.x - self.x)
  end

  function agent:update(dt, player)

    self.x = self.x + math.cos(self.rotation) * self.speed * dt
    self.y = self.y + math.sin(self.rotation) * self.speed * dt

    if self.x < 0 or self.x > love.graphics.getWidth() or
        self.y < 0 or self.y > love.graphics.getHeight() then
      self.rotation = math.atan2(player.y - self.y, player.x - self.x)
    end
  end

  function agent:draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.line(self.x, self.y, self.x + math.cos(self.rotation) * 100, self.y + math.sin(self.rotation) * 100)
  end

  return agent
end

return Agent
