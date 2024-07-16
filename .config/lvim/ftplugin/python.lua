local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local pyright_opts = {
	settings = {
		pyright = {
			disableOrganizeImports = true, -- Using Ruff
		},
		python = {
			analysis = {
				ignore = { "*" },
			},
		},
	},
}

local ruff_on_attach = function(client, bufnr)
	-- Disable hover in favor of Pyright
	client.server_capabilities.hoverProvider = false

	-- Add ruff applyOrganizeImports on save
	local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" } },
				apply = true,
			})
			vim.wait(100)
		end,
		buffer = bufnr,
		group = augroup,
	})
end

local ruff_opts = { on_attach = ruff_on_attach }

require("lvim.lsp.manager").setup("pyright", pyright_opts)
require("lvim.lsp.manager").setup("ruff_lsp", ruff_opts)

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { command = "mypy", only_local = ".venv" } })

local opts = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

pick_venv = function()
	local path = vim.fn.getcwd() .. "/.venv"

	if vim.fn.isdirectory(path) ~= 1 then
		vim.notify("There is no .venv directory in the project", vim.log.levels.ERROR, { title = "Venv" })
		return
	end

	vim.fn.setenv("VIRTUAL_ENV", path)

	vim.fn.setenv("PATH", path .. "/bin" .. ":" .. vim.fn.getenv("PATH"))

	vim.cmd("LspRestart")

	vim.notify("Venv was set successfully.", vim.log.levels.INFO, { title = "Venv" })
end

local mappings = {
	C = { name = "Python", c = { "<cmd> lua pick_venv()<cr>", "pick env" } },
}

which_key.register(mappings, opts)

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
	require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false, console = "integratedTerminal" },
			runner = "pytest",
			args = { "-vv" },
		}),
	},
})
