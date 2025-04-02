local keymap = vim.keymap

local nmap = function(keys, func, desc)
  keymap.set('n', keys, func, { desc = desc })
end

-- Save key strokes (now we do not need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

-- Pick colore scheme
nmap("<leader>th", "<cmd> Telescope colorscheme<cr>", "Select [th]eme")

-- Buffer switching.
nmap("<leader><S-Tab>", ":BufferLineCyclePrev<CR>", "Previous Buffer")
nmap("<leader><Tab>", ":BufferLineCycleNext<CR>", "Next Buffer")

local function insertFullPath()
  local filepath = vim.fn.expand('%')
  vim.fn.setreg('+', filepath) -- write to clippoard
end

nmap('<leader>cfp', insertFullPath, '[C]opy [F]ile [P]ath')
