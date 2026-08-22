-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- <C-v> in insert mode is vim's "insert next char literally" (shows `^`
-- while it waits) — remap to the more expected GUI-style paste from the
-- system clipboard register.
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })
