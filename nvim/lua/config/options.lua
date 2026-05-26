-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.relativenumber = true     -- relative line numbers (great for vim motions)
vim.opt.scrolloff = 8             -- keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8

-- Use system clipboard by default (like IntelliJ Cmd+C/Cmd+V behavior)
vim.opt.clipboard = "unnamedplus"

-- Fira Code is your installed Nerd Font
vim.g.lazyvim_picker = "snacks"   -- use snacks picker (already enabled in lazyvim.json)
