return { -- Collection of various small independent plugins/modules
	"nvim-mini/mini.nvim",
	lazy = false, -- Load immediately
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		print("Examples:")
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })
	end,
}
