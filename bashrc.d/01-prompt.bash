#######
# PS1 #

# are we an interactive shell?
if [[ "$PS1" ]]; then
    case $TERM in
        xterm*)
            PROMPT_COMMAND="printf '\\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\\007'"
            ;;
        screen*)
            PROMPT_COMMAND="printf '\\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\\033\\'"
            ;;
    esac
fi
export PROMPT_COMMAND
