local utils = require("utils")
-- 检查JavaScript文件是否可能被压缩
local function check_js_compression(bufnr)
  -- 获取当前文件的完整路径
  local filename = vim.api.nvim_buf_get_name(bufnr)
  -- 尝试以只读方式打开文件，获取其内容
  local file = io.open(filename, "r")
  if not file then
    return -- 如果文件无法打开，直接返回
  end

  local is_compressed = false
  for line in file:lines() do
    if string.len(line) > 1000 then
      is_compressed = true
      break -- 发现超过1000字符的行，标记为压缩文件并退出循环
    end
  end

  file:close() -- 关闭文件

  if is_compressed then
    print("This file may be a compressed file.")
  end
  return is_compressed
end

return {
  "LunarVim/bigfile.nvim",
  event = "BufReadPre",
  -- Disables LSP/treesitter, etc for files above 5000 lines (even if they have really long lines)
  opts = {
    pattern = function(bufnr, filesize_mib)
      if filesize_mib >= 2 then
        return true
      end

      if check_js_compression(bufnr) then
        return true
      end
      -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
      local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
      local file_length = #file_contents
      if file_length > 5000 then
        return true
      end

      return false
    end,

    features = { -- features to disable
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
      "vimopts",
      "filetype",
    },
  },
}
