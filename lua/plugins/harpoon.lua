return {
  "Nhjkl/harpoon",
  -- 'ThePrimeagen/harpoon',
  keys = {
    {
      "<leader>mm",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "harpoon ui toggle_quick_menu",
    },
    {
      "<leader>mc",
      function()
        require("harpoon.cmd-ui").toggle_quick_menu()
      end,
      desc = "harpoon cmd ui toggle_quick_menu",
    },
    {
      "<leader>ma",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "harpoon mark add_file",
    },
  },

  init = function()
    vim.g.select_menu_item_callback = function(cmd)
      local tmux = require("harpoon.tmux")
      tmux.sendCommand(1, cmd .. "\n")
    end
  end,
}
