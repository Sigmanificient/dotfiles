local Terminal = require("toggleterm.terminal").Terminal

local floating_term = function(do_cmd)
  return Terminal:new({
    cmd = do_cmd;
    hidden = true,
    direction = "float",
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(
      term.bufnr,
      "n", "q", "<cmd>close<CR>",
      { noremap = true, silent = true }
      )
    end,
  })
end

local lazygit = floating_term("lazygit || nix run nixpkgs#lazygit");
local fzf_make = floating_term("fzf-make || nix run nixpkgs#fzf-make");

vim.keymap.set("n", "<leader>gl", function() lazygit:toggle() end)
vim.keymap.set("n", "<leader>fz", function() fzf_make:toggle() end)
