return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      -- Telescope setup
      vim.keymap.set('n', '<leader>en', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath 'config',
        }
      end, { desc = 'edit neovim' })

      -- General Telescope keymaps
      vim.keymap.set('n', '<leader>fd', require('telescope.builtin').find_files, { desc = 'Telescope Find Files' })
    end,
  },
}
