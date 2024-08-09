local M = { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' };

M.config = function()
  vim.opt.termguicolors = true
  require("bufferline").setup {
    options = {
      diagnostics = "nvim_lsp",
      close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
      left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
      middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
      separator_style = "slant",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Trees, files, whatever 🤷",
          highlight = "Directory",
          separator = true -- use a "true" to enable the default, or set your own character
        }
      },
    },
  }
end

return M
