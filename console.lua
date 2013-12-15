Console = {displayed = {}, console = "> ", typed = "", functions = {}, width = 100, height = 100, line_height = 12, margin = 3, grab_keyboard = false}

function Console:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   self:registerFunction("help", self.help)
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
   self.grab_keyboard = true
end

function Console:println(line)
   -- Need to truncate lines ... maybe
   num_lines = math.floor((self.height - (2 * self.margin)) / self.line_height) - 1 - 1
   if num_lines > #self.lines then -- Add line to the bottom
      if self.lines[#self.lines] == (self.console .. self.typed) then
	 self.lines[#self.lines] = line
      else
	 self.lines[#self.lines + 1] = line
      end
      self.lines[#self.lines + 1] = self.console .. self.typed
   else                            -- Console full; shift everything up
      for i = 1, #self.lines - 2, 1 do
	 self.lines[i] = self.lines[i + 1]
      end
      self.lines[#self.lines - 1] = line
      self.lines[#self.lines] = self.console .. self.typed
   end
end

function Console:processKey(key)
   if key ~= "return" then
      self.typed = self.typed .. key
   else
      -- Process command
      self:println(self.console .. self.typed)
      if self.functions[self.typed] == nil then
	 self:println("No such function: " .. self.typed)
      else
	 self.functions[self.typed](self)
      end
      self.typed = ""      
   end
   self.lines[#self.lines] = self.console .. self.typed
end

function Console:registerFunction(name, func)
   self.functions[name] = func
end

function Console:help()
   self:println("This is a \"helpful\" help message")
end