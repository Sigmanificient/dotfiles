local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<CR>")
  vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFocus<CR>")
end

require("nvim-tree").setup(
{
  on_attach = on_attach,
  filters = {
    git_ignored = false,
    custom = { "^\\.git$" },
  },
}
)
