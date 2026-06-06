vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")
local ls = require("luasnip")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if ls.jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
	}),

	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end,
	},
})

ls.config.set_config({
	history = false,
	updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_lua").lazy_load({
	paths = { vim.fn.stdpath("config") .. "/lua/custom/snippets" },
})

local function feed_fallback_key(key)
	local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end

vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if cmp.visible() then
		cmp.select_next_item()
	elseif ls.expand_or_jumpable() then
		ls.expand_or_jump()
	else
		feed_fallback_key("<C-k>")
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if cmp.visible() then
		cmp.select_prev_item()
	elseif ls.jumpable(-1) then
		ls.jump(-1)
	else
		feed_fallback_key("<C-j>")
	end
end, { silent = true })

