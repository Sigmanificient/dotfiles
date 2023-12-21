local is_vt_tty = vim.fn.expand("$TERM") == "linux"

if not is_vt_tty then
  vim.cmd('colorscheme catppuccin-macchiato')
end

vim.api.nvim_set_hl(0, "Normal", { ctermbg = nil })
