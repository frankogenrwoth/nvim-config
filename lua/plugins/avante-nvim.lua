return {
  "yetone/avante.nvim",
  -- If you want to build from source run: `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting!
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this to "*"!

  opts = {
    -- Add any opts here
    -- This file can contain specific instructions for your project
    instructions_file = "avante.md",

    -- Example provider setup
    provider = "copilot",
    providers = {
      copilot = {},

      ["gemini-aistudio"] = {
        __inherited_from = "openai",

        endpoint = "https://generativelanguage.googleapis.com/v1beta/",

        api_key_name = "GEMINI_API_KEY",

        model = "gemini-3.1-flash-lite", -- or whichever 2.5-pro you use in AI Studio

      },
    },
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- Optional providers
    "nvim-mini/mini.pick",        -- file_selector provider: mini.pick
    "nvim-telescope/telescope.nvim", -- file_selector provider: telescope
    "hrsh7th/nvim-cmp",           -- autocompletion for Avante commands and mentions
    "ibhagwan/fzf-lua",           -- file_selector provider: fzf
    "stevearc/dressing.nvim",     -- input provider: dressing
    "folke/snacks.nvim",          -- input provider: snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",     -- providers: "copilot"

    -- Image pasting
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- Recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- Required for Windows users
          use_absolute_path = true,
        },
      },
    },

    -- Markdown rendering (e.g., for Avante chat UI)
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

