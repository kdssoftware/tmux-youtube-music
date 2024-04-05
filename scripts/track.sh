#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

track=""

music_track() {
read -r -d '' SCRIPT <<END
tell application "Google Chrome"
    set tabNames to {}
    set titleOfPlayingSong to ""
    
    repeat with w in windows
        repeat with t in tabs of w
            set tabTitle to title of t
            if tabTitle ends with "YouTube Music" then
                set end of tabNames to tabTitle
                
                tell t
                    execute javascript "var element = document.querySelector('.byline.style-scope.ytmusic-player-bar'); var title = (element && element.getAttribute('title')) || 'Nothing playing'; title;"
                    set titleOfPlayingSong to result
                end tell
            end if
        end repeat
    end repeat
end tell

return {tabTitle,titleOfPlayingSong}
END

osascript -e "${SCRIPT}"
}

print_music_track() {
  local tab_and_title
  tab_and_title=$(music_track)
  local cleaned_tab_title
  cleaned_tab_title=$(echo "$tab_and_title" | sed -E 's/• .+ views//g; s/• .+ likes//g; s/ - YouTube Music//g; s/, YouTube Music//g; s/YouTube Music, //g')
  cleaned_tab_title=$(echo "$cleaned_tab_title" | sed 's/[[:space:]]*$//')
  echo "$cleaned_tab_title"
}

update_track() {
  track=$(get_tmux_option "@youtube_music_track" "$track")
}

main() {
  update_track
  print_music_track
}

main
