return {
  "vhyrro/luarocks.nvim",
  -- event = "VeryLazy",
  ft = { "http", "markdown" },
  priority = 1000,
  config = true,
  opts = {
    rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua", "magick" }, -- Specify LuaRocks packages to install
  },
}
