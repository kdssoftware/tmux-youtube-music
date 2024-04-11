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
