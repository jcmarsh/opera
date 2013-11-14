Tri = {orig_x = 0, orig_y = 0, p1 = {x = 0, y = 0}, p2 = {x = 0, y = 0}, p3 = {x = 0, y = 0},
       color = {r = 30, g = 30, b = 30}, revealed = false, actors = {}}

function Tri:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Tri:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)
--   love.graphics.translate(self.orig_x - self.width / 2, self.orig_y - self.height / 2)

   if self.revealed then
      love.graphics.polygon("fill", self.p1.x, self.p1.y, self.p2.x, self.p2.y, self.p3.x, self.p3.y)
   end

   center_x = (self.p1.x + self.p2.x + self.p3.x) / 3
   center_y = (self.p1.y + self.p2.y + self.p3.y) / 3
   love.graphics.translate(center_x, center_y) -- Actors have the center of the triangle as (0,0)
   for i = 1, #self.actors do
      self.actors[i]:draw()
   end
   love.graphics.translate(-center_x, -center_y)

   love.graphics.setColor(155,155,155) -- border of hex
   love.graphics.line(self.p1.x, self.p1.y, self.p2.x, self.p2.y)
   love.graphics.setColor(55,55,55) -- inner lines
   love.graphics.line(self.p1.x, self.p1.y, self.p3.x, self.p3.y)
   love.graphics.line(self.p2.x, self.p2.y, self.p3.x, self.p3.y)

   love.graphics.pop()
end

function Tri:containsPoint(x, y)

end

function Tri:handleMouse(x, y, button)

end