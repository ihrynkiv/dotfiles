-- Clipboard Manager Module
-- Stores clipboard history and provides search/paste functionality

local clipboard_manager = {}

-- Configuration
local MAX_HISTORY = 20  -- Maximum number of items to store
local CLIPBOARD_TIMEOUT = 0.5  -- Debounce time for clipboard changes
local SEARCH_TIMEOUT = 0.3  -- Search debounce time

-- Storage
local clipboard_history = {}
local chooser = nil
local clipboard_watcher = nil
local last_clipboard = ""

-- Utility: Truncate text for display
local function truncateText(text, maxLength)
  if #text <= maxLength then
    return text
  end
  return text:sub(1, maxLength - 3) .. "..."
end

-- Utility: Clean text for storage
local function cleanText(text)
  if not text then return "" end
  -- Remove extra whitespace
  text = text:gsub("%s+", " ")
  text = text:gsub("^%s*(.-)%s*$", "%1")
  return text
end

-- Add item to clipboard history
local function addToHistory(text)
  if not text or text == "" then return end
  
  text = cleanText(text)
  if text == last_clipboard then return end
  
  -- Remove if already exists (to move to top)
  for i, item in ipairs(clipboard_history) do
    if item.text == text then
      table.remove(clipboard_history, i)
      break
    end
  end
  
  -- Add to beginning
  table.insert(clipboard_history, 1, {
    text = text,
    timestamp = os.time(),
    preview = truncateText(text, 60)
  })
  
  -- Keep only MAX_HISTORY items
  if #clipboard_history > MAX_HISTORY then
    table.remove(clipboard_history)
  end
  
  last_clipboard = text
end

-- Get clipboard history as chooser choices
local function getChoices(searchText)
  local choices = {}
  
  for i, item in ipairs(clipboard_history) do
    local shouldInclude = true
    
    -- Filter by search text if provided
    if searchText and searchText ~= "" then
      shouldInclude = item.text:lower():find(searchText:lower(), 1, true)
    end
    
    if shouldInclude then
      local timeAgo = os.time() - item.timestamp
      local timeStr = ""
      
      if timeAgo < 60 then
        timeStr = "just now"
      elseif timeAgo < 3600 then
        timeStr = math.floor(timeAgo / 60) .. "m ago"
      else
        timeStr = math.floor(timeAgo / 3600) .. "h ago"
      end
      
      table.insert(choices, {
        text = item.preview,
        subText = timeStr,
        fullText = item.text,
        index = i
      })
    end
  end
  
  return choices
end

-- Handle clipboard selection
local function handleClipboardChoice(choice)
  if choice and choice.fullText then
    -- Set the clipboard
    hs.pasteboard.setContents(choice.fullText)
    
    -- Paste the content
    hs.eventtap.keyStroke({"cmd"}, "v", 0)
    
    -- Move selected item to top of history
    if choice.index then
      local item = table.remove(clipboard_history, choice.index)
      if item then
        table.insert(clipboard_history, 1, item)
      end
    end
  end
end

-- Watch for clipboard changes
local function startClipboardWatcher()
  clipboard_watcher = hs.timer.new(CLIPBOARD_TIMEOUT, function()
    local current = hs.pasteboard.getContents()
    if current and current ~= last_clipboard then
      addToHistory(current)
    end
  end)
  clipboard_watcher:start()
end

-- Initialize clipboard manager
function clipboard_manager.init(hotkeyMods, hotkeyKey)
  -- Create the chooser
  chooser = hs.chooser.new(handleClipboardChoice)
  
  -- Configure the chooser
  chooser:placeholderText("Search clipboard history...")
  chooser:rows(12)
  
  -- Bind hotkey to show clipboard manager
  hs.hotkey.bind(hotkeyMods, hotkeyKey, function()
    if chooser:isVisible() then
      chooser:hide()
    else
      local choices = getChoices("")
      chooser:choices(choices)
      chooser:show()
    end
  end)
  
  -- Start watching clipboard
  startClipboardWatcher()
  
  -- Add search functionality
  chooser:queryChangedCallback(function(query)
    local choices = getChoices(query)
    chooser:choices(choices)
  end)
end

-- Get clipboard history (for debugging)
function clipboard_manager.getHistory()
  return clipboard_history
end

-- Clear clipboard history
function clipboard_manager.clearHistory()
  clipboard_history = {}
end

-- Add manual entry to history
function clipboard_manager.addEntry(text)
  addToHistory(text)
end

return clipboard_manager 