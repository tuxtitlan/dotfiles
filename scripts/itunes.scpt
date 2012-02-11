property utils : load script POSIX file "/Users/george/.scripts/utils.scpt"

on changeVolume(amount)
  tell utils
    if appIsRunning("iTunes") then
      tell application "iTunes"
        if player state is playing then
          set sound volume to sound volume + amount
        end if
      end tell
    end if
  end tell
end changeVolume
