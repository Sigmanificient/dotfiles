local vim = vim
local NONE = nil

local attach_user_config = function(settings)
  settings["config"] = function()
    require("sigma.plugins." .. settings["_user_conf"])
  end

  return settings
end

return {
    'lukoshkin/highlight-whitespace',
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
    { "Sigmanificient/vim-epitech" },
    attach_user_config({
        'VonHeikemen/lsp-zero.nvim',
        _user_conf = "lsp",
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        },
    }),
    attach_user_config({
        'nvim-lualine/lualine.nvim',
        _user_conf = "lualine",
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    }),
    attach_user_config({
      "akinsho/toggleterm.nvim",
      _user_conf = "toggleterm",
      tag = '*',
    }),
    {
        'tanvirtin/vgit.nvim',
        version = 'v0.2.1',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('vgit').setup()
        end,
    },
    attach_user_config({
        'nvim-treesitter/nvim-treesitter',
        _user_conf = "treesitter",
        run = function()
            local ts_update = require(
              'nvim-treesitter.install'
            ).update({ with_sync = true })
            ts_update()
        end,
    }),
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
        config = function()
            require('copilot_cmp').setup()
        end,
    },
    attach_user_config({
        _user_conf = "nvimtree",
        "nvim-tree/nvim-tree.lua",
    }),
    attach_user_config({
        "nvim-telescope/telescope.nvim",
        _user_conf = "telescope",
        dependencies = { 'nvim-lua/plenary.nvim' },
    })
}
