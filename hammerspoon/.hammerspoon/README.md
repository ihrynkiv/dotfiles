# Hammerspoon Modular Configuration

This is a modular Hammerspoon configuration that organizes functionality into separate modules for better maintainability and organization.

## Structure

```
.hammerspoon/
├── init.lua              # Main entry point - loads and initializes modules
├── modules/              # Module directory
│   ├── app_manager.lua   # Application launching and window management
│   ├── app_switcher.lua  # Search-based application switcher
│   ├── clipboard_manager.lua # Clipboard history and management
│   ├── window_manager.lua # Window positioning and screen switching
│   ├── hotkeys.lua       # Hotkey modifier definitions
│   └── clock.lua         # AClock spoon configuration
└── Spoons/               # Hammerspoon spoons
    └── AClock.spoon/     # Clock spoon
```

## Modules

### 1. `modules/hotkeys.lua`
Defines all hotkey modifiers and key combinations used across the configuration.

**Key configurations:**
- `hyper`: Alt key for app launching
- `moveFocusMod`: Ctrl+Alt for moving apps between screens
- `clockMods`: Cmd+Alt+Ctrl for clock toggle
- `screenMods`: Ctrl+Shift for screen switching

### 2. `modules/app_manager.lua`
Handles application launching, focusing, and window management.

**Features:**
- App launching with hotkeys (Alt + key)
- Moving apps between screens (Ctrl+Alt + key)
- Special handling for iTerm2 (creates new window if none exist)
- Mouse centering on focused windows

**Configured apps:**
- B: Arc
- C: Cursor
- I: IntelliJ IDEA
- T: iTerm
- M: Spotify
- S: Slack
- O: Obsidian
- Z: Zoom

### 3. `modules/window_manager.lua`
Manages window positioning, maximizing, and screen switching.

**Features:**
- Automatic window maximizing for new windows
- Screen switching with Ctrl+Shift+Right
- Mouse centering after window operations

### 4. `modules/clock.lua`
Handles AClock spoon configuration and hotkey binding.

**Features:**
- Loads AClock spoon
- Binds clock toggle to Cmd+Alt+Ctrl+C

### 5. `modules/app_switcher.lua`
Provides a search-based application switcher.

**Features:**
- Search through running applications with open windows
- Quick app switching with Cmd+Alt+S
- Excludes apps that already have dedicated hotkeys
- Mouse centering on selected app

### 6. `modules/clipboard_manager.lua`
Manages clipboard history and provides search/paste functionality.

**Features:**
- Automatic clipboard history storage (up to 50 items)
- Search through clipboard history
- Quick paste from history with Cmd+Alt+V
- Timestamp tracking for each clipboard item
- Automatic deduplication and reordering

## Usage

The configuration is automatically loaded when Hammerspoon starts. Each module is initialized in the main `init.lua` file.

## Customization

### Adding New Apps
Edit `modules/app_manager.lua` and add new entries to the `apps` table:

```lua
local apps = {
  B = "Arc",
  C = "Cursor",
  -- Add your new app here
  N = "New App",
}
```

### Modifying Hotkeys
Edit `modules/hotkeys.lua` to change modifier keys:

```lua
hotkeys.hyper = {"cmd", "alt"}  -- Change from just Alt to Cmd+Alt
```

### Adding New Modules
1. Create a new file in the `modules/` directory
2. Define your module with an `init()` function
3. Load and initialize it in `init.lua`

Example:
```lua
-- modules/new_module.lua
local new_module = {}

function new_module.init()
  -- Your initialization code here
end

return new_module

-- In init.lua, add:
local new_module = require("modules.new_module")
new_module.init()
```

## Benefits of Modular Structure

1. **Maintainability**: Each feature is isolated in its own module
2. **Reusability**: Modules can be easily shared or reused
3. **Debugging**: Easier to identify and fix issues in specific functionality
4. **Extensibility**: Simple to add new features without cluttering the main file
5. **Organization**: Clear separation of concerns

## Troubleshooting

If you encounter issues:
1. Check the Hammerspoon console for error messages
2. Verify all module files exist in the `modules/` directory
3. Ensure proper syntax in each module file
4. Test modules individually by commenting out others in `init.lua` 