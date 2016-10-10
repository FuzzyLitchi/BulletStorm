local Collision = {}

function Collision:touching(circle1, circle2)
  return math.sqrt((circle1.x-circle2.x)*(circle1.x-circle2.x) +
    (circle1.y-circle2.y) * (circle1.y-circle2.y)) < circle1.radius + circle2.radius
end

return Collision
