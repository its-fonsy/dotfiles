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
	Plug 'sainnhe/sonokai'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'jiangmiao/auto-pairs'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
	Plug 'lambdalisue/suda.vim'
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'sheerun/vim-polyglot'
call plug#end()

" Some basics:
	filetype plugin on
	syntax enable
	set encoding=utf-8
	set number relativenumber
	set nocompatible

" Sonokai theme
	if has('termguicolors')
	  set termguicolors
	endif

	" The configuration options should be placed before `colorscheme sonokai`.
	let g:sonokai_style = 'andromeda'
	let g:sonokai_enable_italic = 1
	let g:sonokai_disable_italic_comment = 1
	let g:airline_theme = 'sonokai'

	colorscheme sonokai

" " Gruvbox theme
" 	set termguicolors
" 	set background=dark
" 	let g:gruvbox_material_background = 'hard'
" 	let g:airline_theme = 'gruvbox_material'
" 	colorscheme gruvbox-material

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

" Replace all is aliased to S.
	nnoremap <leader>s :%s//g<Left><Left>

" Save file as sudo on files that require root permission
	"cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
	cnoremap w!! w suda://%
