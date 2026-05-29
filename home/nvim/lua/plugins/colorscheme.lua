local is_vt_tty = vim.fn.expand("$TERM") == "linux"

if not is_vt_tty then
  require("catppuccin").setup({
    integrations = {
      blink_indent = false,
    }
  })

  vim.cmd.colorscheme("catppuccin")
end

vim.api.nvim_set_hl(0, "Normal", { ctermbg = nil })
