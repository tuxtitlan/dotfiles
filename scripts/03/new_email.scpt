tell application "Mail"
  make new outgoing message with properties {visible:true}
  activate
  tell application "System Events" to tell process "Mail"
    if menu item "Make Plain Text" of menu 1 of menu bar item ¬
      "Format" of menu bar 1 exists then
      keystroke "t" using {shift down, command down} -- "Make Plain Text"
    end if
  end tell
end tell
