return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
      { '<leader>f3', '<cmd>Telescope git_files<cr>', desc = 'Git Files' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find Buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
            ['<C-u>'] = false, -- disable page up
            ['<C-d>'] = false, -- disable page down
          },
          n = {
            ['q'] = 'close',
          },
        },
        path_display = { 'smart' },
      },
    },
    config = function(_, opts)
      local telescope = require 'telescope'
      telescope.setup(opts)
      telescope.load_extension 'fzf'
    end,
  },
}
