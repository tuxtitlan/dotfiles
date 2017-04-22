# shellcheck disable=SC1090
[[ -f ~/.bashrc.d/secrets ]] && . ~/.bashrc.d/secrets
[[ -f ~/.bashrc.d/homebrew ]] && . ~/.bashrc.d/homebrew
[[ -f ~/.bashrc.d/prompt ]] && . ~/.bashrc.d/prompt
[[ -f ~/.bashrc.d/aliases ]] && . ~/.bashrc.d/aliases
[[ -f ~/.bashrc.d/node ]] && . ~/.bashrc.d/node
[[ -f ~/.bashrc.d/python ]] && . ~/.bashrc.d/python
[[ -f ~/.bashrc.d/custom ]] && . ~/.bashrc.d/custom
[[ -f ~/.bashrc.d/ruby ]] && . ~/.bashrc.d/ruby
[[ -f ~/.bashrc.d/completion ]] && . ~/.bashrc.d/completion

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[ -f /Users/george/Library/dotfiles/config/yarn/global/node_modules/tabtab/.completions/yarn.bash ] && . /Users/george/Library/dotfiles/config/yarn/global/node_modules/tabtab/.completions/yarn.bash
