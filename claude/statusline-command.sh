#!/usr/bin/env bash
# Claude Code status line — mirrors agnoster PS1 style
# Receives JSON on stdin

input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$cwd" ] && cwd=$(pwd)
# Shorten home directory to ~
home="$HOME"
cwd="${cwd/#$home/\~}"

model=$(echo "$input" | jq -r '.model.display_name // empty')

used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_part=""
if [ -n "$used" ]; then
  ctx_part=" | ctx:$(printf '%.0f' "$used")%"
fi

# agnoster-style: user@host in directory [model][ctx]
printf "\033[1;32m%s@%s\033[0m \033[1;34m%s\033[0m%s" \
  "$user" "$host" "$cwd" ""

[ -n "$model" ] && printf " \033[0;33m[%s]\033[0m" "$model"
[ -n "$ctx_part" ] && printf "\033[0;36m%s\033[0m" "$ctx_part"
# Ponytail plugin writes its live level here; absent file = ponytail off
pt_flag="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/.ponytail-active"
[ -s "$pt_flag" ] && printf " \033[38;5;108m[ponytail:%s]\033[0m" "$(head -n1 "$pt_flag" | tr -d '[:space:]')"
printf "\n"
