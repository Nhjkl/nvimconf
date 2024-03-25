local utils = require("utils")

local M = {}
local tmux_windows = {}

local function create_terminal()
  local window_id

  -- Create a new tmux window and store the window id
  local out, ret, _ = utils.get_os_command_output({
    "tmux",
    "new-window",
    "-P",
    "-F",
    "#{pane_id}",
  }, vim.loop.cwd())

  if ret == 0 then
    window_id = out[1]:sub(2)
  end

  if window_id == nil then
    return nil
  end

  return window_id
end

-- Checks if the tmux window with the given window id exists
local function terminal_exists(window_id)
  local exists = false

  local window_list, _, _ = utils.get_os_command_output({
    "tmux",
    "list-windows",
  }, vim.loop.cwd())

  -- This has to be done this way because tmux has-session does not give
  -- updated results
  for _, line in pairs(window_list) do
    local window_info = utils.split_string(line, "@")[2]

    if string.find(window_info, string.sub(window_id, 2)) then
      exists = true
    end
  end

  return exists
end

local function find_terminal(args)
  if type(args) == "string" then
    -- assume args is a valid tmux target identifier
    -- if invalid, the error returned by tmux will be thrown
    return {
      window_id = args,
      pane = true,
    }
  end

  if type(args) == "number" then
    args = { idx = args }
  end

  local window_handle = tmux_windows[args.idx]
  local window_exists

  if window_handle then
    window_exists = terminal_exists(window_handle.window_id)
  end

  if not window_handle or not window_exists then
    local window_id = create_terminal()

    if window_id == nil then
      error("Failed to find and create tmux window.")
      return
    end

    window_handle = {
      window_id = "%" .. window_id,
    }

    tmux_windows[args.idx] = window_handle
  end

  return window_handle
end

M.find_terminal = find_terminal

function M.gotoTerminal(idx)
  local window_handle = find_terminal(idx)

  local _, ret, stderr = utils.get_os_command_output({
    "tmux",
    window_handle.pane and "select-pane" or "select-window",
    "-t",
    window_handle.window_id,
  }, vim.loop.cwd())

  if ret ~= 0 then
    error("Failed to go to terminal." .. stderr[1])
  end
end

function M.sendCommand(idx, cmd, ...)
  local window_handle = find_terminal(idx)

  if cmd then
    local _, ret, stderr = utils.get_os_command_output({
      "tmux",
      "send-keys",
      "-t",
      window_handle.window_id,
      string.format(cmd, ...),
    }, vim.loop.cwd())

    if ret ~= 0 then
      error("Failed to send command. " .. stderr[1])
    end
  end
end

local idx = 0
local cmd_idx = {}
function M._sendCommand(cmd, ...)
  local index = 0
  if type(cmd_idx[cmd]) == "number" then
    index = cmd_idx[cmd]
    M.gotoTerminal(index)
  else
    idx = idx + 1
    index = idx
    cmd_idx[cmd] = index
  end
  M.sendCommand(index, cmd .. "\n", ...)
end

function M.clear_all()
  for _, window in pairs(tmux_windows) do
    -- Delete the current tmux window
    utils.get_os_command_output({
      "tmux",
      "kill-window",
      "-t",
      window.window_id,
    }, vim.loop.cwd())
  end

  tmux_windows = {}
end

function M.valid_index(idx)
  if idx == nil or idx > M.get_length() or idx <= 0 then
    return false
  end
  return true
end

return M
