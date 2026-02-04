vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- disable swap files
vim.o.swapfile = false

-- line numbers
vim.o.number = true
-- relative line numbers
vim.o.relativenumber = true

vim.o.mouse = 'a'
vim.o.showmode = false

-- sync clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true

-- case-insensitive search unless uppercase
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- configure tabs and indentation
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true

-- configure cursor appearance
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

-- add local dev plugin top path
-- ~/Documents/backlog.nvim
local local_dev_path = vim.fn.expand '~/Documents/backlog.nvim'
if vim.fn.isdirectory(local_dev_path) == 1 then
  vim.opt.rtp:append(local_dev_path)
end

-- split behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- live substitution preview
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- support for ctrl+ save for all modes
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })

-- clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- copilot setup
vim.g.copilot_filetypes = {
  ['*'] = true,
  markdown = false,
  help = false,
  gitcommit = false,
  gitrebase = false,
  hgcommit = false,
  svn = false,
  cvs = false,
}

-- copilot suggestion appearance (grey inline text)
vim.cmd [[
  highlight CopilotSuggestion guifg=#808080 ctermfg=8 gui=italic
]]

-- Copilot keymap tab completion
vim.keymap.set('i', '<Tab>', 'copilot#Accept("<CR>")', { expr = true, silent = true, desc = 'Accept Copilot suggestion' })

-- neo-tree keymap to toggle file explorer
vim.keymap.set('n', '<M-e>', '<cmd>Neotree toggle<CR>', { desc = 'Toggle File Explorer' })
-- make explorer active
vim.keymap.set('n', '<M-a>', '<cmd>Neotree focus<CR>', { desc = 'Focus File Explorer' })
-- make tab active
vim.keymap.set('n', '<M-f>', '<cmd>Neotree <CR>', { desc = 'focus on tab' })

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
-- vim: ts=2 sts=2 sw=2 et
