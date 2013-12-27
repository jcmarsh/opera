Console = {displayed = {}, console = "> ", typed = "", functions = {}, width = 100, height = 100, line_height = 12, margin = 3, grab_keyboard = false}

function Console:new(o)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   self:registerFunction("help", self.help)
   self:registerFunction("set", self.set)
   self:registerFunction("test", self.test)
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
   if key == nil then
      return
   end
   if key ~= "return" then
      self.typed = self.typed .. key
   else
      -- Process command
      cmd, args = self:parseCmd(self.typed)
      if cmd == nil then -- blank line
	 self:println(self.console)
      elseif self.functions[cmd] == nil then
	 self:println("No such function: " .. cmd)
      else
	 self:println(self.console .. self.typed)
	 self.functions[cmd](self, args)
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

function Console:parseCmd(line)
   cmd = nil
   args = {}
   for w in line:gmatch("%w+") do
      if cmd == nil then
	 cmd = w
      else
	 args[#args + 1] = w
      end
   end

   return cmd, args
end

function Console:set(args)
   table = _G
   for i = 1, #args - 1, 1 do
      table = table[args[i]]
   end
   
   -- TODO: So.. this works but it doesn't update anything!
   table = tonumber(args[#args])
end

function Console:test(args)
   table = _G

   self.printTable(table)
   for i = 1, #args, 1 do
      table = table[args[i]]
      self.printTable(table)
   end
end

function Console.printTable(table)
   print(table)
   for k, v in pairs(table) do
      print("\t", k, "\t", v)
   end
end