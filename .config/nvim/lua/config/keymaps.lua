-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map({ "n", "t" }, "<A-1>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "bottom", border = "single" } })
end, { desc = "Terminal bottom" })

map({ "n", "t" }, "<A-3>", function()
  Snacks.terminal(nil, { win = { position = "float", border = "single" } })
end, { desc = "Terminal float" })
