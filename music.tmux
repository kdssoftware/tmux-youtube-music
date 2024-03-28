#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"

track="#($CURRENT_DIR/scripts/track.sh)"

track_interpolation="\#{track}"

#Backwards compatibility
youtube_music_track=track

youtube_music_track_interpolation=track_interpolation

do_interpolation() {
  local output="$1"
  local output="${output/$track_interpolation/$track}"
  echo "$output"
}

update_tmux_uptime() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_uptime "status-right"
  update_tmux_uptime "status-left"
}
main
