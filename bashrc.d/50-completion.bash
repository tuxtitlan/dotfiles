###########################
# History and Completions #

export HISTIGNORE="&:ls:l:la:ll:exit"
bind '"\e[A"':history-search-backward # up arrow
bind '"\e[B"':history-search-forward  # down arrow

[[ -f $(brew --prefix)/share/bash-completion/bash_completion ]] && \
  source $(brew --prefix)/share/bash-completion/bash_completion

complete -W "$(teamocil --list)" teamocil

 LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
 if [ -f $LUNCHY_DIR/lunchy-completion.bash ]; then
   . $LUNCHY_DIR/lunchy-completion.bash
 fi
