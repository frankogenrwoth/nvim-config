return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true, -- Optional: hide ghost text when cmp menu is open
          keymap = {
            accept = "<Tab>",       -- Or "<C-Right>", "<C-l>", etc.
            accept_word = "<S-Tab>",
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false }, -- Keep panel disabled unless you want it
      })
    end,
  },
  -- Remove copilot-cmp if you only want ghost text
}   
