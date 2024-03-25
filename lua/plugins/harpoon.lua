if true then
  return {}
end

return {
  "Nhjkl/harpoon",
  -- 'ThePrimeagen/harpoon',
  keys = function()
    local ui = require("harpoon.ui")
    local mark = require("harpoon.mark")
    local cmdui = require("harpoon.cmd-ui")
    return {
      {
        "<leader>mm",
        function()
          ui.toggle_quick_menu()
        end,
        desc = "harpoon ui toggle_quick_menu",
      },
      {
        "<leader>mc",
        function()
          cmdui.toggle_quick_menu()
        end,
        desc = "harpoon cmd ui toggle_quick_menu",
      },
      {
        "<leader>ma",
        function()
          mark.add_file()
        end,
        desc = "harpoon mark add_file",
      },
    }
  end,

  init = function()
    vim.g.select_menu_item_callback = function(cmd)
      local tmux = require("harpoon.tmux")
      tmux.sendCommand(1, cmd .. "\n")
    end
  end,
}
