set mouse-=a
set nu
set nowrap
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set smartindent
filetype plugin indent on
syntax enable

set autowrite
set writebackup
set backup
set backupdir=$HOME/.vim/backup/,/tmp
set directory=$HOME/.vim/backup/,/tmp

" Highlight trailing whitespace and tabs
highlight link RedundantSpaces Error
au BufEnter,BufRead * match RedundantSpaces "\t"
au BufEnter,BufRead * match RedundantSpaces "[[:space:]]\+$"
" Set default sh to bash
let g:is_sh   = 1

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
