export EDITOR=edit
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

[[ -d ~/.bin ]] && export PATH=~/.bin:$PATH

# Keep bash history across terminals and write immediately
# http://linuxcommando.blogspot.com/2007/11/keeping-command-history-across-multiple.html
shopt -s histappend
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && source ~/.localrc

ulimit -n 24576
