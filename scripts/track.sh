#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

track=""

music_track() {
read -r -d '' SCRIPT <<END
tell application "Google Chrome"
    set tabNames to {}
    repeat with w in windows
        repeat with t in tabs of w
            set tabTitle to title of t
            if tabTitle ends with "YouTube Music" then
                set end of tabNames to tabTitle
            end if
        end repeat
    end repeat
end tell

return tabNames
END

osascript -e "${SCRIPT}"
}

print_music_track() {
  local track=$(music_track)
  echo $track
}

update_track() {
  track=$(get_tmux_option "@youtube_music_track" "$track")
}

main() {
  update_track
  print_music_track
}

main
