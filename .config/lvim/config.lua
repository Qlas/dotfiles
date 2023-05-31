-- lvim.plugins = {
--     "AckslD/swenv.nvim", "stevearc/dressing.nvim",
--     "mfussenegger/nvim-dap-python", "nvim-neotest/neotest",
--     "nvim-neotest/neotest-python"
-- }
-- lvim.builtin.treesitter.ensure_installed = {"python"}
-- lvim.format_on_save = {enabled = true}
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--     {command = "black", filetypes = {"python"}},
--     {command = "isort", filetypes = {"python"}},
--     {command = "lua-format", filetypes = {"lua"}}
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--     {command = "flake8", filetypes = {"python"}}, {
--         command = "mypy",
--         filetypes = {"python"},
--         {command = "luacheck", filetypes = {"lua"}}
--     }
-- }
-- require('swenv').setup({post_set_venv = function() vim.cmd("LspRestart") end})
-- -- binding for switching
-- lvim.builtin.which_key.mappings["C"] = {
--     name = "Python",
--     c = {"<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env"}
-- }



-- install plugins
lvim.plugins = {
  "AckslD/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python",
  "f-person/git-blame.nvim",
{
  "rmagatti/goto-preview",
  config = function()
  require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = true; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
    }
  end
},
{"ellisonleao/glow.nvim", config = true, cmd = "Glow"}
}
-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

require("lvim.lsp.manager").setup("pyright")

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, { name = "isort"} }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" }}, {command = "mypy", filetypes = { "python" }} } 

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }


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
  post_set_venv = function() vim.cmd("LspRestart") end,
})

require('glow').setup({
  style = "dark",
  width = 120,
})

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
