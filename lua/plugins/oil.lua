return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },

  keys = {
    { "<c-/>", "<cmd>Oil<cr>", desc = "Oil" },
    { "<c-_>", "<cmd>Oil<cr>", desc = "Oil" },
  }, -- tmux 中<c-/> 变成了<c-_>
}
