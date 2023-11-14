return {
  {
    "nvim-neotest/neotest",

    dependencies = {
      "marilari88/neotest-vitest",
      "rouge8/neotest-rust",
    },

    -- opts = {
    --   adapters = {
    --     require("neotest-vitest"),
    --   },
    -- },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest"),
          require("neotest-rust"),
        },
      })
    end,
  },
}
