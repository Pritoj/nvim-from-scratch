-- Thanks to https://github.com/JavierLuna/dots/blob/main/nvim/.config/nvim/lua/plugins/lsp.lua
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>fm', vim.lsp.buf.format, '[F]or[M]at')

  nmap('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
-- To be added when I add code completion
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


local ls_to_setup = {
  lua_ls = {
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
  },
  jqls = {},
  tsserver = {},
  bashls = {},
  jsonls = {},
  yamlls = {},
  cssls = {},
  smithy_ls = {},
  html = {},
}

local mason_lspconfig = require 'mason-lspconfig'

-- Setup the Mason lsp config and pass in the lsps
-- that should definitely be installed
mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(ls_to_setup),
})

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = ls_to_setup[server_name],
      filetypes = (ls_to_setup[server_name] or {}).filetypes,
    }
  end,
}


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

