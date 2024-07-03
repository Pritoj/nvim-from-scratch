local lspconfig = require("lspconfig")

-- Setup the Mason lsp config and pass in the lsps
-- that should definitely be installed
require("mason-lspconfig").setup({
  ensure_installed = {
    -- lua stuff
    "lua_ls",

    -- Utilities
    "jqls",
    "jsonls",
    "yamlls",
    "cssls",
    "smithy_ls",
    "html",
    "tsserver",
    "bashls"
  },
})

local ls_to_setup = {
  "jqls",
  "tsserver",
  "bashls",
  "jsonls",
  "yamlls",
  "cssls",
  "smithy_ls",
  "html",
}

-- Setups up the above servers without opts
for _, lsp in ipairs(ls_to_setup) do
  lspconfig[lsp].setup({
  })
end


lspconfig.lua_ls.setup({
  on_init = function(_)
  end,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    }
  }
})

-- Borders for floats
local border = {
  { "┏", "FloatBorder" },
  { "━", "FloatBorder" },
  { "┓", "FloatBorder" },
  { "┃", "FloatBorder" },
  { "┛", "FloatBorder" },
  { "━", "FloatBorder" },
  { "┗", "FloatBorder" },
  { "┃", "FloatBorder" },
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
-- https://neovim.discourse.group/t/how-to-show-diagnostics-on-hover/3830/2
function OpenDiagnosticIfNoFloat()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return
    end
  end
  -- Show diagnostic messages on hover https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
  -- THIS IS FOR BUILTIN LSP
  vim.diagnostic.open_float(nil, {
    scope = "cursor",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end

-- Show diagnostics under the cursor when holding position
vim.o.updatetime = 100
vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  command = "lua OpenDiagnosticIfNoFloat()",
  group = "lsp_diagnostics_hold",
})
