-- Clock Module
-- Handles AClock spoon configuration and hotkey binding
-- Shows clock on all monitors with date and time

local clock = {}

-- Store all clock instances
local clock_instances = {}

-- Create a custom clock instance for a specific screen
local function createClockForScreen(screen)
  local clock_instance = {}
  
  -- Create a new canvas for this screen
  clock_instance.canvas = hs.canvas.new({x=0, y=0, w=0, h=0})

  -- Add dark background
  clock_instance.canvas[1] = {
    type = "rectangle",
    fillColor = {hex="#1A1A1A", alpha=1}, -- Dark gray
    strokeColor = {hex="#1A1A1A"}, -- Same as background
    strokeWidth = 0,
    -- Rounded corners
    roundedRectRadii = {xRadius = 20, yRadius = 20}
  }

    -- Configure canvas with time and date
    clock_instance.canvas[2] = {
      type = "text",
      text = "",
      textFont = "SF Pro Display",
      textSize = 120,
      textColor = {hex="#FFFF00"}, -- Bright yellow
      textAlignment = "center",
      -- Add shadow for visibility
      shadow = {
        blurRadius = 8,
        color = {hex="#000000", alpha=0.6},
        offset = {h=3, w=3}
      }
    }

    
  clock_instance.canvas[3] = {
    type = "text",
    text = "",
    textFont = "SF Pro Display",
    textSize = 36,
    textColor = {hex="#FFD700"}, -- Golden yellow
    textAlignment = "center",
    -- Add shadow for visibility
    shadow = {
      blurRadius = 6,
      color = {hex="#000000", alpha=0.5},
      offset = {h=2, w=2}
    }
  }
  
  -- Position the clock on the specific screen
  local function getFrameForScreen(width, height, targetScreen)
    local screenFrame = targetScreen:fullFrame()
    return {
      x = screenFrame.x + (screenFrame.w - width) / 2,
      y = screenFrame.y + (screenFrame.h - height) / 2,
      w = width,
      h = height
    }
  end
  
  clock_instance.width = 400
  clock_instance.height = 280
  clock_instance.timeFormat = "%H:%M"
  clock_instance.dateFormat = "%A, %B %d, %Y"
  clock_instance.showDuration = 4
  
  -- Update canvas position for this screen
  function clock_instance:updateCanvas()
    local frame = getFrameForScreen(self.width, self.height, screen)
    self.canvas:frame(frame)
    
    -- Update background rectangle to fill the entire canvas
    self.canvas[1].frame = {x=0, y=0, w=self.width, h=self.height}
    
    -- Position time text (larger, top)
    self.canvas[2].frame = {x=0, y=20, w=self.width, h=140}
    
    -- Position date text (smaller, bottom)
    self.canvas[3].frame = {x=0, y=160, w=self.width, h=100}
  end
  
  -- Update clock text
  function clock_instance:updateClockText()
    self.canvas[2].text = os.date(self.timeFormat)
    self.canvas[3].text = os.date(self.dateFormat)
  end
  
  -- Start tick timer
  function clock_instance:startTickTimer()
    self.tick_timer = hs.timer.doEvery(1, function() self:updateClockText() end)
  end
  
  -- Stop tick timer
  function clock_instance:stopTickTimer()
    if self.tick_timer then
      self.tick_timer:stop()
      self.tick_timer = nil
    end
  end
  
  -- Show clock on this screen
  function clock_instance:show()
    self:updateClockText()
    self:updateCanvas()
    self.canvas:show()
    self:startTickTimer()
  end
  
  -- Hide clock on this screen
  function clock_instance:hide()
    self.canvas:hide()
    self:stopTickTimer()
  end
  
  -- Check if clock is showing on this screen
  function clock_instance:isShowing()
    return self.canvas:isShowing()
  end
  
  -- Initialize the clock for this screen
  clock_instance:updateCanvas()
  
  return clock_instance
end

-- Initialize clocks for all screens
local function initializeClocks()
  local screens = hs.screen.allScreens()
  
  for _, screen in ipairs(screens) do
    local clock_instance = createClockForScreen(screen)
    table.insert(clock_instances, clock_instance)
  end
  
  -- Watch for screen changes and update clocks
  local screen_watcher = hs.screen.watcher.new(function()
    -- Reinitialize clocks when screens change
    for _, clock_instance in ipairs(clock_instances) do
      clock_instance:hide()
    end
    clock_instances = {}
    initializeClocks()
  end)
  screen_watcher:start()
end

function clock.init(clockMods, clockKey)
  -- Initialize clocks for all screens
  initializeClocks()
  
  -- Bind clock toggle hotkey
  hs.hotkey.bind(clockMods, clockKey, function()
    local anyShowing = false
    
    -- Check if any clock is showing
    for _, clock_instance in ipairs(clock_instances) do
      if clock_instance:isShowing() then
        anyShowing = true
        break
      end
    end
    
    if anyShowing then
      -- Hide all clocks
      for _, clock_instance in ipairs(clock_instances) do
        clock_instance:hide()
      end
    else
      -- Show all clocks
      for _, clock_instance in ipairs(clock_instances) do
        clock_instance:show()
      end
      
      -- Auto-hide after duration
      hs.timer.doAfter(clock_instances[1].showDuration, function()
        for _, clock_instance in ipairs(clock_instances) do
          clock_instance:hide()
        end
      end)
    end
  end)
end

return clock 