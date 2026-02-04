return {
  {
    'frankogenrwoth/backlog.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('backlog').setup {
        mappings = {
          toggle = '<leader>bl',
        },
      }
      -- create a key map that calls backlog
      vim.api.nvim_set_keymap('n', '<leader>bl', ':Backlog<Cr>', { noremap = true, silent = true })
    end,
  },
}
