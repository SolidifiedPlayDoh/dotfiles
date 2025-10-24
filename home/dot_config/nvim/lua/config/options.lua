-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Automatically reload files when changed outside of Neovim
vim.opt.autoread = true

vim.opt.list = true
vim.opt.listchars = {
  trail = "⋅",
  nbsp = "⋅",
}