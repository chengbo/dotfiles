-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- codediff.nvim's explorer.auto_open_on_cursor only wires up j/k/<Down>/<Up>
-- to move-and-open (hardcoded in the plugin, not configurable). Recursively
-- remapping <C-n>/<C-p> to j/k lets them resolve through whatever j/k are
-- already bound to in that buffer, auto-open included, instead of
-- duplicating the plugin's own (private) open-file logic here.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "codediff-explorer",
  callback = function(event)
    vim.keymap.set("n", "<C-n>", "j", { buffer = event.buf, remap = true, desc = "Move down" })
    vim.keymap.set("n", "<C-p>", "k", { buffer = event.buf, remap = true, desc = "Move up" })
  end,
})
