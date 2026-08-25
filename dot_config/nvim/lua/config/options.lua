-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
local opt = vim.opt

-- General {{{

-- LazyVim sets this to 300ms (down from Neovim's default 1000ms) to make
-- which-key's popup feel snappy. Too short if there's any gap between
-- keystrokes (typing speed, WSL/Neovide latency): the leader sequence times
-- out mid-chord, the leftover keys get reinterpreted as unrelated native
-- commands (e.g. `<space>fg` timing out after `<space>` becomes `f`+`g` as
-- Vim's native "find next g on this line"). Splitting the difference.
opt.timeoutlen = 500

opt.backup = false
opt.swapfile = false

-- On WSL, nvim has no clipboard provider of its own (no X11/Wayland session,
-- no xclip/wl-clipboard) so yank/paste silently go nowhere. win32yank talks
-- to the real Windows clipboard directly — bundled with Windows Neovim
-- installs — so Ctrl+C/Ctrl+V into Windows apps (e.g. Chrome) actually works.
local win32yank = "/mnt/c/Program Files/Neovim/bin/win32yank.exe"
if vim.fn.executable(win32yank) == 1 then
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = { win32yank, "-i", "--crlf" },
            ["*"] = { win32yank, "-i", "--crlf" },
        },
        paste = {
            ["+"] = { win32yank, "-o", "--lf" },
            ["*"] = { win32yank, "-o", "--lf" },
        },
        cache_enabled = false,
    }
end

-- }}}

-- dot_path.zsh exports DOTNET_ROOT/PATH for the dotnet SDK, but that only
-- applies when nvim is launched from a shell that actually sourced it —
-- Neovide's --wsl launch, tmux, or $EDITOR invoked from another program
-- often aren't. Without DOTNET_ROOT, the Roslyn LSP's dotnet apphost can't
-- find the runtime and the client just crashes (exit 131, ".NET location:
-- Not found"). Set it directly so it's correct regardless of launch path.
local dotnet_root = vim.fn.expand("~/.dotnet")
if vim.env.DOTNET_ROOT == nil and vim.fn.executable(dotnet_root .. "/dotnet") == 1 then
    vim.env.DOTNET_ROOT = dotnet_root
    vim.env.PATH = dotnet_root .. ":" .. dotnet_root .. "/tools:" .. vim.env.PATH
end

-- Same story for /mnt/c/Windows/System32: this shell's PATH doesn't carry
-- it, so anything nvim spawns that shells out to Windows binaries by bare
-- name (e.g. markdown-preview.nvim's bundled server calling `cmd.exe` to
-- open a browser) fails with an ENOENT-style error even though the
-- binary's right there.
local win_system32 = "/mnt/c/Windows/System32"
if vim.fn.isdirectory(win_system32) == 1 then
    vim.env.PATH = vim.env.PATH .. ":" .. win_system32
end

-- Formatting {{{

opt.wrap = false   -- Do not wrap long lines

opt.shiftwidth = 4 -- 4-space indent everywhere, including C#
opt.tabstop = 4
opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- }}}

-- GUI {{{

opt.background = "dark"
opt.colorcolumn = "80"
opt.relativenumber = false

if vim.g.neovide then
    opt.guifont = "SauceCodePro Nerd Font Mono:h11"
end

-- }}}
