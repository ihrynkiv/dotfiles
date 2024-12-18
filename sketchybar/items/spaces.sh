#!/bin/bash

# Add event to subscribe
sketchybar --add event aerospace_workspace_change

# Define your spaces with names and corresponding Nerd Font icons
SPACES=("Home:Home:Home" "Web:B:Arc" "IDEA:I:IntelliJ IDEA" "Slack:S:Slack" "Music:M:Spotify" "Terminal:T:Terminal" "Obsidian:O:Obsidian" "Zoom:Z:zoom.us")

# Add and configure spaces
for SPACE in "${SPACES[@]}"; do
  WORKSPACE_NAME=${SPACE%%:*} # Extract name (everything before ':')
  ICON=${SPACE##*:}           # Extract icon (everything after ':')
  # Everything before the first colon

  # Extract the part between the colons
  TITLE=${SPACE#*:}  # Remove everything before the first colon
  TITLE=${TITLE%%:*} # Now remove everything after the next colon, leaving the middle part

  sketchybar --add item "workspace.$WORKSPACE_NAME" left \
    --subscribe "workspace.$WORKSPACE_NAME" aerospace_workspace_change \
    --set "workspace.$WORKSPACE_NAME" \
    icon.font="sketchybar-app-font:Regular:16.0" \
    script="$PLUGIN_DIR/front_app.sh" \
    label="$TITLE" \
    icon="$(
      $CONFIG_DIR/plugins/icon_map_fn.sh "$ICON"
    )" \
    click_script="aerospace workspace $WORKSPACE_NAME" \
    script="$PLUGIN_DIR/aerospace.sh $WORKSPACE_NAME"
done
