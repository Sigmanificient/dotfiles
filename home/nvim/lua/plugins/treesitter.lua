require("nvim-treesitter.configs").setup {
  ensure_installed = { "bash", "c", "lua", "vim", "python", "yaml" },
  ignore_install = { "all" },

  sync_install = false,
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  modules = {}
}
