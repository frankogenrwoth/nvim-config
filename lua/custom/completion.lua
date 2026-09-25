vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")
local ls = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.config.disable,
    ["<S-Tab>"] = cmp.config.disable,
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    ["<C-e>"] = cmp.mapping.abort(),
  }),
  performance = {
    max_view_entries = 10,
    fetching_timeout = 200,
    confirm_resolve_timeout = 80,
    async_budget = 1,
    throttle = 60,
  },
})

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "cmdline" },
    { name = "path" },
  }),
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

ls.config.set_config({
  history = false,
  updateevents = "TextChanged,TextChangedI",
})

require("luasnip.loaders.from_lua").lazy_load({
  paths = { vim.fn.stdpath("config") .. "/lua/custom/snippets" },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    cmp.setup.buffer({
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      },
    })
  end,
})
