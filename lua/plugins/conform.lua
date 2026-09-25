return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },

	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({
					async = true,
					lsp_format = "fallback",
				})
			end,
			mode = { "n", "v" },
			desc = "[F]ormat buffer",
		},
	},

	opts = {
		notify_on_error = false,

		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},

		formatters_by_ft = {
			lua = { "stylua" },

			python = {
				"ruff_organize_imports",
				"ruff_format",
			},

			javascript = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},

			javascriptreact = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},

			typescript = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},

			typescriptreact = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},

			json = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},

			yaml = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},

			markdown = {
				"prettierd",
				"prettier",
				stop_after_first = true,
			},
		},
	},
}
