lvim.plugins = {
    "nvim-lua/plenary.nvim", "nvim-neotest/nvim-nio",
    "WhoIsSethDaniel/mason-tool-installer.nvim", "isobit/vim-caddyfile",
    "rcarriga/nvim-notify", "stevearc/dressing.nvim",
    "rhysd/conflict-marker.vim", "mfussenegger/nvim-dap-python",
    "nvim-neotest/neotest", "nvim-neotest/neotest-python",
    "f-person/git-blame.nvim", "pearofducks/ansible-vim", {
        "rmagatti/goto-preview",
        config = function()
            require('goto-preview').setup {
                width = 120,
                height = 25,
                default_mappings = true,
                debug = false,
                opacity = nil,
                post_open_hook = nil
            }
        end
    }, {"ellisonleao/glow.nvim", config = true, cmd = "Glow"}, {
        "iamcco/markdown-preview.nvim",
        config = function() vim.fn["mkdp#util#install"]() end
    }, {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    }, {
        "mrcjkb/rustaceanvim",
        version = "^4",
        dependencies = {
            "mfussenegger/nvim-dap", {"lvimuser/lsp-inlayhints.nvim", opts = {}}
        },
        ft = {"rust"},
        config = function()
            vim.g.rustaceanvim = {
                inlay_hints = {highlight = "NonText"},
                tools = {hover_actions = {auto_focus = true}},
                server = {
                    on_attach = function(client, bufnr)
                        require("lsp-inlayhints").on_attach(client, bufnr)
                    end
                }
            }
        end
    }
}
