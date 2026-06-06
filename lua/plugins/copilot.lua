return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = '<Tab>',
        accept_word = '<S-Tab>',
        accept_line = false,
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<Esc>',
        toggle_auto_trigger = false,
      },
    },
    panel = { enabled = false },
  },
  config = function(_, opts)
    require('copilot').setup(opts)

    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('copilot-inline-highlights', { clear = true }),
      callback = function()
        vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#6c7086', italic = true })
        vim.api.nvim_set_hl(0, 'CopilotAnnotation', { fg = '#6c7086' })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuClose',
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
