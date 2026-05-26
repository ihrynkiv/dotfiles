-- Hammerspoon Configuration
-- Modular configuration structure

-- Load modules
local hotkeys = require("modules.hotkeys")
local app_manager = require("modules.app_manager")
local window_manager = require("modules.window_manager")
local clock = require("modules.clock")
local app_switcher = require("modules.app_switcher")
local clipboard_manager = require("modules.clipboard_manager")
local claude_indicator = require("modules.claude_indicator")

-- Initialize modules
app_manager.init(hotkeys.hyper)
window_manager.init(hotkeys.hyper)

clock.init(hotkeys.hyper, hotkeys.clockKey)
app_switcher.init(hotkeys.hyper, hotkeys.appSwitcherKey)
clipboard_manager.init(hotkeys.hyper, hotkeys.clipboardKey)

