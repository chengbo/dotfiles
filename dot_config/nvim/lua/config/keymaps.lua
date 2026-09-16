-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- <C-v> in insert mode is vim's "insert next char literally" (shows `^`
-- while it waits) — remap to the more expected GUI-style paste from the
-- system clipboard register.
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>yp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied relative path: " .. path)
end, { desc = "Yank Relative Path" })

vim.keymap.set("n", "<leader>yP", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path: " .. path)
end, { desc = "Yank Absolute Path" })

-- Set here, not as a lazy.nvim `keys` spec entry: this loads on VeryLazy,
-- strictly after all plugin-spec keys (including Snacks' own <leader>gd
-- git-diff-picker binding) are registered, so it deterministically wins
-- instead of racing with them for the same lhs.
vim.keymap.set("n", "<leader>gd", "<cmd>CodeDiff<cr>", { desc = "Code Diff" })
