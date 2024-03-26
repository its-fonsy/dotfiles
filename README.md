# dotfiles
This is the repo used to manage my dotfiles.

## Install
Run

	git clone --recursive https://github.com/its-fonsy/dotfiles.git
	make init

## Configuration
The program that I use are:

- Terminal: `xterm` 
- Shell: `zsh`
- Editor: `neovim`
- DE: `i3`
- Bar: `i3status` 

### Notes about Nvim

I used [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) as a
starting point. Since it uses a lot of plugin I want to get familiar with all
of them but one at a time, so I disabled some them. Currently the plugin used
are:

- Colorscheme: [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- Comment: [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)
- Adding git signs: [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- Search files/string/stuff: [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- Format code on save: [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)

The one disabled are:

- [tpope/vim-sleuth](https://github.com/tpope/vim-sleuth)
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

The list will be updated as I integrate disabled plugin into my developer flow.

#### Nvim keybinds

- `[d` Go to previous Diagnostic message
- `]d` Go to next Diagnostic message
- `<leader>e` Show diagnostic Error messages
- `<leader>q` Open diagnostic Quickfix list
- `<C-h>` Move focus to the left window
- `<C-l>` Move focus to the right window
- `<C-j>` Move focus to the lower window
- `<C-k>` Move focus to the upper window
- `<leader>sh` Search Help
- `<leader>sk` Search Keymaps
- `<leader>sf` Search Files
- `<leader>ss` Search Select Telescope
- `<leader>sw` Search current Word
- `<leader>sg` Search by Grep
- `<leader>sd` Search Diagnostics
- `<leader>sr` Search Resume
- `<leader>s.` Search Recent Files
- `<leader><leader>` Find existing buffers
- `<leader>/` Fuzzly search in current buffer
- `<leader>s/` Search in open files
