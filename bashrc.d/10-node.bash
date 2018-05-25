export PATH="/usr/local/opt/node@8/bin:$PATH"
hash npx 2>/dev/null && source <(npx --shell-auto-fallback bash)
hash npm 2>/dev/null && source <(npm completion)
