local utils = require("utils")
local headers = require("utils.dashboard_headers")

local function lineColor(lines)
  local out = {}
  local colors = utils.generateGradientColors(#lines)
  local dashboardHighlight = "AlphaDashboardHeader"
  for i, line in ipairs(lines) do
    vim.api.nvim_set_hl(0, dashboardHighlight .. i, { fg = colors[i] })
    local hi = dashboardHighlight .. i
    table.insert(out, { hi = hi, line = line })
  end
  return out
end

local function header_chars()
  return lineColor(headers[math.random(#headers)])
end

-- Map over the headers, setting a different color for each line.
-- This is done by setting the Highligh to StartLogoN, where N is the row index.
-- Define StartLogo1..StartLogoN to get a nice gradient.
local function header_color()
  local lines = {}
  for _, lineConfig in pairs(header_chars()) do
    local hi = lineConfig.hi
    local line_chars = lineConfig.line
    local line = {
      type = "text",
      val = line_chars,
      opts = {
        hl = hi,
        shrink_margin = false,
        position = "center",
      },
    }
    table.insert(lines, line)
  end

  local output = {
    type = "group",
    val = lines,
    opts = { position = "center" },
  }

  return output
end

return {
  "goolord/alpha-nvim",
  opts = function(_, dashboard)
    local logo = header_color()
    dashboard.section.header.opts.position = logo.opts.position
    dashboard.section.header.type = logo.type
    dashboard.section.header.val = logo.val
  end,
}
