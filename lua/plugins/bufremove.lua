if true then
  return {}
end

return {
  "echasnovski/mini.bufremove",

  keys = function(_, keys)
    keys[1][1] = "<c-q>" -- 替换键位需要了解lazyvim源码的数据结构
    keys[2][1] = "Q"
  end,
  -- keys = {
  --   {
  --     "<leader>bd",
  --     function()
  --       local bd = require("mini.bufremove").delete
  --       if vim.bo.modified then
  --         local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
  --         if choice == 1 then -- Yes
  --           vim.cmd.write()
  --           bd(0)
  --         elseif choice == 2 then -- No
  --           bd(0, true)
  --         end
  --       else
  --         bd(0)
  --       end
  --     end,
  --     desc = "Delete Buffer",
  --   },
  --   -- stylua: ignore
  --   { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
  -- },
}
