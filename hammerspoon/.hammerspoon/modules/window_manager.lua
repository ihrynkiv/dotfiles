-- Window Manager Module
-- Handles window positioning, maximizing, and screen switching

local window_manager = {}

-- Move active window to the next monitor
local function moveWindowToNextScreen()
  local win = hs.window.focusedWindow()
  if not win then return end

  local currentScreen = win:screen()
  local nextScreen = currentScreen:next()

  win:moveToScreen(nextScreen)
  win:focus()

  -- Center the mouse in the moved window
  local frame = win:frame()
  local center = hs.geometry.rectMidPoint(frame)
  hs.mouse.absolutePosition(center)
end

-- Resize new windows to full screen dimensions (but not native fullscreen)
local function maximizeNewWindow(win)
  if win:isStandard() then
    win:maximize()
  end
end

function window_manager.init(hyperKey)
  -- Move active window to the next monitor
  hs.hotkey.bind(hyperKey, "Right", function()
    moveWindowToNextScreen()
  end)

  hs.hotkey.bind(hyperKey, "Left", function()
    moveWindowToNextScreen()
  end)
end

return window_manager 