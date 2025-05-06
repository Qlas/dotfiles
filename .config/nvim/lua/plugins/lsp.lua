local lspconfig = require("lspconfig")

lspconfig.basedpyright.setup({
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",
        disableOrganizeImports = true,
      },
      -- on_attach = function(client)
      --   client.server_capabilities.documentFormattingProvider = false -- Disable formatting
      -- end,
    },
  },
})

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = { enabled = false },
    },
  },
}
