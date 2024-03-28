get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

set_tmux_option() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "$option" "$value"
}

current_track_property() {
  local prop="${1}"
read -r -d '' SCRIPT <<END
tell application "System Events"
    tell process "TIDAL"
        set menuItems to name of menu items of menu "Window" of menu bar 1
        set lastMenuItem to item -1 of menuItems
    end tell
end tell

return lastMenuItem as string
END

osascript -e "$(printf "${SCRIPT}" "$prop")"
}
