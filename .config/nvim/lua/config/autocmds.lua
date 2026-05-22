-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.api.nvim_create_augroup("BashShebang", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "BashShebang",
  pattern = "*",
  callback = function()
    local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
    if first_line and first_line:match("^#!.*bash") then
      vim.bo.filetype = "bash"
    end
  end,
})
