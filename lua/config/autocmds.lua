-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- local LazyVim = require("lazyvim.util")
--
local function augroup(name)
  return vim.api.nvim_create_augroup("user_custom_" .. name, { clear = true })
end

require("utils.fcitx").setup()

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("markdown_disable_format"),
  pattern = { "markdown" },
  callback = function()
    -- vim.bo.autoformat = false
    vim.b.autoformat = false
  end,
})
