NODE_PATH=/usr/local/opt/node@8/bin
[[ -d $NODE_PATH ]] && export PATH=$PATH:$NODE_PATH
hash npx 2>/dev/null && source <(npx --shell-auto-fallback bash)
hash npm 2>/dev/null && source <(npm completion)
