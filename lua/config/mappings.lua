local keymap = vim.keymap
local api = vim.api
local uv = vim.uv

local nmap = function(keys, func, desc)
  keymap.set('n', keys, func, { desc = desc })
end

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

-- Explore
nmap("<leader>e", "<cmd> Neotree focus <cr>", "Show file tree")

-- Find file with telescope
nmap("<leader>ff", "<cmd> Telescope fd<cr>", "[F]ind [F]iles")
-- Find buffer
nmap("<leader>fb", "<cmd> Telescope buffers<cr>", "[F]ind [B]uffer")
-- Live grep with telescope
nmap("<leader>fw", "<cmd> Telescope live_grep<cr>", "[F]ind [W]ord")
-- Pick colore scheme
nmap("<leader>th", "<cmd> Telescope colorscheme<cr>", "Select [th]eme")

-- Buffer switching.
nmap("<leader><S-Tab>", ":BufferLineCyclePrev<CR>", "Previous Buffer")
nmap("<leader><Tab>", ":BufferLineCycleNext<CR>", "Next Buffer")
