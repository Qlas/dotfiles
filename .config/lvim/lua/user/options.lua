lvim.colorscheme = "citruszest"

lvim.builtin.treesitter.ensure_installed = {
	"python",
	"rust",
	"json",
	"bash",
	"lua",
}
vim.filetype.add({ extension = { typ = "typst" } })

vim.opt.relativenumber = true

lvim.format_on_save.enabled = true

lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.hijack_cursor = true
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.filters.custom = {
	"__pycache__",
	".mypy_cache",
	".venv",
}

lvim.builtin.nvimtree.setup.diagnostics.enable = true
lvim.builtin.nvimtree.setup.diagnostics.show_on_dirs = true

vim.g.mkdp_theme = "dark"

lvim.lsp.null_ls.setup.timeout_ms = 20000
vim.lsp.buf.format({ timeout_ms = 20000 })

vim.notify = require("notify")
require("notify").setup({ background_colour = "#1a1b26" })

require("glow").setup({ style = "dark", width = 120 })
