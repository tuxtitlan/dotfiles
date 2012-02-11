# General utilities
on appIsRunning(appName)
  tell application "System Events" to (name of processes) contains appName
end appIsRunning

on GetCurrentApp()
  tell application "System Events" to ¬
    get short name of first process whose frontmost is true
end GetCurrentApp

on min(x, y)
  if x ≤ y then
    return x
  else
    return y
  end if
end min

on max(x, y)
  if x ≥ y then
    return x
  else
    return y
  end if
end max
