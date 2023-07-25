local opt = vim.opt;
local wo = vim.wo;

opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.number = true;
opt.relativenumber = true;

opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true

wo.colorcolumn = '80';
opt.cursorline = true;

