Planet = {orig_x = 0, orig_y = 0, radius = 7, revealed = false, color = {r = 0, g = 200, b =100}}

function Planet:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Planet:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)

   love.graphics.circle("fill",0,0,self.radius)

   love.graphics.pop()
end

Ship = {orig_x = 0, orig_y = 0, size = 5, revealed = false, color = {r = 100, g = 200, b =50}}

function Ship:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Ship:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)

   love.graphics.polygon("fill", 0, -self.size, self.size, 0, 0, self.size, -self.size, 0)

   love.graphics.pop()
end

Station = {orig_x = 0, orig_y = 0, size = 8, revealed = false, color = {r = 220, g = 220, b =220}}

function Station:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Station:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)

   love.graphics.rectangle("fill",-self.size, -self.size, self.size, self.size)

   love.graphics.pop()
end