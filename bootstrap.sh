#!/usr/bin/env bash
# bootstrap.sh — one-command machine restore (macOS / Linux)
#
#   git clone https://github.com/tuxtitlan/dotfiles.git ~/dev/dotfiles
#   cd ~/dev/dotfiles && ./bootstrap.sh
#
# Idempotent: re-running skips work that is already done. Existing real files
# at symlink destinations are backed up once to <name>.backup (deterministic —
# re-runs never create duplicate backups).
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------------------------------------------------------- OS detection
OS="$(uname -s)"
case "$OS" in
  Darwin) IS_MAC=1 ;;
  Linux)  IS_MAC=0 ;;
  *) echo "ERROR: unsupported OS: $OS (macOS and Linux only)" >&2; exit 1 ;;
esac

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# -------------------------------------------------------------- prerequisites
if [ "$IS_MAC" = 1 ]; then
  if ! xcode-select -p >/dev/null 2>&1; then
    info "Installing Xcode Command Line Tools (a dialog may appear)..."
    info "Waiting for installation to finish — Ctrl-C to abort if you cancelled the dialog."
    xcode-select --install || true
    until xcode-select -p >/dev/null 2>&1; do sleep 5; done
  fi
else
  for cmd in curl git; do
    command -v "$cmd" >/dev/null 2>&1 || {
      echo "ERROR: '$cmd' is required. Install it first (e.g. apt install build-essential curl git)" >&2
      exit 1
    }
  done
fi

# ------------------------------------------------------------------- Homebrew
# Pinned installer with integrity verification (no blind curl-pipe).
BREW_INSTALL_COMMIT="280cbc9adffcbdef15dd1c9d991ef2d1dd7cfc9c"
BREW_INSTALL_SHA256="f3e91784ffeda32bc397de7acc1154724cc47522a459c9ac656cca176eeba457"

brew_env() {
  if [ -x /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

brew_env
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew (pinned installer ${BREW_INSTALL_COMMIT:0:12})..."
  installer="$(mktemp)"
  curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/${BREW_INSTALL_COMMIT}/install.sh" -o "$installer"
  echo "${BREW_INSTALL_SHA256}  ${installer}" | shasum -a 256 -c - || {
    echo "ERROR: Homebrew installer checksum mismatch — aborting." >&2; rm -f "$installer"; exit 1
  }
  NONINTERACTIVE=1 bash "$installer"
  rm -f "$installer"
  brew_env
fi

info "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"

# ---------------------------------------------------------------- zsh plugins
# Prompt + plugins live in ~/.zsh — no framework. Clone each (or fast-forward
# if already present). ~/.zshrc sources them by path.
info "Installing zsh prompt + plugins into ~/.zsh..."
mkdir -p "$HOME/.zsh"
clone_or_update() {
  local url="$1" dst="$HOME/.zsh/$2"
  if [ -d "$dst/.git" ]; then
    git -C "$dst" pull --ff-only --quiet || true
  else
    git clone --depth=1 "$url" "$dst"
  fi
}
clone_or_update https://github.com/romkatv/powerlevel10k.git             powerlevel10k
clone_or_update https://github.com/zsh-users/zsh-autosuggestions.git     zsh-autosuggestions
clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting

# ------------------------------------------------------------------------ nvm
# Official installer (the brew formula does not manage ~/.nvm).
if [ ! -d "$HOME/.nvm" ]; then
  info "Installing nvm..."
  PROFILE=/dev/null bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh)"
fi

# ------------------------------------------------------------------- symlinks
# link <repo-relative source> <absolute destination>
link() {
  local src="$DOTFILES/$1" dst="$2"
  [ -e "$src" ] || { info "skip $1 (not in repo)"; return 0; }
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then return 0; fi
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    [ -e "${dst}.backup" ] || mv "$dst" "${dst}.backup"
  fi
  ln -sfn "$src" "$dst"
  info "linked $dst -> $1"
}

# seed <repo-relative source> <absolute destination> — copy once, never overwrite.
# Used for files the owning app rewrites at runtime (symlinking would leak
# machine-local mutations back into the repo).
seed() {
  local src="$DOTFILES/$1" dst="$2"
  [ -e "$src" ] || return 0
  [ -e "$dst" ] && return 0
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  info "seeded $dst from $1"
}

info "Linking dotfiles..."
link zsh/zshrc                "$HOME/.zshrc"
link zsh/zshenv               "$HOME/.zshenv"
link zsh/zprofile             "$HOME/.zprofile"
link zsh/p10k.zsh             "$HOME/.p10k.zsh"
link git/gitconfig            "$HOME/.gitconfig"
link git/gitignore_global     "$HOME/.gitignore_global"
link config/gh/config.yml     "$HOME/.config/gh/config.yml"
link config/graphite/aliases  "$HOME/.config/graphite/aliases"
link config/htop/htoprc       "$HOME/.config/htop/htoprc"
link config/neofetch/config.conf "$HOME/.config/neofetch/config.conf"

# Claude Code files are seeded, not linked: the app rewrites settings.json at
# runtime, and machine-local additions must not flow back into the repo.
seed claude/CLAUDE.md      "$HOME/.claude/CLAUDE.md"
seed claude/settings.json  "$HOME/.claude/settings.json"
seed claude/keybindings.json "$HOME/.claude/keybindings.json"  # self-guarded: no-op while the file is untracked

# ----------------------------------------------------------------- macOS only
if [ "$IS_MAC" = 1 ]; then
  if [ -e "$DOTFILES/iterm2/profiles.json" ]; then
    link iterm2/profiles.json \
      "$HOME/Library/Application Support/iTerm2/DynamicProfiles/profiles.json"
  fi
  info "Applying macOS defaults..."
  bash "$DOTFILES/macos/defaults.sh"
fi

# ----------------------------------------------------------- runtime defaults
if command -v pyenv >/dev/null 2>&1; then
  # Prefix match: any installed 3.13.x satisfies the default
  pyenv versions --bare | grep -q '^3\.13\.' || { info "Installing Python 3.13 via pyenv..."; pyenv install -s 3.13; }
  pyenv global 3.13   # modern pyenv resolves the prefix to the latest installed 3.13.x
fi
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  # nvm is a shell function — must be sourced before use in a script
  set +u
  . "$HOME/.nvm/nvm.sh"
  nvm version v24.16.0 >/dev/null 2>&1 || { info "Installing Node v24.16.0 via nvm..."; nvm install v24.16.0; }
  nvm alias default v24.16.0
  set -u
fi

info "Done. Create your machine-local files as needed (see README):"
info "  ~/.zshrc.local ~/.zshenv.local ~/.zprofile.local ~/.gitconfig.local ~/.zsh_aliases"
