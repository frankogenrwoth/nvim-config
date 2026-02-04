-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- setting leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- general keymaps
map('i', 'jk', '<ESC>', opts)
map('n', '<leader>nh', ':nohl<CR>', opts)
map('n', 'x', '"_x', opts)
map('n', '<leader>+', '<C-a>', opts)

-- General
map('n', '<leader>w', ':w<CR>', { desc = 'Save' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
map('n', '<C-h>', '<C-w>h', { desc = 'Left window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Right window' })

-- Buffers
map('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

-- LSP
map('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
map('n', '<leader>gr', vim.lsp.buf.references, { desc = 'Goto References' })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })

-- Telescope (or your fuzzy finder)
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
