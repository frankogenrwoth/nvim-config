return {
  "yetone/avante.nvim",

  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",

  event = "VeryLazy",
  version = false,

  keys = {
    { "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "Avante Ask" },
    { "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Avante Edit" },
  },

  opts = {
    instructions_file = "avante.md",
    provider = "gemini",
    providers = {
      gemini = {
        model = "gemini-3.1-flash-lite",
      },
    },
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    {
      "zbirenbaum/copilot.lua",
      opts = {
        suggestion = {
          enabled = false,
        },
        panel = {
          enabled = false,
        },
      },
    },

    -- Optional providers/UI
    "nvim-mini/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",

    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },

    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "Avante" },
      opts = {
        file_types = { "markdown", "Avante" },
      },
    },
  },
}
