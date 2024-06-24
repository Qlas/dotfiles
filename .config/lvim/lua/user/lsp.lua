require('mason-tool-installer').setup {
    ensure_installed = {
        'pyright', "typst_lsp", "rust-analyzer", "ansiblels", "luaformatter",
        "luacheck", "ansible-lint", "prettier", "flake8", "mypy",
        "markdownlint", "sql-formatter", "shfmt", "taplo", "hadolint",
        "shellcheck", "sqlfluff"
    },
    auto_update = true
}

require('lspconfig').pyright.setup {
    settings = {
        pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true
        },
        python = {
            analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = {'*'}
            }
        }
    }
}

require('lspconfig').ruff_lsp.setup {
    on_attach = on_attach,
    commands = {
        RuffAutofix = {
            function()
                vim.lsp.buf.execute_command {
                    command = 'ruff.applyAutofix',
                    arguments = {{uri = vim.uri_from_bufnr(0)}}
                }
            end,
            description = 'Ruff: Fix all auto-fixable problems'
        },
        RuffOrganizeImports = {
            function()
                vim.lsp.buf.execute_command {
                    command = 'ruff.applyOrganizeImports',
                    arguments = {{uri = vim.uri_from_bufnr(0)}}
                }
            end,
            description = 'Ruff: Format imports'
        }
    }
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {command = "lua-format", filetypes = {"lua"}}, {
        command = "sql-formatter",
        args = {"--language", "postgresql"},
        filetypes = {"sql"}
    }, {command = 'prettier', filetypes = {"markdown", "yaml", "json"}},
    {command = "shfmt", filetypes = {"sh"}},
    {command = "taplo", filetypes = {"toml"}},
    {command = "jq", filetypes = {"json"}}

}

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {command = "mypy", filetypes = {"python"}},
    {command = "luacheck", filetypes = {"lua"}},
    {command = "markdownlint", filetypes = {"markdown"}},
    {command = "shellcheck", filetypes = {"sh"}},
    {command = "hadolint", filetypes = {"dockerfile"}},
    {command = "ansiblelint", filetypes = {"yaml.ansible"}},
    {command = "protolint", filetypes = {"proto"}}
}

local on_attach = function(client, bufnr)
    if client.name == 'ruff_lsp' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end
end

require("lvim.lsp.manager").setup("pyright")
require("lvim.lsp.manager").setup("typst_lsp")
require("lvim.lsp.manager").setup("ansiblels")
