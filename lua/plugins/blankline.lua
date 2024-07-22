M = { "lukas-reineke/indent-blankline.nvim", main = "ibl" }

M.opts = {}
local highlight_colors = {
  ["pastel_purple"] = "#7D5BA6",
  ["warm_brown"] = "#B38867",
  ["soft_yellow"] = "#D9B44A",
  ["lavender"] = "#8D86C9",
  ["earthy_brown"] = "#A27B5C",
  ["pale_yellow"] = "#FFDD83",
  ["muted_purple"] = "#9E7AB3",
  ["tan"] = "#C19A6B",
  ["mustard_yellow"] = "#FFCF56",
  ["pastel_violet"] = "#B19CD9"
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
