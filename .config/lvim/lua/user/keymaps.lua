lvim.builtin.which_key.mappings["dm"] = {
    "<cmd>lua require('neotest').run.run()<cr>", "Test Method"
}
lvim.builtin.which_key.mappings["dM"] = {
    "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
    "Test Method DAP"
}
lvim.builtin.which_key.mappings["df"] = {
    "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
    "Test Class"
}
lvim.builtin.which_key.mappings["dF"] = {
    "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
    "Test Class DAP"
}
lvim.builtin.which_key.mappings["dS"] = {
    "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary"
}

lvim.builtin.which_key.mappings["dR"] = {
    "<cmd>lua require('neotest').output.open({ enter = true })<cr>",
    "Output Window"
}

-- Telescope

lvim.builtin.which_key.mappings["f"] = {
    name = "Find",
    b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
    f = {"<cmd>Telescope find_files<cr>", "Find files"},
    t = {"<cmd>Telescope live_grep<cr>", "Find Text"},
    h = {"<cmd>Telescope help_tags<cr>", "Help"},
    H = {"<cmd>Telescope highlights<cr>", "Highlights"},
    l = {"<cmd>Telescope resume<cr>", "Last Search"},
    r = {"<cmd>Telescope oldfiles<cr>", "Recent File"},
    R = {"<cmd>Telescope registers<cr>", "Registers"},
    k = {"<cmd>Telescope keymaps<cr>", "Keymaps"},
    C = {"<cmd>Telescope commands<cr>", "Commands"},
    p = {"<cmd>Telescope projects<cr>", "Projects"}

}
