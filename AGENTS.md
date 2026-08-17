## What this repo is

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/). Source files here get
rendered/copied to `$HOME` via chezmoi's naming convention:

- `dot_foo` → `~/.foo`, `dot_foo/bar` → `~/.foo/bar`
- `private_` prefix → target permissions `0600` (files) / `0700` (dirs)
- `executable_` prefix → target file gets the executable bit
- `*.tmpl` → Go-template rendered (`.chezmoi.os`, `.chezmoi.homeDir`, etc. available)
- `modify_` prefix → the file is an executable script; its stdout becomes the target's
  content, and it receives the *current* target file on stdin (see
  `dot_codex/modify_private_config.toml`)

## Workflow for any change

There's no build/lint/test suite — the "test" for a change is applying it and exercising
the real shell/tool. The loop is:

```sh
chezmoi diff <target>     # preview against what's actually applied
chezmoi apply <target>    # write it to $HOME
```

Prefer a scoped `chezmoi apply <target>` over a bare `chezmoi apply`: some live files
under `$HOME` accumulate local drift between sessions (see below), and a bare apply will
silently overwrite anything not captured in source. Verify with a fresh subshell after
applying — e.g. `zsh -i -c '...'` for prompt/PATH changes, or an actual `git` command for
hook/gitconfig changes — a clean diff doesn't by itself prove the behavior is correct.

**After changing anything that touches `PATH` (`dot_path.zsh`) or adds/removes a tool
dependency, update the Dependencies section in `README.md`** so it stays an accurate list
of what needs to be installed on a new machine.

## Recurring gotcha: tools that edit dotfiles live, outside chezmoi

Several installers (nvm, cargo/rustup, the `wt` CLI) append lines directly to `~/.zshrc`
or `~/.gitconfig` instead of going through chezmoi. When that happens, the live file and
the source in this repo diverge, and `chezmoi apply` refuses with "has changed since
chezmoi last wrote it?" until you reconcile them — usually by folding the new live lines
into the right source file, occasionally by forcing the overwrite. Diff first to see which
side actually changed before deciding.

## `dot_codex/modify_private_config.toml` — per-machine config merge

Codex CLI writes `[projects."<path>"]` trust-level entries directly into
`~/.codex/config.toml`, and those paths differ per machine (this dotfiles repo is shared
across WSL and macOS). Hardcoding them would break on machines without those exact paths.
Instead this is a chezmoi `modify_` script: it emits the portable settings
(`approval_policy`, `sandbox_mode`, `mcp_servers.ado`, etc.) and passes through whatever
`[projects."..."]` blocks already exist in the live file, so per-machine trust entries
survive every apply without ever being committed. Any other manual edit to the live file
that isn't a `[projects."..."]` block (e.g. a new top-level key) is *not* preserved by the
script and will be silently dropped on the next full apply — fold it into the script's
static output instead if it should stick.

## Global git hooks apply repo-wide, not just here

`dot_gitconfig.tmpl` sets `core.hooksPath = ~/.githooks` globally, so
`dot_githooks/executable_post-checkout` and `executable_post-merge` run in *every* git
repo on the machine, not just this one. Both call `~/.scripts/git-link-skills`, which
symlinks `.claude/skills` and `.agents/skills` to `.cursor/skills` in whatever repo they
fire in. `post-checkout` is guarded on `$3 = 1` (a real branch checkout, not a file-level
one) so it also fires on `git worktree add`.

## Custom oh-my-zsh theme (`bo`)

`dot_oh-my-zsh/custom/themes/bo.zsh-theme` replaces the path segment of the prompt with
`<main-repo-name>/<branch>` when inside a git repo, derived from
`git rev-parse --git-common-dir` (which resolves to the *main* repo's `.git` dir even from
a linked worktree) — falls back to the normal truncated path (`%3~`) outside git.
`ZSH_THEME` is set in `dot_zshrc`.

## WSL/Windows interop is template-conditional

`dot_gitconfig.tmpl` only sets `gpg.ssh.program` (1Password's `op-ssh-sign-wsl.exe`
signing helper) `{{- if eq .chezmoi.os "linux" }}`. `dot_zshrc` sets up a
`socat`/`npiperelay.exe` bridge so WSL's native SSH can reach the Windows-side 1Password
agent socket — this only runs if `$SSH_AUTH_SOCK` isn't already a live socket. Both are
WSL-specific and absent on macOS.
