-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Autosave: write when leaving insert mode or switching away from nvim.
-- Skips unsaved new files (no name), readonly buffers, and special buffers
-- (terminal, quickfix, etc.). Format-on-save runs at this point, which is correct.
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost" }, {
  group = vim.api.nvim_create_augroup("autosave", { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if
      vim.bo[buf].modified
      and not vim.bo[buf].readonly
      and vim.fn.expand("%") ~= ""
      and vim.bo[buf].buftype == ""
    then
      vim.cmd("silent! write")
    end
  end,
})
