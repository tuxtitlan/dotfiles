alias npx='pnpx'
alias chrome='open -a "google chrome.app"'
alias diff=colordiff
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
alias l='exa $LS_OPTIONS -l'
alias ll='exa $LS_OPTIONS -la'
alias ls='exa $LS_OPTIONS'
alias pdfcombine='"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py"'
alias pgrep='pgrep -f -l'
alias pkill='pkill -f -l'
alias reset-wifi='networksetup -setairportpower en0 off && networksetup -setairportpower en0 on'
alias rm='rm -i'
alias syspip-sync='PIP_REQUIRE_VIRTUALENV=false pip-sync'
alias top='top -s 5 -o cpu -stats pid,user,command,cpu,rsize,vsize,threads,state'

alias start-docker='open -ga Docker'
alias stop-docker='osascript -e '\''quit app "Docker"'\'
alias restart-docker='stop-docker && start-docker'

if hash mvim 2>/dev/null; then
  if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
    alias vi='open -a MacVim'
  fi
fi
