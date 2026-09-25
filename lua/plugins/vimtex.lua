return {
	"lervag/vimtex",
	ft = { "tex", "bib", "plaintex" },
	init = function()
		-- Compilation via latexmk
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-pdf",
				"-shell-escape",
				"-verbose",
				"-interaction=nonstopmode",
			},
		}

		-- Compile on save via the continuous latexmk job
		vim.g.vimtex_compiler_latexmk_continuous = 1

		-- Report errors to the quickfix list instead of showing a message
		vim.g.vimtex_quickfix_mode = 0
	end,
	config = function()
		-- Do not let VimTeX steal K; TexLab provides hover instead
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "tex", "plaintex", "bib" },
			callback = function()
				vim.keymap.set({ "n", "i" }, "K", vim.lsp.buf.hover, { buffer = true, desc = "LSP: Hover" })
			end,
		})
	end,
}
