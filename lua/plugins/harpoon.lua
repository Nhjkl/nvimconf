return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  -- opts = {
  --   menu = {
  --     width = vim.api.nvim_win_get_width(0) - 4,
  --   },
  -- },
  config = function()
    local harpoon = require("harpoon")
    local tmux = require("utils.tmux")

    harpoon:setup({
      cmd = {
        select = function(list_item)
          tmux._sendCommand(list_item.value)
        end,
      },
    })
  end,
  keys = function()
    local harpoon = require("harpoon")
    local tmux = require("utils.tmux")
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    return {
      {
        "<leader>ma",
        function()
          harpoon:list():append()
        end,
        desc = "Harpoon file",
      },
      {
        "<leader>mm",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
          -- toggle_telescope(harpoon:list())
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<leader>mc",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list("cmd"), {
            title = "Harpoon cmd menu",
            border = "rounded",
            title_pos = "center",
          })
          -- toggle_telescope(harpoon:list("cmd"))
        end,
        desc = "harpoon cmd ui toggle_quick_menu",
      },
      {
        "<leader>mq",
        function()
          tmux.clear_all()
        end,
        desc = "clear all tmux windows",
      },
    }
  end,
}
