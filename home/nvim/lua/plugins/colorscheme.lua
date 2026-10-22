local is_vt_tty = vim.fn.expand("$TERM") == "linux"

if not is_vt_tty then
  require("catppuccin").setup({
    flavour = "macchiato",
    transparent_background = false,
    dim_inactive = {
        enabled = false,
    },
    integrations = {
      blink_cmp = false,
      lualine = {
        all = {
            normal = {
                c = { bg = "#0f0f1c" },
            },
        },
      },
    }
  })

  vim.cmd.colorscheme("catppuccin-macchiato")
end

-- vim.api.nvim_set_hl(0, "Normal", { ctermbg = nil })
