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

function! DebugMsg(msg) abort
    if !exists("g:DebugMessages")
        let g:DebugMessages = []
    endif
    call add(g:DebugMessages, a:msg)
endfunction

function! PrintDebugMsgs() abort
  if empty(get(g:, "DebugMessages", []))
    echo "No debug messages."
    return
  endif
  for ln in g:DebugMessages
    echo "- " . ln
  endfor
endfunction

command DebugStatus call PrintDebugMsgs()

function! LoadProjectLanguages()
  let l:project_root = finddir('.git', '.;')

  if !empty(l:project_root)
    let l:project_root = getcwd() . '/' . l:project_root
  endif

  if empty(l:project_root)
    return
  endif

  let l:project_root = substitute(l:project_root, '/\.git$', '', '')
  if isdirectory(l:project_root)
    execute 'set runtimepath+=' . l:project_root

    " project/
    for f in split(glob(l:project_root . '/*.vim'), '\n')
      execute 'source ' . f
    endfor
  endif


  let l:lang_dir = l:project_root . '/languages'
  if isdirectory(l:lang_dir)
    execute 'set runtimepath+=' . l:lang_dir

    " project/languages
    for f in split(glob(l:lang_dir . '/*.vim'), '\n')
      execute 'source ' . f
    endfor
  endif

endfunction


autocmd BufEnter,BufNewFile * if &buftype == "" | call LoadProjectLanguages()
