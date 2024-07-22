M = { "lukas-reineke/indent-blankline.nvim", main = "ibl" }

M.opts = {}
local highlight_colors = {
  ["pastel_purple"] = "#9E7AC9",
  ["warm_brown"] = "#C19A6B",
  ["soft_yellow"] = "#EACD76",
  ["lavender"] = "#B19CD9",
  ["earthy_brown"] = "#B38867",
  ["pale_yellow"] = "#F2E9D8",
  ["muted_purple"] = "#B19CD9",
  ["tan"] = "#D2B48C",
  ["mustard_yellow"] = "#FFDD83",
  ["pastel_violet"] = "#C8A2C8"
}


local highlight = vim.tbl_keys(highlight_colors)

M.config = function()
  local hooks = require "ibl.hooks"
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    for name, hex in pairs(highlight_colors) do
      vim.api.nvim_set_hl(0, name, { fg = hex })
    end
  end)
  require("ibl").setup { indent = { highlight = highlight, char = "│" } }
end

return M
