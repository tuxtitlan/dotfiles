# Brewfile — restore with `brew bundle`
# Cross-platform formulae install on macOS and Linux (Homebrew/Linuxbrew).
# macOS-only entries are gated below. VS Code extensions are intentionally
# not tracked here — VS Code Settings Sync owns them.

tap "hashicorp/tap"
tap "snyk/tap"
tap "withgraphite/tap"

brew "ctop"
brew "direnv"
brew "gh"
brew "git"
brew "git-gui"
brew "gnupg"
brew "htop"
brew "jmeter"
brew "jq"
brew "mtr"
brew "fastfetch"  # neofetch successor (neofetch archived upstream, formula removed)
brew "pkgconf"
brew "poppler"
brew "postgresql@14"
brew "pyenv"
brew "pyenv-virtualenv"
brew "tfenv"
brew "snyk/tap/snyk"
brew "withgraphite/tap/graphite"

# nvm is deliberately absent: it installs via the official installer in
# bootstrap.sh (matches the existing ~/.nvm layout; the brew formula does
# not manage ~/.nvm).

if OS.mac?
  tap "noovolari/brew"
  brew "pinentry-mac"
  brew "noovolari/brew/leapp-cli-darwin-arm64"  # darwin-arm64 binary
  cask "font-meslo-for-powerline"               # non-ASCII font used by the iTerm2 Cobalt2 profile (agnoster glyphs)
end

cargo "cargo-watch"

npm "@google/gemini-cli"
npm "@shopify/cli"
npm "corepack"  # provides the pnpm/yarn shims — do not also `npm "pnpm"` (EEXIST conflict)
