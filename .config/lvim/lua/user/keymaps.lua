pick_venv = function()
    local path = vim.fn.getcwd() .. "/.venv";

    if vim.fn.isdirectory(path) ~= 1 then
        vim.notify("There is no .venv directory in the project",
                   vim.log.levels.ERROR, {title = "Venv"})
        return
    end

    vim.fn.setenv('VIRTUAL_ENV', path)

    vim.fn.setenv('PATH', path .. '/bin' .. ':' .. vim.fn.getenv('PATH'))

    vim.cmd("LspRestart")

    vim.notify("Venv was set successfully.", vim.log.levels.INFO,
               {title = "Venv"})

end

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

-- venv
lvim.builtin.which_key.mappings["C"] = {
    name = "Python",
    c = {"<cmd> lua pick_venv()<cr>", "Pick Env"}
}

-- Telescope

lvim.builtin.which_key.mappings["t"] = {
    name = "Telescope",
    l = {"<cmd> Telescope live_grep <cr>", "Live Grep"},
    f = {"<cmd> Telescope find_files <cr>", "Live Grep"}

}
