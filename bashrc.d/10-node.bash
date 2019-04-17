NODE_PATH_=/usr/local/opt/node@10/bin
[[ -d $NODE_PATH_ ]] && export PATH=$PATH:$NODE_PATH_
hash npx 2>/dev/null && source <(npx --shell-auto-fallback bash)
hash npm 2>/dev/null && source <(npm completion)
# For compiling the canvas npm package
export PKG_CONFIG_PATH=/usr/local/opt/libffi/lib/pkgconfig
