return {
  -- add vue to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ignore_install = { "help" }
      if type(opts.ensure_installed) == "table" then
        -- vim.list_extend(opts.ensure_installed, { "vue", "vimdoc" })
        opts.ensure_installed = {
          "vue",
          "bash",
          "c",
          "html",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "luap",
          -- "markdown",
          -- "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "http",
        }
      end
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ---@type lspconfig.options.vuels
        vuels = {
          init_options = {
            config = {
              vetur = {
                ignoreProjectWarning = true,
                validation = {
                  script = false,
                  style = false,
                  template = false,
                },
              },
            },
          },
        },
      },
    },
  },
}
