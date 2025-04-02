local M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true },
  },

  ---@type snacks.Keys
  keys = {
    -- Files
    { "<leader>ff",  function() Snacks.picker.smart() end,           desc = "[F]ind [F]iles smartly" },
    { "<leader>ffd", function() Snacks.picker.files() end,           desc = "[F]ind [F]iles [d]umbly" },
    { "<leader>fb",  function() Snacks.picker.buffers() end,         desc = "[F]ind [B]uffers" },
    { "<leader>fw",  function() Snacks.picker.grep() end,            desc = "[F]ind [W]ord" },
    { "<leader>ch",  function() Snacks.picker.command_history() end, desc = "[C]ommand [H]istory" },
    { "<leader>nh",  function() Snacks.picker.notifications() end,   desc = "[N]otification [H]istory" },
    { "<leader>e",   function() Snacks.explorer() end,               desc = "File [E]xplorer" },
  }
}

return M
