return {
  -- {
  --   "lvimuser/lsp-inlayhints.nvim",
  --   ft = { "rust" },
  --   opts = function()
  --     require("lsp-inlayhints").setup()
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- opts.inlay_hints.enabled = true
      local inlay_hints = {
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayVariableTypeHints = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
      opts.servers.tsserver.settings = {
        typescript = {
          inlayHints = inlay_hints,
        },
        javascript = {
          inlayHints = inlay_hints,
        },
      }
      -- opts.servers.tsserver.settings.javascript.inlayHints = inlay_hints
    end,
    -- opts = {
    --   inlay_hints = {
    --     enabled = true,
    --   },
    --   servers = {
    --     tsserver = {
    --       settings = {
    --         typescript = {
    --           inlayHints = {
    --             includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             includeInlayVariableTypeHints = false,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHintsWhenTypeMatchesName = false,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --           },
    --         },
    --         javascript = {
    --           inlayHints = {
    --             includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --             includeInlayVariableTypeHints = false,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHintsWhenTypeMatchesName = false,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --           },
    --         },
    --       },
    --     },
    --   },
    -- },
  },
}
