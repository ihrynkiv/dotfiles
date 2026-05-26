-- App Manager Module
-- Handles application launching, focusing, and window management

local app_manager = {}

-- Utility: Move mouse to window center
local function centerMouse(win)
	if win then
		local frame = win:frame()
		local center = hs.geometry.rectMidPoint(frame)
		hs.mouse.absolutePosition(center)
	end
end

-- Core logic to move/focus/launch app
local function handleApp(appName)
	local focusedWindow = hs.window.focusedWindow()
	local mousePos = hs.mouse.absolutePosition()
	local targetScreen = focusedWindow and focusedWindow:screen() or hs.screen.mainScreen():closestToPoint(mousePos)

	local app = hs.application.get(appName)

	local function focusAndMove(win)
		if win then
			win:focus()
			centerMouse(win)
		end
	end

	if app and app:isRunning() then
		local win = app:mainWindow()

		if win then
			focusAndMove(win)
		else
			app:activate()
		end
	else
		hs.application.launchOrFocus(appName)

		hs.timer.doAfter(0.6, function()
			local launchedApp = hs.application.get(appName)
			if launchedApp then
				local win = launchedApp:mainWindow()
				focusAndMove(win)
			end
		end)
	end
end

-- App list with hotkeys
local apps = {
	A = "Claude",
	B = "Arc",
	C = "Zed",
	D = "Telegram",
	I = "IntelliJ IDEA",
	T = "Ghostty",
	M = "Spotify",
	S = "Slack",
	O = "Obsidian",
	P = "Postman",
	Z = "zoom.us",
}

function app_manager.init(hyper)
	-- Bind hotkeys for app launching
	for key, appName in pairs(apps) do
		hs.hotkey.bind(hyper, key, function()
			handleApp(appName, false)
		end)
	end
end

function app_manager.centerMouse(win)
	centerMouse(win)
end

return app_manager
