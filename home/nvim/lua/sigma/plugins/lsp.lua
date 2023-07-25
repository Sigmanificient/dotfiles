local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.nil_ls.setup({})
lspconfig.clangd.setup({})
lspconfig.pyright.setup({})

-- ↓ Epitech CS
local configs = require('lspconfig.configs')

if not configs.ecsls then
  configs.ecsls = {
    default_config = {
      root_dir = lspconfig.util.root_pattern(".git", "Makefile"),
      cmd = { 'ecsls_run' },
      filetypes = { 'c' },
      init_options = {
        command = { 'ecsls_run' },
      },
    },
  }
end

lspconfig.ecsls.setup({})
--

lsp.on_attach(function(_, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

