local vim = vim
local NONE = nil

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd('colorscheme catppuccin-macchiato')
            vim.api.nvim_set_hl(0, "Normal", {ctermbg=NONE})
        end
    },
    { "wakatime/vim-wakatime", lazy = false },
-- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            require('sigma.plugins.lsp')
        end,
    },
-- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
            require('sigma.plugins.lualine')
        end,
    },
-- Lazygit Term
    {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("sigma.plugins.toggleterm")
        end
    },
-- Visual Git
    {
        'tanvirtin/vgit.nvim',
        version = 'v0.2.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('vgit').setup()
        end,
    },
-- Syntax Highlighing
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require(
              'nvim-treesitter.install'
            ).update({ with_sync = true })
            ts_update()
        end,
        config = function()
           require('sigma.plugins.treesitter')
        end,
    },
-- Copilot
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup()
        end,
    },
    {
        'zbirenbaum/copilot-cmp',
        after = { 'copilot.lua' },
        config = function ()
            require('copilot_cmp').setup()
        end
    }
}
