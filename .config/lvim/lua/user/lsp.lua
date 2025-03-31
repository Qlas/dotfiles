require("mason-tool-installer").setup({
	ensure_installed = {
		"tinymist",
		"rust-analyzer",
		"ansiblels",
		"stylua",
		"luacheck",
		"ansible-lint",
		"prettier",
		"markdownlint",
		"sql-formatter",
		"shfmt",
		"taplo",
		"hadolint",
		"shellcheck",
		"sqlfluff",
	},
	auto_update = true,
})

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		command = "sql-formatter",
		args = { "--language", "postgresql" },
		filetypes = { "sql" },
	},
	{ command = "prettier", filetypes = { "markdown", "yaml", "json" } },
	{ command = "shfmt", filetypes = { "sh" } },
	{ command = "taplo", filetypes = { "toml" } },
	{ command = "jq", filetypes = { "json" } },
})

-- setup linting
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "markdownlint", filetypes = { "markdown" } },
	{ command = "shellcheck", filetypes = { "sh" } },
	{ command = "hadolint", filetypes = { "dockerfile" } },
	{ command = "ansiblelint", filetypes = { "yaml.ansible" } },
	{ command = "protolint", filetypes = { "proto" } },
	{
		command = "mypy",
		filetypes = { "python" },
		prefer_local = ".venv",
	},
})

require("lvim.lsp.manager").setup("typst_lsp")
require("lvim.lsp.manager").setup("ansiblels")
