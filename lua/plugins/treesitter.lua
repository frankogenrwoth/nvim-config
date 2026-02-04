return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' }, -- lazy-load on file open
    config = function()
      local ok, ts = pcall(require, 'nvim-treesitter.configs')
      if not ok then
        vim.notify('nvim-treesitter not installed yet', vim.log.levels.WARN)
        return
      end

      ts.setup {
        ensure_installed = {
          'bash',
          'c',
          'diff',
          'html',
          'lua',
          'python',
          'javascript',
          'luadoc',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
      }
    end,
  },
}
