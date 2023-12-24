let mapleader = "\<Space>"
nnoremap <leader>pv :Ex<CR>

set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

set expandtab
set number
set relativenumber

set noswapfile
set undodir=$HOME/.vim/undodir
set undofile

set colorcolumn=80
set cursorline

lua require("init")

highlight Visual ctermfg=white ctermbg=blue cterm=bold

