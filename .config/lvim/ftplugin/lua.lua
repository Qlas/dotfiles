local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { command = "luacheck" } })
