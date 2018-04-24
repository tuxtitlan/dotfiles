# shellcheck source=/dev/null
hash brew 2>/dev/null \
  && [[ -f $(brew --prefix)/share/bash-completion/bash_completion ]] \
  && source "$(brew --prefix)"/share/bash-completion/bash_completion
