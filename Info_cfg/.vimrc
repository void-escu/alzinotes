syntax enable
set tabstop=2
set shiftwidth=2
set expandtab
set foldmethod=syntax
set number

set tags+=~/tags
set tags+=~/src/tags
set autowrite
set smartindent

set background=dark

map <F11> : let &background = "dark"<CR>
map <F12> : let &background = "light"<CR>

function! RevBack()
 if &background=="light"
   set background=dark
 else
   set background=light
 endif
endfunction
command! Swbg call RevBack()
noremap <F10> :Swbg<CR>

function! IndCpy()
if &number
  set nonumber
  set noexpandtab
  set nosmartindent
else
  set number
  set expandtab
  set smartindent
endif
endfunction
command! NoD call IndCpy()
noremap <F9> :NoD<CR>

map <F8> : set number! expandtab! smartindent!<CR>

