return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }, -- Specify LuaRocks packages to install
    },
  },
  {
    "rest-nvim/rest.nvim",

    ft = "http",

    dependencies = {
      "luarocks.nvim",
    },

    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run REST request" },
    },

    config = function()
      require("rest-nvim").setup({})
    end,
  },
}
