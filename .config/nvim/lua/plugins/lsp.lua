local lspconfig = require("lspconfig")

lspconfig.basedpyright.setup({
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",
        disableOrganizeImports = true,
        inlayHints = {
          genericTypes = true,
        },
      },
    },
  },
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.definitionProvider = false
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            pyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                -- Ignore all files for analysis to exclusively use Ruff for linting
                ignore = { "*" },
              },
            },
          },
        },
      },
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting
      end,
    },
  },
}
