lvim.builtin.treesitter.ensure_installed = {
  "python",
}

lvim.format_on_save = {
  enabled = true
}

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  -- { command = "mypy",  filetypes = { "python" } },

}

local linters = require "lvim.lsp.null-ls.linters"

linters.setup { { command = "flake8", filetypes = { "python" } }, { command = "mypy", filetypes = { "python" } }
}
