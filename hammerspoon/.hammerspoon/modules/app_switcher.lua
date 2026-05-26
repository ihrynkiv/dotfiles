-- App Switcher Module
-- Allows quick switching between any running applications

local app_switcher = {}

-- Store the chooser instance
local chooser = nil

-- List of apps that already have hotkeys (from app_manager)
local appsWithHotkeys = {
	"Arc",
	"Zed",
	"Claude",
	"Telegram",
	"Postman",
	"IntelliJ IDEA",
	"iTerm2",
	"Spotify",
	"Slack",
	"Obsidian",
	"zoom.us",
	"Ghostty",
	-- "System Process"
	"Notification Center",
}

-- Check if app should be excluded
local function shouldExcludeApp(appName)
	-- Check if it already has a hotkey
	for _, hotkeyApp in ipairs(appsWithHotkeys) do
		if appName == hotkeyApp then
			return true
		end
	end

	return false
end

-- Get list of apps that have windows open
local function getAppsWithWindows()
	local apps = {}
	local appNames = {}

	-- Get all windows and collect unique app names
	local allWindows = hs.window.allWindows()

	for _, window in ipairs(allWindows) do
		local app = window:application()
		if app and app:isRunning() then
			local appName = app:name()

			-- Only add if not already added and not excluded
			if not appNames[appName] and not shouldExcludeApp(appName) then
				appNames[appName] = true

				table.insert(apps, {
					text = appName,
					subText = "Application with open windows",
					app = app,
				})
			end
		end
	end

	-- Sort alphabetically
	table.sort(apps, function(a, b)
		return a.text < b.text
	end)

	return apps
end

-- Focus the selected app
local function focusSelectedApp(choice)
	if choice and choice.app then
		choice.app:activate()

		-- Center mouse on the focused window
		local focusedWindow = choice.app:mainWindow()
		if focusedWindow then
			local frame = focusedWindow:frame()
			local center = hs.geometry.rectMidPoint(frame)
			hs.mouse.absolutePosition(center)
		end
	end
end

function app_switcher.init(hotkeyMods, hotkeyKey)
	-- Create the chooser
	chooser = hs.chooser.new(focusSelectedApp)

	-- Configure the chooser
	chooser:placeholderText("Select an app with open windows...")
	chooser:rows(10) -- Show 10 rows

	-- Bind hotkey to show app switcher
	hs.hotkey.bind(hotkeyMods, hotkeyKey, function()
		if chooser:isVisible() then
			chooser:hide()
		else
			local apps = getAppsWithWindows()
			chooser:choices(apps)
			chooser:show()
		end
	end)
end

return app_switcher

