# Brewfile — restore with `brew bundle`
# Cross-platform formulae install on macOS and Linux (Homebrew/Linuxbrew).
# macOS-only entries are gated below. VS Code extensions are intentionally
# not tracked here — VS Code Settings Sync owns them.

tap "hashicorp/tap"
tap "snyk/tap"
tap "withgraphite/tap"

brew "bat"          # `cat` replacement (aliased in ~/.zsh_aliases)
brew "ctop"
brew "direnv"
brew "eza"          # `ls` replacement (aliased in ~/.zsh_aliases)
brew "fzf"          # fuzzy finder — sourced by ~/.zshrc (Ctrl-R / Ctrl-T / Alt-C)
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
brew "zoxide"       # smart `cd` (`z`) — sourced by ~/.zshrc
brew "snyk/tap/snyk"
brew "withgraphite/tap/graphite"

# nvm is deliberately absent: it installs via the official installer in
# bootstrap.sh (matches the existing ~/.nvm layout; the brew formula does
# not manage ~/.nvm).

if OS.mac?
  brew "pinentry-mac"
  cask "1password-cli"                          # `op` — 1Password CLI
  cask "font-meslo-for-powerline"               # powerline glyph font for the iTerm2 Cobalt2 profile / Powerlevel10k prompt
end

cargo "cargo-watch"

npm "@google/gemini-cli"
npm "@shopify/cli"
npm "corepack"  # provides the pnpm/yarn shims — do not also `npm "pnpm"` (EEXIST conflict)
