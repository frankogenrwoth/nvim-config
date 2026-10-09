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

  -- Avante's Copilot provider reads ~/.config/github-copilot/hosts.json
  -- (copilot.lua) or apps.json (copilot.vim) during setup and errors if
  -- neither exists. That fails this plugin's config even when Gemini is
  -- selected, if a saved model pins Copilot. Fall back until :Copilot auth.
  config = function(_, opts)
    local function copilot_auth_ready()
      local config_home = vim.env.XDG_CONFIG_HOME
      if type(config_home) ~= "string" or config_home == "" or vim.fn.isdirectory(config_home) == 0 then
        config_home = vim.fn.expand("~/.config")
      end
      local dir = config_home .. "/github-copilot"
      return vim.fn.filereadable(dir .. "/hosts.json") == 1 or vim.fn.filereadable(dir .. "/apps.json") == 1
    end

    if not copilot_auth_ready() then
      local state = vim.fn.stdpath("state") .. "/avante/config.json"
      if vim.fn.filereadable(state) == 1 then
        local ok, saved = pcall(vim.json.decode, table.concat(vim.fn.readfile(state), "\n"))
        if ok and type(saved) == "table" and saved.last_provider == "copilot" then
          os.remove(state)
        end
      end

      local switched = false
      if opts.provider == "copilot" then
        opts.provider = "gemini"
        switched = true
      end
      if opts.auto_suggestions_provider == "copilot" then
        opts.auto_suggestions_provider = nil
        switched = true
      end
      if opts.memory_summary_provider == "copilot" then
        opts.memory_summary_provider = nil
        switched = true
      end
      if switched then
        vim.notify(
          "Avante: Copilot is not authenticated (missing ~/.config/github-copilot/hosts.json). Using Gemini. Run :Copilot auth, then set provider = 'copilot'.",
          vim.log.levels.WARN
        )
      end
    end

    require("avante").setup(opts)
  end,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- Inline suggestions are configured in lua/plugins/copilot.lua.
    -- Do not pass opts here; they merge over that plugin and disable ghost text.
    "zbirenbaum/copilot.lua",

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
