" set SPACE as leader key
let mapleader =" "

" basics
syntax enable
filetype plugin on
colorscheme koehler
set nocompatible
set encoding=utf-8
set number relativenumber
set showcmd

" finding files in a fuzzy way
set path+=**
set wildmenu

" tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nohlsearch
set incsearch

set scrolloff=10
set signcolumn="yes"
set colorcolumn=80

" NETRw config
nnoremap <leader>pv :Ex<CR>
nnoremap <leader>pf :find *

" remaps
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap J mzJ`z
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" substitue all occurences of word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" status line
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

set laststatus=2

set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\ 
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
