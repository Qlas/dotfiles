return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = { list = { keys = {} } },
    },
    picker = {
      sources = {
        explorer = {
          hidden = {},
          ignored = {},
          exclude = { "*_cache", "__pycache__", ".venv" },
          win = {
            list = {
              keys = {
                -- FIXME: cannot open directory with this keymap
                -- ["<CR>"] = { { "pick_win", "confirm" }, mode = { "n", "i" } },
                ["<c-v>"] = { { "pick_win", "edit_vsplit" }, mode = { "i", "n" } },
                ["<c-s>"] = { { "pick_win", "edit_split" }, mode = { "i", "n" } },
              },
            },
          },
        },
      },
    },
  },
}
