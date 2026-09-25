vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable the use of swap files, if you forget to save then that should be on you
vim.opt.swapfile = false

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0

vim.g.python3_host_prog = vim.fn.stdpath("config") .. "/.venv/bin/python"

vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true
vim.o.showmode = false
-- using jk for entring the normal mode
vim.keymap.set("i", "jk", "<Esc>")
vim.opt.timeoutlen = 300

-- set update time to 100ms so that CursorHold events are triggered faster
vim.opt.updatetime = 150

vim.opt.mouse = "a"

vim.g.have_nerd_font = true

vim.opt.laststatus = 2

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- move to the first character on the that line ^ and also remap the key B to ^ and E to $
vim.keymap.set("n", "B", "^")
vim.keymap.set("n", "E", "$")

-- expand on a floating window for error display or warning
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "[l", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]l", vim.diagnostic.goto_next)

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
vim.o.confirm = true

-- Diagnostic Config & Keymaps
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	-- Can switch between these as you prefer
	virtual_text = true, -- Text shows up at the end of the line
	virtual_lines = false, -- Text shows up underneath the line, with virtual lines

	-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
	jump = { float = true },
})

require("config.keymaps")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- import your plugins folder
		{ import = "plugins" },
	},
	defaults = {
		lazy = true,
	},
})
