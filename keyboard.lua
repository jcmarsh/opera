-- Handle the keyboard input
-- Meant to handle typing (as opposed to controller)

shift_pressed = false -- left and right shift
ctrl_pressed = false  -- left and right
atl_pressed = false -- left and right

-- On key press, we only care about updating the shift / alt / ctrl key states
function keyboard_pressed(key)
   if key == 'lshift' or key == 'rshift' then
      shift_pressed = true
   end
   if key == 'lctrl' or key == 'rctrl' then
      ctrl_pressed = true
   end
   if key == 'lalt' or key == 'ralt' then
      alt_pressed = true
   end
end

shifted = {["`"] = "~",
	   ["1"] = "!",
	   ["2"] = "@",
	   ["3"] = "#",
	   ["4"] = "$",
	   ["5"] = "%",
	   ["6"] = "^",
	   ["7"] = "&",
	   ["8"] = "*",
	   ["9"] = "(",
	   ["0"] = ")",
	   ["-"] = "_",
	   ["="] = "+",
	   ["["] = "{",
	   ["]"] = "}",
	   ["\\"] = "|",
	   [";"] = ":",
	   ["'"] = "\"",
	   [","] = "<",
	   ["."] = ">",
	   ["/"] = "?"}	   

-- Apply shift to keys
function keyboard_released(key)
   if key == 'lshift' or key == 'rshift' then
      shift_pressed = false
      return
   end
   if key == 'lctrl' or key == 'rctrl' then
      ctrl_pressed = false
      return
   end
   if key == 'lalt' or key == 'ralt' then
      alt_pressed = false
      return
   end

   if shift_pressed then
      if shifted[key] ~= nil then
	 return shifted[key]
      else
	 return key:upper()
      end
   else
      return key
   end

end