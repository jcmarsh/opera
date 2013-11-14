Hex = {orig_x = 0, orig_y = 0, width = 104, height = 90, index = 0, color = {r = 220, g = 0, b = 0}, 
       center = {r = 255, g = 255, b = 0}, tris = {}, revealed = false}

function Hex:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Hex:initTris()
   extra = (self.width / 4)
   NW = {x = extra, y = 0}
   NE = {x = self.width - extra, y = 0}
   E = {x = self.width, y = self.height / 2}
   SE = {x = self.width - extra, y = self.height}
   SW = {x = extra, y = self.height}
   W = {x = 0, y = self.height / 2}
   C = {x = self.width / 2, y = self.height / 2}

   self.tris[#self.tris + 1] = Tri:new({orig_x = self.orig_x, orig_y = self.orig_y, p1 = NW, p2 = NE, p3 = C, actors = {}})
   self.tris[#self.tris + 1] = Tri:new({orig_x = self.orig_x, orig_y = self.orig_y, p1 = NE, p2 = E, p3 = C, actors = {}})
   self.tris[#self.tris + 1] = Tri:new({orig_x = self.orig_x, orig_y = self.orig_y, p1 = E, p2 = SE, p3 = C, actors = {}})
   self.tris[#self.tris + 1] = Tri:new({orig_x = self.orig_x, orig_y = self.orig_y, p1 = SE, p2 = SW, p3 = C, actors = {}})
   self.tris[#self.tris + 1] = Tri:new({orig_x = self.orig_x, orig_y = self.orig_y, p1 = SW, p2 = W, p3 = C, actors = {}})
   self.tris[#self.tris + 1] = Tri:new({orig_x = self.orig_x, orig_y = self.orig_y, p1 = W, p2 = NW, p3 = C, actors = {}})
end

function Hex:draw()
   love.graphics.push()
   love.graphics.setColor(self.color.r, self.color.g, self.color.b)
   love.graphics.translate(self.orig_x - self.width / 2, self.orig_y - self.height / 2)
   --love.graphics.rectangle("line", 0, 0, self.width, self.height)
   --love.graphics.print(self.index, self.width / 2, self.height / 2)

   --  extra = (width / 4)
   --   ___
   --  /   \ ___ height / 2
   --  \___/ ___ height
   --  |   |
   --  |   +-- width - extra
   --  +-- extra
   --
   -- Points start with upper left (north west), go clockwise.

--   love.graphics.line(NW.x, NW.y, NE.x, NE.y)
--   love.graphics.line(NE.x, NE.y, E.x, E.y)
--   love.graphics.line(E.x, E.y, SE.x, SE.y)
--   love.graphics.line(SE.x, SE.y, SW.x, SW.y)
--   love.graphics.line(SW.x, SW.y, W.x, W.y) 
--   love.graphics.line(W.x, W.y, NW.x, NW.y)

   if(self.revealed == true) then
      for i = 1, #self.tris do
	 self.tris[i]:draw()
      end
      -- Draw Star
      C = {x = self.width / 2, y = self.height / 2}
      love.graphics.setColor(self.center.r, self.center.g, self.center.b)
      love.graphics.circle("fill", C.x, C.y, 5)
   end

   love.graphics.pop()
end

function Hex:containsPoint(x, y)
   shift_x_diff = math.abs(x - self.orig_x)
   shift_y_diff = math.abs(y - self.orig_y)
   extra = (self.width / 4)
   NW = {x = extra, y = 0}
   E = {x = self.width, y = self.height / 2}
   SE = {x = self.width - extra, y = self.height}

   if shift_x_diff <= (SE.x - NW.x) / 2 and shift_y_diff < (SE.y - NW.y) / 2 then
      -- in the center square
      return true
   end

   -- Use SE, E and new Mouse
   mouse = {x = shift_x_diff + self.width / 2, y = shift_y_diff + self.height / 2}
   m = (SE.y - E.y) / (SE.x - E.x)
   b = E.y - m * E.x
   y_hex = m * mouse.x + b

   if (mouse.y < y_hex) then
      -- click is under the line (representing edge of hex)
      -- Point is radial... or reflected... due to symmetry only need to check one point / line
      return true
   end
   return false
end

function Hex:handleMouse(x, y, button)
   if self:containsPoint(x, y) then
      setDetailed(self)
      self.revealed = true
      self.color = {r = 0, g = 30, b = 220}
   else 
      self.color = {r = 220, g = 0, b = 0}
   end
end

function makeHex(o_x, o_y, w, h)
   hex = Hex:new({orig_x = o_x, orig_y = o_y, width = w, height = h, tris = {}})
   hex:initTris()
   return hex
end

function buildThreeLayer(center_x, center_y, width, height)
   map = {}
   x_step = 3 * width / 4
   y_step = height / 2
   hex_index = 1
   -- core
   map[hex_index] = makeHex(center_x, center_y, width, height)
   hex_index = hex_index + 1
   -- layer 1
   map[hex_index] = makeHex(center_x, center_y - height, width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x + x_step, center_y - y_step, width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x + x_step, center_y + y_step, width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x, center_y + hex_height, width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x - x_step, center_y + y_step, width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x - x_step, center_y - y_step, width, height)
   hex_index = hex_index + 1
   -- layer 2
   -- layer 2, North
   map[hex_index] = makeHex(center_x, center_y - (height * 2), width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x + x_step, center_y - (height * 2 - y_step), width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x + 2 * x_step, center_y - (height), width, height)
   hex_index = hex_index + 1
   -- layer 2, East
   map[hex_index] = makeHex(center_x + 2 * x_step, center_y, width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x + 2 * x_step, center_y + (height), width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x + x_step, center_y + (height * 2 - y_step), width, height)
   hex_index = hex_index + 1
   -- layer 2, South
   map[hex_index] = makeHex(center_x, center_y + (height * 2), width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x - x_step, center_y + (height * 2 - y_step), width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x - 2 * x_step, center_y + (height), width, height)
   hex_index = hex_index + 1
   -- layer 2, West
   map[hex_index] = makeHex(center_x - 2 * x_step, center_y, width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x - 2 * x_step, center_y - (height), width, height)
   hex_index = hex_index + 1
   map[hex_index] = makeHex(center_x - x_step, center_y - (height * 2 - y_step), width, height)
   hex_index = hex_index + 1   
   
   for i = 1, #map, 1 do
      map[i].index = i
   end

   return map
end

function buildFourLayer(center_x, center_y, width, height)
   map = buildThreeLayer(center_x, center_y, width, height)
   x_step = 3 * width / 4
   y_step = height / 2
   hex_index = #map + 1

   -- North
   for i = 0, 3, 1 do
      map[hex_index] = makeHex(center_x + i * x_step, center_y - height * 3 + i * y_step, width, height)
      hex_index = hex_index + 1
   end

   -- North East
   for i = 1, 3, 1 do -- 1 so that we skip the last made from North
      map[hex_index] = makeHex(center_x + 3 * x_step, center_y - height * (3 - i) + 3 * y_step, width, height)
      hex_index = hex_index + 1
   end

   -- South East
   for i = 1, 3, 1 do
      map[hex_index] = makeHex(center_x + (3 - i) * x_step, center_y + (3 + i) * y_step, width, height)
      hex_index = hex_index + 1
   end

   -- South
   for i = 1, 3, 1 do
      map[hex_index] = makeHex(center_x - i * x_step, center_y + height * 3 - i * y_step, width, height)
      hex_index = hex_index + 1
   end

   -- South West
   for i = 1, 3, 1 do
      map[hex_index] = makeHex(center_x - 3 * x_step, center_y - height * i + 3 * y_step, width, height)
      hex_index = hex_index + 1
   end

   for i = 1, 2, 1 do -- The first and the last have already been done
      map[hex_index] = makeHex(center_x - (3 - i) * x_step, center_y - (3 + i) * y_step, width, height)
      hex_index = hex_index + 1
   end

   for i = 1, #map, 1 do
      map[i].index = i
   end
   return map
end