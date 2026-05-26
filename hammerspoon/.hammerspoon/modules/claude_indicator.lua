local M = {}

local canvases = {}
local hideTimer = nil

local size = 14
local margin = 20

local function buildCanvases()
  for _, c in ipairs(canvases) do c:delete() end
  canvases = {}

  for _, screen in ipairs(hs.screen.allScreens()) do
    local frame = screen:frame()
    local x = frame.x + frame.w - size - margin
    local y = frame.y + margin

    local c = hs.canvas.new({ x = x, y = y, w = size, h = size })
    c[1] = {
      type = "circle",
      fillColor = { red = 1.0, green = 0.5, blue = 0.1, alpha = 0.9 },
      strokeColor = { alpha = 0 },
      frame = { x = 0, y = 0, w = size, h = size },
    }
    c:level(hs.canvas.windowLevels.overlay)
    canvases[#canvases + 1] = c
  end
end

local function showDot()
  if hideTimer then hideTimer:stop() end
  if #canvases == 0 then buildCanvases() end

  for _, c in ipairs(canvases) do c:show() end

  hideTimer = hs.timer.doAfter(5, function()
    for _, c in ipairs(canvases) do c:hide() end
  end)
end

hs.urlevent.bind("claudedone", function() showDot() end)

hs.screen.watcher.new(function() buildCanvases() end):start()

return M
