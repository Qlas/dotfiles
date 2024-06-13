local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "K", function() vim.cmd.RustLsp {'hover', 'actions'} end,
               {silent = true, buffer = bufnr})

vim.keymap.set("n", "<leader>re",
               function() vim.cmd.RustLsp {'explainError'} end,
               {silent = true, buffer = bufnr, desc = "Explain Error"})

vim.keymap.set("n", "<leader>rd",
               function() vim.cmd.RustLsp {'renderDiagnostic'} end,
               {silent = true, buffer = bufnr, desc = "Diagnostic"})

vim.keymap.set("n", "<leader>rc", function() vim.cmd.RustLsp {'openCargo'} end,
               {silent = true, buffer = bufnr, desc = "Open Cargo"})
