return {
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      local chrome_wsl_path = "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
      if vim.fn.executable(chrome_wsl_path) == 1 then
        vim.g.mkdp_browser = "C:/Program Files/Google/Chrome/Application/chrome.exe"
      end
    end,
  },
}
