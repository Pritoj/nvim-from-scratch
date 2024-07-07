return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-tree/nvim-web-devicons"
  },
  {
    "williamboman/mason.nvim",
    -- "williamboman/mason-lspconfig.nvim",
    -- "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup({})
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require "config.lspconfig"
    end

  },
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require "config.mini-nvim"
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-emoji',
      'onsails/lspkind-nvim'
    },
    config = function()
      require "config.nvim-cmp"
    end
  },
  {
    "Dynge/gitmoji.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {},
    ft = "gitcommit",
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  }
}
