export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=10000
export HISTIGNORE="&:?:??:exit:history:[j ]*:tmux"
export HISTSIZE=1000
shopt -s histappend
bind '"\e[A"':history-search-backward # up arrow
bind '"\e[B"':history-search-forward  # down arrow
