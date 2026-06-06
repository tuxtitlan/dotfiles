#!/usr/bin/env bash
# macOS system preferences — captured from the source machine on 2026-06-05.
# Idempotent: safe to re-run; values match what `defaults read` reported.
# Only deliberately-customized settings are listed; everything else stays at
# system defaults.
set -euo pipefail

# Appearance: dark mode (fully applies at next login)
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Dock: auto-hide, icon size
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 63

# Finder: icon view as the preferred view style
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

# Menu bar clock: show seconds
defaults write com.apple.menuextra.clock ShowSeconds -bool true

# Apply
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "macOS defaults applied."
