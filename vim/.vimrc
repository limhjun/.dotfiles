syntax on
filetype plugin indent on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

set backspace=indent,eol,start

" macOS 클립보드 연동(yy, p가 시스템 클립보드랑 같이 놀게)
set clipboard=unnamedplus

nnoremap <leader>cf :%!clang-format<CR>

