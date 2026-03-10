-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.lazyvim_python_ruff = "ruff"

vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = {},
          }, -- Remove all ignored macros
        },
      },
    },
  },
}
