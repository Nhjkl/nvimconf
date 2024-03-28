local M = {}

---@param url string
function M.open_browser(url)
  local _url = string.gsub(url, "%#", "\\#")
  vim.cmd("silent !$BROWSER " .. _url)
end

---@param text string
---@param regx string
function M.get_match_content(text, regx, index)
  if not index then
    index = 1
  end

  if not regx then
    return text
  end

  local startIndex, endIndex = string.find(text, regx)
  if not startIndex then
    return
  end

  text = string.sub(text, startIndex + index, endIndex - index)
  return text
end

function M.get_current_line_match_content(regx)
  local curLine = vim.api.nvim_get_current_line()
  return M.get_match_content(curLine, regx)
end

function M.open_nvim_plugin_git_repo()
  local pluginName = M.get_current_line_match_content('".*"')
  if not pluginName then
    return
  end
  M.open_github_repo(pluginName)
end

function M.open_github_repo(path)
  M.open_browser([[https://github.com/]] .. path)
end

function M.match_line_url(cb)
  local curLine = vim.api.nvim_get_current_line()
  local url = M.get_match_content(curLine, "http?s://[^ ^)^%]]*", 0)
  if url ~= nil then
    cb(url)
  end
end

function M.print_current_var(type)
  local filetype = vim.bo.filetype
  local cword = vim.fn.expand("<cword>")

  if type ~= "cword" then
    cword = M.getVisualSelection()
  end

  if filetype == "lua" then
    vim.cmd("normal o" .. "print(" .. cword .. ")")
  else
    vim.cmd("normal o" .. string.format([[console.log(`%s >>`, %s)]], cword, cword))
  end
end

function M.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  return unpack(objects)
end

function M.stringify_print(...)
  print(M.dump(...))
end

function M.split_string(str, delimiter)
  local result = {}
  for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

function M.get_os_command_output(cmd, cwd)
  local Job = require("plenary.job")

  if type(cmd) ~= "table" then
    print("Harpoon: [get_os_command_output]: cmd has to be a table")
    return {}
  end
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job:new({
    command = command,
    args = cmd,
    cwd = cwd,
    on_stderr = function(_, data)
      table.insert(stderr, data)
    end,
  }):sync()

  return stdout, ret, stderr
end

function M.get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, "\n")
end

return M
