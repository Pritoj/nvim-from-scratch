local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true },
    toggle = { enabled = true },
    input = { enabled = true },
    scroll = { enabled = true },
    words = { enabled = true },
    notifier = { enabled = true },
    dim = { enabled = true },

  },

  keys = {
    -- Files
    { "<leader>ff",      function() Snacks.picker.smart() end,            desc = "[F]ind [F]iles smartly" },
    { "<leader><space>", function() Snacks.picker.files() end,            desc = "Find Files dumbly" },
    { "<leader>fb",      function() Snacks.picker.buffers() end,          desc = "[F]ind [B]uffers" },
    { "<leader>e",       function() Snacks.explorer() end,                desc = "File [E]xplorer" },
    { "<leader>fw",      function() Snacks.picker.grep() end,             desc = "[F]ind [W]ord" },

    -- History
    { "<leader>ch",      function() Snacks.picker.command_history() end,  desc = "[C]ommand [H]istory" },
    { "<leader>nh",      function() Snacks.picker.notifications() end,    desc = "[N]otification [H]istory" },

    -- References
    { "<leader>nr",      function() Snacks.words.jump(vim.v.count1) end,  desc = "[N]ext [R]eference",      mode = { "n", "t" } },
    { "<leader>pr",      function() Snacks.words.jump(-vim.v.count1) end, desc = "[P]rev [R]eference",      mode = { "n", "t" } },
  }
}

M.init = function()
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      -- Setup some globals for debugging (lazy-loaded)
      _G.dd = function(...)
        Snacks.debug.inspect(...)
      end
      _G.bt = function()
        Snacks.debug.backtrace()
      end
      vim.print = _G.dd -- Override print to use snacks for `:=` command

      -- Create some toggle mappings
      Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
      Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
      Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
      Snacks.toggle.diagnostics():map("<leader>ud")
      Snacks.toggle.line_number():map("<leader>ul")
      Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
        "<leader>uc")
      Snacks.toggle.treesitter():map("<leader>uT")
      Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
      Snacks.toggle.inlay_hints():map("<leader>uh")
      Snacks.toggle.indent():map("<leader>ug")
      Snacks.toggle.dim():map("<leader>uD")
    end,
  })
end

return M
