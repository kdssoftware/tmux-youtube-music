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
