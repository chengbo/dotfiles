This is my personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Setup on a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --source ~/dotfiles chengbo/dotfiles
```

`--source ~/dotfiles` makes chezmoi clone the repo straight into `~/dotfiles`, so that's
the one and only clone on the machine. Don't separately `git clone` this repo elsewhere —
a second clone can drift out of sync with the one chezmoi actually manages.

## Dependencies

This repo only manages config files — it doesn't install the tools it configures.
Everything below needs to be installed separately on a new machine.

**Required everywhere:**

- [chezmoi](https://www.chezmoi.io/) — manages this whole repo
- `zsh` + [Oh My Zsh](https://ohmyz.sh/) — shell and framework (`dot_zshrc`)
- `git` — plus [`git-delta`](https://github.com/dandavison/delta) (`delta`) as the diff
  pager, and [`tig`](https://jonas.github.io/tig/) as the git TUI
- `vim` + [Vundle](https://github.com/VundleVim/Vundle.vim) — install Vundle, then run
  `vim +PluginInstall +qall` to fetch the plugins listed in `dot_vimrc`
- [`lsd`](https://github.com/lsd-rs/lsd) — replaces `ls`/`ll`/`l`
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal — needed for the `bo` prompt
  theme's icon and `lsd`'s icons to render instead of showing blank boxes
- 1Password — backs SSH auth (`SSH_AUTH_SOCK`) and SSH commit/tag signing
  (`commit.gpgsign = true` in `dot_gitconfig.tmpl`); the `allowedSignersFile` also has a
  specific pubkey hardcoded in `private_dot_ssh/allowed_signers`

**Required for the AI CLI / MCP setup:**

- [Claude Code CLI](https://claude.com/claude-code) (`claude`)
- [Codex CLI](https://openai.com/codex/) (`codex`)
- Node.js (so `npx` is available) — both `dot_claude/mcp.json` and
  `dot_codex/modify_private_config.toml` run `npx -y @azure-devops/mcp` on demand
- [Azure CLI](https://learn.microsoft.com/cli/azure/) (`az`), logged in via `az login` —
  the `ado` MCP server authenticates with `--authentication azcli`

**Optional (guarded — harmless if missing):**

- `dotnet` SDK — `dot_path.zsh` adds `~/.dotnet` and `~/.dotnet/tools` to `PATH`
- Rust/Cargo — `dot_path.zsh` adds `~/.cargo/bin` to `PATH`
- [nvm](https://github.com/nvm-sh/nvm) — `dot_path.zsh` sources it only if present
- [Worktrunk](https://worktrunk.dev/) (`wt`) — shell integration in `dot_zshrc` only loads
  if `wt` is on `PATH`
- `tmux` — config in `dot_tmux.conf`
- `ag` (the_silver_searcher) — vim falls back to `find` if absent
- `snap` — only relevant on Linux distros that use it

**WSL-only:**

- `socat` and `npiperelay.exe` — bridge the WSL Unix socket to the Windows-side
  1Password SSH agent named pipe (`dot_zshrc`)
- `op-ssh-sign-wsl.exe` — 1Password's SSH commit-signing helper, wired into
  `dot_gitconfig.tmpl` only when `.chezmoi.os == "linux"`

**macOS-only:**

- `reattach-to-user-namespace` — used by `dot_tmux-macos.conf` for clipboard integration
  with `pbcopy`

## Usage

```sh
chezmoi edit ~/.zshrc   # edit a managed file (edits the source, not the target)
chezmoi diff            # preview what would change
chezmoi apply           # apply the source state to the home directory
chezmoi update          # pull the latest changes from the repo and apply them
chezmoi cd              # cd into the source directory to commit/push changes
```
