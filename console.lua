Console = {lines = {}, width = 100, height = 100, line_height = 12, margin = 3}

function Console:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   return o
end

function Console:draw()
   love.graphics.push()
   love.graphics.setColor(200, 200, 200)

   for i = 1, #self.lines, 1 do
      love.graphics.print(self.lines[i], self.margin, i * self.line_height)
   end

   love.graphics.pop()
end

function Console:handleMouse(x, y, button)

end

function Console:println(line)
   -- Need to truncate lines ... maybe
   num_lines = math.floor((self.height - (2 * self.margin)) / self.line_height) - 1
   if num_lines > #self.lines then -- Add line to the bottom
      self.lines[#self.lines + 1] = line
   else                            -- Console full; shift everything up
      for i = 1, #self.lines - 1, 1 do
	 self.lines[i] = self.lines[i + 1]
      end
      self.lines[#self.lines] = line
   end
end