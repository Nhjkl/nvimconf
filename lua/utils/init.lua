local M = {}

---@param url string
function M.openBrowser(url)
  local _url = string.gsub(url, "%#", "\\#")
  vim.cmd("silent !$BROWSER " .. _url)
end

---@param text string
---@param regx string
function M.getMatchContent(text, regx)
  if not regx then
    return text
  end
  local startIndex, endIndex = string.find(text, regx)
  if not startIndex then
    return
  end
  text = string.sub(text, startIndex + 1, endIndex - 1)
  return text
end

function M.getCurrentLineMatchContent(regx)
  local curLine = vim.api.nvim_get_current_line()
  return M.getMatchContent(curLine, regx)
end

function M.openNvimPluginGitRepo()
  local pluginName = M.getCurrentLineMatchContent('".*"')
  if not pluginName then
    return
  end
  M.openGitHubRepo(pluginName)
end

function M.openGitHubRepo(path)
  M.openBrowser([[https://github.com/]] .. path)
end

function M.printCurrentVar(type)
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

function M.stringifyPrint(...)
  print(M.dump(...))
end

return M
