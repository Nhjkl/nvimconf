return {
  "rest-nvim/rest.nvim",

  event = "VeryLazy",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  keys = {
    {
      "<leader>rr",
      function()
        require("rest-nvim").run()
      end,
      desc = "rest nvim run",
    },
    {
      "<leader>rp",
      function()
        require("rest-nvim").run(true)
      end,
      desc = "rest nvim run preview",
    },
  },

  config = function()
    require("rest-nvim").setup({})
  end,
}
