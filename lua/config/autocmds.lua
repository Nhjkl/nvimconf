-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.cmd("hi HarpoonWindow ctermfg=246 ctermbg=239 guifg=#82aaff")
-- vim.cmd("hi link HarpoonBorder NoiceCmdlinePopupBorder")
-- vim.cmd("hi link LspInlayHint comment")
require("utils.fcitx").setup()
