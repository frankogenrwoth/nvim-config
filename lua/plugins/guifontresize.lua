local opts = { noremap = true, silent = true }

local keys = {
  { '<C-=>', '<cmd>lua require("gui-font-resize").increase()<CR>', opts },
  { '<A-->', '<cmd>lua require("gui-font-resize").decrease()<CR>', opts },
  { '<C-0>', '<cmd>lua require("gui-font-resize").reset()<CR>', opts },
}

return {
  {
    'ktunprasert/gui-font-resize.nvim',
    config = function()
      require('gui-font-resize').setup {
        step = 1,
        default_size = 12,
      }
    end,
    keys = keys,
  },
}
