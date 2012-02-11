property utils : load script POSIX file "/Users/george/.scripts/utils.scpt"

tell utils
  if appIsRunning("Rdio") then
    tell application "Rdio"
      if player state is paused then
        play
      else if player state is playing then
        pause
      end if
    end tell
  end if
end tell
