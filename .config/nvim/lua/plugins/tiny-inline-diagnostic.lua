return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "ghost",
      options = {
        show_source = true,
        multilines = { enabled = true },
        enable_on_select = true,
      },
    })
    vim.diagnostic.config({ virtual_text = false })
  end,
}
