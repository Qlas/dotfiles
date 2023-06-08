lvim.plugins = {
    "AckslD/swenv.nvim", "stevearc/dressing.nvim",
    "mfussenegger/nvim-dap-python", "nvim-neotest/neotest",
    "nvim-neotest/neotest-python", "f-person/git-blame.nvim", {
        "rmagatti/goto-preview",
        config = function()
            require('goto-preview').setup {
                width = 120, -- Width of the floating window
                height = 25, -- Height of the floating window
                default_mappings = true, -- Bind default mappings
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
                -- You can use "default_mappings = true" setup option
                -- Or explicitly set keybindings
                -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
                -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
                -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
            }
        end
    }, {"ellisonleao/glow.nvim", config = true, cmd = "Glow"}
}
-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {"python"}

require("lvim.lsp.manager").setup("pyright")

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {name = "black"}, {name = "isort"},
    {command = "lua-format", filetypes = {"lua"}},
    {command = "sql-formatter", filetypes = {"sql"}},
    {command = 'prettier', filetypes = {"markdown", "yaml"}},
    {command = "shfmt", filetypes = {"sh"}}

}
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = {"*"}

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {command = "flake8", filetypes = {"python"}},
    {command = "mypy", filetypes = {"python"}},
    {command = "luacheck", filetypes = {"lua"}},
    {command = "markdownlint", filetypes = {"markdown"}},
    {command = "shellcheck", filetypes = {"sh"}}
}

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
    require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

require('swenv').setup({
    -- Should return a list of tables with a `name` and a `path` entry each.
    -- Gets the argument `venvs_path` set below.
    -- By default just lists the entries in `venvs_path`.
    get_venvs = function(venvs_path)
        return require('swenv.api').get_venvs(venvs_path)
    end,
    -- Path passed to `get_venvs`.
    venvs_path = vim.fn.expand('.'),
    -- Something to do after setting an environment, for example call vim.cmd.LspRestart
    post_set_venv = function() vim.cmd("LspRestart") end
})

require('glow').setup({style = "dark", width = 120})

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
    name = "Python",
    c = {"<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env"}
}

lvim.builtin.nvimtree.setup.disable_netrw = true
lvim.builtin.nvimtree.setup.hijack_cursor = true
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.filters.custom = {
    "__pycache__", ".mypy_cache", ".venv", ".git"
}

lvim.builtin.nvimtree.setup.diagnostics.enable = true
lvim.builtin.nvimtree.setup.diagnostics.show_on_dirs = true
