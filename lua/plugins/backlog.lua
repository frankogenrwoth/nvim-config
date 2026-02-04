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
    end,
  },
}
