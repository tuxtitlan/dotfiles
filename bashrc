# shellcheck disable=SC1090
# Workaround for https://github.com/creationix/nvm/issues/1652
PATH="/usr/local/bin:$(getconf PATH)"
[[ -f ~/.bashrc.d/secrets ]] && . ~/.bashrc.d/secrets
[[ -f ~/.bashrc.d/homebrew ]] && . ~/.bashrc.d/homebrew
[[ -f ~/.bashrc.d/prompt ]] && . ~/.bashrc.d/prompt
[[ -f ~/.bashrc.d/aliases ]] && . ~/.bashrc.d/aliases
[[ -f ~/.bashrc.d/node ]] && . ~/.bashrc.d/node
[[ -f ~/.bashrc.d/python ]] && . ~/.bashrc.d/python
[[ -f ~/.bashrc.d/custom ]] && . ~/.bashrc.d/custom
[[ -f ~/.bashrc.d/ruby ]] && . ~/.bashrc.d/ruby
[[ -f ~/.bashrc.d/completion ]] && . ~/.bashrc.d/completion
