return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = {
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
	},
          sync_install = false,
          highlight = {
		enable = true,
				disable = {
                        "python",
                },

	},
          indent = { enable = true }
        })
    end
 }
