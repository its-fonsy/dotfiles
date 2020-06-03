let mapleader =","

" Install Plugin manager
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Plugin installed
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'unblevable/quick-scope'

Plug 'sainnhe/gruvbox-material'
Plug 'dylanaraps/wal.vim'

Plug 'tpope/vim-commentary'

Plug 'Yggdroot/indentLine'
Plug 'valloric/MatchTagAlways'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'svermeulen/vim-yoink'
Plug 'lervag/vimtex'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lambdalisue/suda.vim'
call plug#end()

" Some basics:
	filetype plugin on
	syntax enable
	set encoding=utf-8
	set number relativenumber
	set nocompatible

" Gruvbox theme
	set termguicolors
	set background=dark
	let g:gruvbox_material_background = 'hard'
	let g:airline_theme = 'gruvbox_material'
	colorscheme gruvbox-material
	"colorscheme wal

" Finding Files
	set path+=**
	set wildmenu

" Tag jumping
	command! MakeTags !ctags -R .

" Yoink Plugin Setup
	nmap <c-n> <plug>(YoinkPostPasteSwapBack)
	nmap <c-p> <plug>(YoinkPostPasteSwapForward)

	nmap p <plug>(YoinkPaste_p)
	nmap P <plug>(YoinkPaste_P)

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Trigger a highlight in the appropriate direction when pressing these keys:
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
	highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
	highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" Tabs settings
	set autoindent
	set noexpandtab
	set tabstop=4
	set shiftwidth=4

" indentLine
	let g:indentLine_char = '¦'
	let g:indentLine_concealcursor = ''
	let g:indentLine_conceallevel = 0
	let g:indentLine_setConceal = 0

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Quick saving and quitting:
	map <leader>w :w<CR>
	map <leader>q :q<CR>

" Copy visual selection to clipboard
	map <leader>y :"+y

" Replace all is aliased to S.
	nnoremap <leader>s :%s//g<Left><Left>

" Save file as sudo on files that require root permission
	"cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
	cnoremap w!! w suda://%

" Automatically deletes all trailing whitespace on save.
	" autocmd BufWritePre * %s/\s\+$//e

" Quickly compile LaTeX
	autocmd FileType tex nnoremap <leader>c :!pdflatex %<CR>

" Snippet
	autocmd FileType html runtime snippet/html/html.vim
