set mouse-=a
set nu
set nowrap
set noexpandtab
set autoindent
set shiftwidth=4
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
"vala
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

" Disable valadoc syntax highlight
"let vala_ignore_valadoc = 1

" Enable comment strings
let vala_comment_strings = 1
" Highlight space errors
let vala_space_errors = 1
" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120
