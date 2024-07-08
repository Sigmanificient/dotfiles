local attach_user_config = function(settings)
  settings["config"] = function()
    require("plugins." .. settings["_user_conf"])
  end

  return settings
end

local apply_shortcut = function(plugins)
  for _, plugin in ipairs(plugins) do
    if type(plugin) == "table" then
      if plugin._user_conf then
        attach_user_config(plugin)
      end
    end
  end
  return plugins
end

return apply_shortcut({
  "lukoshkin/highlight-whitespace",
  {
    "catppuccin/nvim",
    _user_conf = "colorscheme",
    name = "catppuccin",
    priority = 1000,
  },
  { "wakatime/vim-wakatime", lazy = false },
  "Sigmanificient/vim-epitech",
  {
    "VonHeikemen/lsp-zero.nvim",
    _user_conf = "lsp",
    branch = "v2.x",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    _user_conf = "lualine",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  },
  {
    "akinsho/toggleterm.nvim",
    _user_conf = "toggleterm",
    tag = "*",
  },
  {
    "tanvirtin/vgit.nvim",
    version = "v0.2.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("vgit").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    _user_conf = "treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install")
        .update({ with_sync = true })
      ts_update()
    end,
  },
  {
    _user_conf = "nvimtree",
    "nvim-tree/nvim-tree.lua",
  },
  {
    "nvim-telescope/telescope.nvim",
    _user_conf = "telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
})
