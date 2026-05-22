---@generic T
---@param super T[]
---@param sub T[]
---@return T[]
function table.except(super, sub)
  local result = {}
  local seenInResult = {}
  local lookupSub = {}

  for _, value in ipairs(sub) do
    lookupSub[value] = true
  end

  for _, value in ipairs(super) do
    if not lookupSub[value] and not seenInResult[value] then
      table.insert(result, value)
      seenInResult[value] = true
    end
  end

  return result
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  branch = 'main',
  config = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup({
      -- install_dir = vim.fn.stdpath('data') .. '/site',
      highlight = {
        enable = true,
        disable = {
          "python",
        },
      },
      indent = { enable = true }
    })
    local should_install =
    {
      -- Shell stuff
      "bash",

      -- Lua stuff
      "lua",

      -- WebDev
      "html",
      "css",
      "javascript",
      "typescript",
      "scss",
      "tsx",

      -- Config Formats
      "yaml",
      "toml",
      "json5",

      -- Utilities
      "jq",

      "ruby",

      "go",
      "dockerfile",
      "c",

      "markdown",
      "markdown_inline",

      "smithy",
    }
    treesitter.install(should_install)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        if
            vim.list_contains(
              treesitter.get_installed(),
              vim.treesitter.language.get_lang(args.match)
            )
        then
          vim.treesitter.start(args.buf)
        end
      end,
    })
  end
}
