return {
  "3rd/image.nvim",
  enabled = false,
  event = "BufReadPre",
  dependencies = { "luarocks.nvim" },
  config = function()
    -- default config
    require("image").setup()

    -- local dashboardImage = vim.api.nvim_create_augroup("DashboardImage", { clear = true })
    --
    -- local img = require("image").from_file("~/.config/nvim/NeoVimLogo.png")
    -- vim.api.nvim_create_autocmd({ "VimEnter" }, {
    --   group = dashboardImage,
    --   callback = function()
    --     img:render()
    --     img:move(27, 1)
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd({ "BufEnter" }, {
    --   group = dashboardImage,
    --   callback = function()
    --     img:clear()
    --   end,
    -- })
  end,
}
