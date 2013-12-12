Star = {orig_x = 0, orig_y = 0, radius = 8, revealed = false, color = {r = 255, g = 255, b = 255}}

function Star:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Star:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)
   
   love.graphics.circle("fill", 0, 0, self.radius)

   love.graphics.pop()
end

AsteroidCloud = {orig_x = 0, orig_y = 0, radius = 15, revealed = false, color = {r = 100, g = 100, b = 100}}

function AsteroidCloud:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function AsteroidCloud:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)
   
   love.graphics.circle("fill", 0, 0, self.radius)

   love.graphics.pop()
end

MassiveBlackHole = {orig_x = 0, orig_y = 0, radius = 15, revealed = false, color = {r = 0, g = 0, b = 0}}

function MassiveBlackHole:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function MassiveBlackHole:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)
   
   love.graphics.circle("fill", 0, 0, self.radius)

   love.graphics.pop()
end

Nexus = {orig_x = 0, orig_y = 0, radius = 10, revealed = false, color = {r = 255, g = 255, b = 0}}

function Nexus:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Nexus:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)
   
   love.graphics.circle("fill", 0, 0, self.radius)

   love.graphics.pop()
end

EmptySpace = {orig_x = 0, orig_y = 0, radius = 1, revealed = false, color = {r = 255, g = 255, b = 0}}

function EmptySpace:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function EmptySpace:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)
   
   love.graphics.circle("fill", 0, 0, self.radius)

   love.graphics.pop()
end

