local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local mappings = {
	C = {
		name = "Rust",
		r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
		m = { "<cmd>RustLsp expandMacro<Cr>", "Expand Macro" },
		c = { "<cmd> RustLsp openCargo<Cr>", "Open Cargo" },
		D = { "<cmd>rustLsp externalDocs<Cr>", "Open Docs" },
		p = { "<cmd>RustLsp parentModule<Cr>", "Parent Module" },
		d = { "<cmd>RustLsp debuggables<Cr>", "Debuggables" },
		v = { "<cmd>RustLsp crateGraph<Cr>", "View Crate Graph" },
	},
}

which_key.register(mappings, opts)

require("neotest").setup({
	adapters = {
		require("neotest-rust"),
	},
})
