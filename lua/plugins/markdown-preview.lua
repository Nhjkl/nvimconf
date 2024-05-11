return {
  "iamcco/markdown-preview.nvim",

  enabled = false,

  cmd = "MarkdownPreview",

  ft = { "markdown" },

  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
