local treesitter = require("nvim-treesitter")

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

local ensure_installed = { "bash", "c", "lua", "vim", "python", "yaml" }
local already_installed = require("nvim-treesitter.config").get_installed()

local to_install = vim.iter(ensure_installed):filter(function(parser)
  return not vim.tbl_contains(already_installed, parser)
end):totable()

if #to_install > 0 then
  treesitter.install(to_install)
end
