local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}

M.config = function()
  require("lualine").setup {
    options = {
      globalstatus = true, -- Only one status line
    }
  }
end


return M
