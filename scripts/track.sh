#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

track=""

print_music_track() {
  local trackInfo
  trackInfo=$(osascript "./track.applescript")
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
