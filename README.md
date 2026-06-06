# dotfiles

Personal configuration, restorable with one command on macOS or Linux.

## Restore a machine

```sh
git clone https://github.com/tuxtitlan/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles && ./bootstrap.sh
```

The bootstrap is idempotent — re-run it any time. It:

1. Detects the OS (macOS or Linux; anything else fails fast)
2. Installs Xcode CLT (macOS) or checks for `curl`/`git` (Linux)
3. Installs Homebrew if missing — pinned installer, SHA256-verified
4. Installs everything in [`Brewfile`](Brewfile) (`if OS.mac?` entries skipped on Linux)
5. Installs oh-my-zsh and nvm (official installers) if missing
6. Symlinks the configs below into place — existing real files are backed up once to `<name>.backup`
7. macOS only: links the iTerm2 dynamic profile and applies [`macos/defaults.sh`](macos/defaults.sh)
8. Sets runtime defaults: `pyenv global 3.10`, `nvm alias default v20.19.0`

## What's tracked

| Repo | Destination | Mode |
|---|---|---|
| `zsh/zshrc`, `zshenv`, `zprofile` | `~/.zshrc` etc. | symlink |
| `zsh/omz-custom/` | `~/.oh-my-zsh/custom` | symlink |
| `git/gitconfig`, `gitignore_global` | `~/.gitconfig`, `~/.gitignore_global` | symlink |
| `config/gh/config.yml` | `~/.config/gh/config.yml` | symlink |
| `config/graphite/aliases` | `~/.config/graphite/aliases` | symlink |
| `config/htop/htoprc`, `config/neofetch/config.conf` | `~/.config/...` | symlink |
| `claude/CLAUDE.md`, `claude/settings.json` | `~/.claude/...` | **seed** (copy once) |
| `iterm2/profiles.json` | iTerm2 `DynamicProfiles/` | symlink (macOS; pending first manual export — see below) |

Claude Code files are *seeded*, not symlinked: the app rewrites `settings.json` at
runtime, and machine-local changes must not flow back into a public repo.

## Machine-local files (untracked, created by you)

Tracked configs source these when present; their absence is silent.

| File | Holds |
|---|---|
| `~/.zshrc.local`, `~/.zshenv.local`, `~/.zprofile.local` | machine/work env vars, extra PATH entries |
| `~/.zsh_aliases` | personal/work aliases (sourced by zshrc when present) |
| `~/.gitconfig.local` | git identity: `user.name`, `user.email`, signing config |

Never tracked, by design: SSH keys/config, `~/.config/gh/hosts.yml` and
`~/.config/graphite/user_config` (credential stores — `.gitignore` has hard stops
for both), VS Code extensions (Settings Sync owns them), Mac App Store apps.

## iTerm2 (manual, macOS)

- **Capture** (on the source machine): Settings → Profiles → Other Actions… →
  *Save All Profiles as JSON…* → commit as `iterm2/profiles.json` (this export is
  already in the `{"Profiles": [...]}` format DynamicProfiles requires). Color presets:
  Profiles → Colors → Color Presets… → *Export…* → commit as `iterm2/cobalt2.itermcolors`.
- **Restore**: the bootstrap links `profiles.json` into DynamicProfiles automatically;
  the profile's powerline font installs via the Brewfile (`font-meslo-for-powerline`).
  Import the `.itermcolors` preset manually (double-click it).

## Linux notes

- Packages install through [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux);
  build prerequisites: `sudo apt-get install build-essential procps curl file git` (Debian/Ubuntu)
- macOS-only pieces (casks, iTerm2, `defaults.sh`) are skipped automatically
- The gitconfig's work `includeIf` paths cover both `/Users/me/...` and `/home/me/...`
