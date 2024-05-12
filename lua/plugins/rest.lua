return {
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
