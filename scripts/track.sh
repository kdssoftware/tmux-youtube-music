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
                tell t
                    set YTtitle to execute javascript "var element = document.querySelector('.title.style-scope.ytmusic-player-bar'); if (element) {element.getAttribute('title')} else {'Nothing playing'}"
                end tell
                tell t
                    set YTbyline to execute javascript "var element = document.querySelector('.byline.style-scope.ytmusic-player-bar'); if (element) {element.getAttribute('title')} else {'Unknown artist'}"
                end tell
            end if
        end repeat
    end repeat
end tell

if YTtitle is not equal to "" then
    return YTtitle & " by " & YTbyline
else
    return "Nothing playing"
end if
END

osascript -e "${SCRIPT}"
}

print_music_track() {
  local trackInfo
  trackInfo=$(music_track)
  # Remove any unneeded strings
  trackInfo=$(echo "$trackInfo" | sed -E 's/• .+ views//g; s/• .+ likes//g; s/ - YouTube Music//g; s/, YouTube Music//g; s/YouTube Music, //g')
  # trim spaces
  trackInfo=$(echo "$trackInfo" | sed 's/[[:space:]]*$//')

  echo "$trackInfo"
}

update_track() {
  track=$(get_tmux_option "@youtube_music_track" "$track")
}

main() {
  update_track
  print_music_track
}

main
