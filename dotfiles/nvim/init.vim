let mapleader =","

" Install Plugin manager
" if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
" 	echo "Downloading junegunn/vim-plug to manage plugins..."
" 	silent !mkdir -p $XDG_CONFIG_HOME/nvim/autoload/
" 	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $XDG_CONFIG_HOME/nvim/autoload/plug.vim
" 	autocmd VimEnter * PlugInstall
" endif

" Plugin installed
call plug#begin('~/.config/nvim/plugged')
	Plug 'scrooloose/nerdtree'
	Plug 'bling/vim-airline'
	Plug 'unblevable/quick-scope'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'jiangmiao/auto-pairs'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
	Plug 'lambdalisue/suda.vim'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'sheerun/vim-polyglot'
	Plug 'junegunn/goyo.vim'
	Plug 'sonph/onehalf', { 'rtp': 'vim' } " Theme
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	" Plug 'Mofiqul/dracula.nvim'
call plug#end()

" Some basics:
	filetype plugin on
	syntax enable
	set encoding=utf-8
	set number relativenumber
	set nocompatible

" Colorscheme
	" set t_Co=256
	set cursorline
	colorscheme default

" Ultisnips
	let g:UltiSnipsExpandTrigger="<tab>"
	let g:UltiSnipsJumpForwardTrigger="<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<c-z>"

	" If you want :UltiSnipsEdit to split your window.
	let g:UltiSnipsEditSplit="vertical"
	let g:UltiSnipsSnippetDirectories=["fnippets"]

" Finding Files
	set path+=**
	set wildmenu

" Tag jumping
	command! MakeTags !ctags -R .

" Goyo plugin makes text more readable when writing prose:
	" map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Trigger a highlight in the appropriate direction when pressing these keys:
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
	highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
	highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" Tabs settings
	set autoindent
	set noexpandtab
	set tabstop=4
	set shiftwidth=4

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
	map <leader>c :w<CR>:make<CR>
	map <leader>d :setlocal spell spelllang=it

" Replace all is aliased to S.
	nnoremap <leader>s :%s//g<Left><Left>

" Save file as sudo on files that require root permission
	"cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
	cnoremap w!! w suda://%


" Find files using Telescope command-line sugar.
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>

