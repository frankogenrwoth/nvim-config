return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- Critical: 'master' is frozen and incompatible
  build = ':TSUpdate',
  lazy = false, -- Ensure it loads early
  -- Remove 'main = "nvim-treesitter.configs"' entirely
  config = function()
    local ts = require('nvim-treesitter')
    
    -- Install parsers synchronously at startup (optional but recommended for stability)
    ts.install({ 'lua', 'vim', 'python', 'javascript', 'typescript', 'latex', 'bibtex' }) -- Add your languages
    
    -- Manually enable highlighting and indentation via autocmd
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start) -- Enable highlighting
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Enable indentation
      end,
    })
  end,
}
