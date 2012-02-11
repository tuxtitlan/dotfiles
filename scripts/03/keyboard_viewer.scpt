set proc_ to "\"/System/Library/Input Methods/KeyboardViewer.app/Contents/MacOS/KeyboardViewer\""
set app_ to "KeyboardViewer"
try
  do shell script "ps -axwww | grep" & space & proc_ & space & "| grep -v grep"
  tell application app_ to quit
on error
  do shell script proc_ & space & "> /dev/null 2>&1 &"
end try
