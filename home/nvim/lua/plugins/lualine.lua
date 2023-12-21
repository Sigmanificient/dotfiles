local lualine = require("lualine")
local catppuccin_theme = require("lualine.themes.catppuccin")

catppuccin_theme.normal.c.bg = "#0f0f1c";

lualine.setup {
  options = { theme = catppuccin_theme },
}
