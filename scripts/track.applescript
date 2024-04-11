tell application "Google Chrome"
    set tabNames to {}
    set titleOfPlayingSong to ""
    
    repeat with w in windows
        repeat with t in tabs of w
            set tabTitle to title of t
            if tabTitle ends with "YouTube Music" then
                tell t
                    execute javascript "var element = document.querySelector('.title.style-scope.ytmusic-player-bar'); var title = (element && element.getAttribute('title')) || 'Nothing playing'; title;"
                    set YTtitle to result
                end tell
                tell t
                    execute javascript "var element = document.querySelector('.byline.style-scope.ytmusic-player-bar'); var title = (element && element.getAttribute('title')) || 'Nothing playing'; title;"
                    set YTbyline to result
                end tell
            end if
        end repeat
    end repeat
end tell

return YTtitle & " by " & YTbyline
