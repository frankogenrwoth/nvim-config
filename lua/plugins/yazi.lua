return {
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    { "\\", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Open yazi at the current file" },
    { "cw", "<cmd>Yazi cwd<cr>", desc = "Open the file manager in nvim's working directory" },
    { "<leader>yz", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
  },
  opts = {
    open_for_directories = false,
    highlight_hovered_buffers_in_same_directory = false,
    keymaps = {
      show_help = false,
    },
    -- Use a fixed path or nvim's default if XDG_CONFIG_HOME isn't set
    config_home = vim.fn.expand("~/.config/yazi"),
  },
  init = function()
    -- Prevent netrw from loading
    vim.g.loaded_netrwPlugin = 1
  end,
}
