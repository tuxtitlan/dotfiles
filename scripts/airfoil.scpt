property utils : load script POSIX file "/Users/george/.scripts/utils.scpt"

on changeVolume(amount)
  tell utils
    if appIsRunning("Airfoil") then
      tell application "Airfoil"
        repeat with s in speakers
          if (connected of s) then
            set vol to max(min((volume of s) + amount, 1) of utils, 0) of utils
            set (volume of s) to vol
          end if
        end repeat
      end tell
    end if
  end tell
end changeVolume

on mute()
    tell utils
        if appIsRunning("Airfoil") then
            set currentApp to GetCurrentApp()
            activate application "Airfoil"
            try
                tell application "System Events"
                    click menu item ¬
                        "Mute" in menu "Speakers" of menu bar item ¬
                        "Speakers" in menu bar 1 of process "Airfoil"
                end tell
            end try
            activate application currentApp
        end if
    end tell
end mute
