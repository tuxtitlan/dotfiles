activate application "BusyCal"
try
  tell application "System Events"
    click menu item ¬
      "New Event" in menu "File" of menu bar item ¬
      "File" in menu bar 1 of process "BusyCal"
  end tell
end try
