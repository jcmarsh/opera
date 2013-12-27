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

-- Apply shift to keys
function keyboard_released(key, unicode)
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
      return key:upper()
   else
      return key
   end
end