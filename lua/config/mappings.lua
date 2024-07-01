local keymap = vim.keymap
local api = vim.api
local uv = vim.uv

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

