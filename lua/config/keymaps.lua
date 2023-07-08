-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- better up/down
map("n", "<c-j>", "10j", { noremap = true, silent = true })
map("n", "<c-k>", "10k", { noremap = true, silent = true })
map("v", "<c-j>", "10j", { noremap = true, silent = true })
map("v", "<c-k>", "10k", { noremap = true, silent = true })

map("n", "<leader>\\", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })

map("n", "<c-q>", "<esc>:q<cr>", { noremap = true, silent = true })
map("n", "Q", "<esc>:q!<cr>", { noremap = true, silent = true })
map("n", "<leader>rw", "ea<c-w><c-r>+<esc>", { noremap = true, silent = true })
map("n", "<leader>r`", '"8di`P', { noremap = true, silent = true })
map("n", "<leader>r'", "\"8di'P", { noremap = true, silent = true })
map("n", '<leader>r"', '"8di"P', { noremap = true, silent = true })
map("n", "<leader>r)", '"8di)P', { noremap = true, silent = true })
map("n", "<leader>r]", '"8di]P', { noremap = true, silent = true })
map("n", "<leader>r}", '"8di}P', { noremap = true, silent = true })
map("n", "<leader>rt", '"8ditP', { noremap = true, silent = true })
map("n", "<", "<<", { noremap = true, silent = true, nowait = true })
map("n", ">", ">>", { noremap = true, silent = true, nowait = true })
map("x", "<", "<gv", { noremap = true, silent = true, nowait = true })
map("x", ">", ">gv", { noremap = true, silent = true, nowait = true })
map("v", "H", "g^", { noremap = true, silent = true })
map("v", "L", "g_", { noremap = true, silent = true })
map("v", "p", "P", { noremap = true, silent = true })

-- unite
map("n", "<leader>fx", ":silent !chmod +x %<cr>", { noremap = true, silent = true })
map("n", "<leader>fX", ":silent !chmod -R a-x %<cr>", { noremap = true, silent = true })
-- map("n", "<leader>/", [[:silent !tmux neww<cr>]], { noremap = true, silent = true })
map(
  "n",
  "<c-f>",
  ":silent !tmux neww tmux-sessionizer<cr>",
  { noremap = true, silent = true, desc = "Projects (tmux)" }
)
map("n", "<c-g>", [[:silent !tmux neww lazygit<cr>]], { noremap = true, silent = true, desc = "Lazygit (tmux)" })

map("n", "<leader>og", [[:silent !goGitHome<cr>]], { noremap = true, silent = true, desc = "goGitHome (browser)" })

map("n", "<leader>op", function()
  require("utils").openNvimPluginGitRepo()
end, { noremap = true, silent = true, desc = "openNvimPluginGitRepo" })

map("n", "<leader>ol", function()
  require("utils").printCurrentVar("cword")
end, { noremap = true, silent = true, desc = "printCurrentVar" })

if Util.has("bufferline.nvim") then
  local function BufferCloseAllButCurrent()
    vim.cmd("BufferLineCloseLeft")
    vim.cmd("BufferLineCloseRight")
  end

  map("n", "<leader>b0", function()
    BufferCloseAllButCurrent()
  end, { noremap = true, silent = true, desc = "Delete other Buffer" })

  map("n", "<leader>0", function()
    BufferCloseAllButCurrent()
  end, { noremap = true, silent = true, desc = "Delete other Buffer" })
end
