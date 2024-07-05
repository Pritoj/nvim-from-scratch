local keymap = vim.keymap
local api = vim.api
local uv = vim.uv

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

-- Filesystem
-- Explore
keymap.set("n", "<leader>e", "<cmd> Explore <cr>")

-- Find file with telescope
keymap.set("n", "<leader>ff", "<cmd> Telescope fd<cr>")
-- Live grep with telescope
keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep<cr>")


