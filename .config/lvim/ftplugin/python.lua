local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local pyright_opts = {
	settings = {
		pyright = {
			disableOrganizeImports = true, -- Using Ruff
		},
	},
}

local ruff_on_attach = function(client, bufnr)
	-- Disable hover in favor of Pyright
	client.server_capabilities.hoverProvider = false

	-- Add ruff applyOrganizeImports on save
	local ruff_lsp_client = require("lspconfig.util").get_active_client_by_name(bufnr, "ruff_lsp")

	local request = function(method, params)
		ruff_lsp_client.request(method, params, nil, bufnr)
	end

	local organize_imports = function()
		request("workspace/executeCommand", {
			command = "ruff.applyOrganizeImports",
			arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
		})
	end

	vim.api.nvim_create_user_command("RuffOrganizeImports", organize_imports, { desc = "Ruff: Organize Imports" })

	vim.api.nvim_create_autocmd("BufWrite", {
		pattern = { "*.py" },
		command = "RuffOrganizeImports",
	})
end

local ruff_opts = { on_attach = ruff_on_attach }

require("lvim.lsp.manager").setup("pyright", pyright_opts)
require("lvim.lsp.manager").setup("ruff_lsp", ruff_opts)

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { command = "mypy" } })

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
		}),
	},
})
