return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function(_, opts)
    local lolcat = vim.fn.executable("lolcat") == 1

    if lolcat then
      opts.preview = {
        command = "cat | lolcat",
        file_path = vim.fn.stdpath("config") .. "/dashboard.head",
        file_width = 78,
        file_height = 10,
      }
      opts.header = {}
    end

    return opts
  end,
}
