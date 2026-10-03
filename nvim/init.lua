-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options
-- ============================================================
do
	vim.loader.enable() -- Enable faster startup by caching compiled Lua modules

	-- Set <space> as the leader key
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	-- Set to true if you have a Nerd Font installed and selected in the terminal
	vim.g.have_nerd_font = true

	-- Make line relative numbers default
	vim.o.number = true
	vim.o.relativenumber = true

	-- Enable mouse mode, can be useful for resizing splits for example!
	vim.o.mouse = "a"

	-- Don't show the mode, since it's already in the status line
	vim.o.showmode = false

	-- Sync clipboard between OS and Neovim.
	vim.schedule(function()
		vim.o.clipboard = "unnamedplus"
	end)

	-- Enable break indent
	vim.o.breakindent = true

	-- Enable undo/redo changes even after closing and reopening a file
	vim.o.undofile = true

	-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
	vim.o.ignorecase = true
	vim.o.smartcase = true

	-- Keep signcolumn on by default
	vim.o.signcolumn = "yes"

	-- Decrease update time
	vim.o.updatetime = 250

	-- Decrease mapped sequence wait time
	vim.o.timeoutlen = 300

	-- Configure how new splits should be opened
	vim.o.splitright = true
	vim.o.splitbelow = true

	-- Sets how neovim will display certain whitespace characters in the editor.
	--  See `:help 'list'`
	--  and `:help 'listchars'`
	--
	--  Notice listchars is set using `vim.opt` instead of `vim.o`.
	--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
	--   See `:help lua-options`
	--   and `:help lua-guide-options`
	vim.o.list = true
	vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

	-- Preview substitutions live, as you type!
	vim.o.inccommand = "split"

	-- Show which line your cursor is on
	vim.o.cursorline = true

	-- Minimal number of screen lines to keep above and below the cursor.
	vim.o.scrolloff = 5

	-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
	-- instead raise a dialog asking if you wish to save the current file(s)
	-- See `:help 'confirm'`
	vim.o.confirm = true
end

-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================
do
	-- Clear highlights on search when pressing <Esc> in normal mode
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

	-- Diagnostic Config & Keymaps
	vim.diagnostic.config({
		update_in_insert = false,
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = { min = vim.diagnostic.severity.WARN } },

		-- Can switch between these as you prefer
		virtual_text = true, -- Text shows up at the end of the line
		virtual_lines = false, -- Text shows up underneath the line, with virtual lines

		-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
		jump = {
			on_jump = function(_, bufnr)
				vim.diagnostic.open_float({
					bufnr = bufnr,
					scope = "cursor",
					focus = false,
				})
			end,
		},
	})

	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

	-- Keybinds to make split navigation easier.
	vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
	vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
	vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

	-- Highlight when yanking (copying) text
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
		callback = function()
			vim.hl.on_yank()
		end,
	})
end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
	local function run_build(name, cmd, cwd)
		local result = vim.system(cmd, { cwd = cwd }):wait()
		if result.code ~= 0 then
			local stderr = result.stderr or ""
			local stdout = result.stdout or ""
			local output = stderr ~= "" and stderr or stdout
			if output == "" then
				output = "No output from build command."
			end
			vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
		end
	end

	-- This autocommand runs after a plugin is installed or updated and
	--  runs the appropriate build command for that plugin if necessary.
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name = ev.data.spec.name
			local kind = ev.data.kind
			if kind ~= "install" and kind ~= "update" then
				return
			end

			if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
				run_build(name, { "make" }, ev.data.path)
				return
			end

			if name == "LuaSnip" then
				if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
					run_build(name, { "make", "install_jsregexp" }, ev.data.path)
				end
				return
			end

			if name == "nvim-treesitter" then
				if not ev.data.active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
				return
			end
		end,
	})
end

--- Because most plugins are hosted on GitHub, you can use the helper
--- function to have less repetition in the following sections.
local function gh(repo)
	return "https://github.com/" .. repo
end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
	-- Use correct indentation automatically
	vim.pack.add({ gh("NMAC427/guess-indent.nvim") })
	require("guess-indent").setup({})

	-- Show git changes to files
	vim.pack.add({ gh("lewis6991/gitsigns.nvim") })
	local gitsigns = require("gitsigns")
	gitsigns.setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},

		-- gitsigns.nvim's recommended keymaps:
		on_attach = function(bufnr)
			-- Navigation
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gitsigns.nav_hunk("next")
				end
			end, { desc = "Jump to next git [c]hange", buf = bufnr })

			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gitsigns.nav_hunk("prev")
				end
			end, { desc = "Jump to previous git [c]hange", buf = bufnr })

			-- Visual mode actions
			vim.keymap.set("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [s]tage hunk", buf = bufnr })
			vim.keymap.set("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "git [r]eset hunk", buf = bufnr })
			-- Normal mode actions
			vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk", buf = bufnr })
			vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk", buf = bufnr })
			vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer", buf = bufnr })
			vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer", buf = bufnr })
			vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk", buf = bufnr })
			vim.keymap.set(
				"n",
				"<leader>hi",
				gitsigns.preview_hunk_inline,
				{ desc = "git preview hunk [i]nline", buf = bufnr }
			)
			vim.keymap.set("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { desc = "git [b]lame line", buf = bufnr })
			vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index", buf = bufnr })
			vim.keymap.set("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { desc = "git [D]iff against last commit", buf = bufnr })
			vim.keymap.set("n", "<leader>hQ", function()
				gitsigns.setqflist("all")
			end, { desc = "git hunk [Q]uickfix list (all files in repo)", buf = bufnr })
			vim.keymap.set(
				"n",
				"<leader>hq",
				gitsigns.setqflist,
				{ desc = "git hunk [q]uickfix list (all changes in this file)", buf = bufnr }
			)
			-- Toggles
			vim.keymap.set(
				"n",
				"<leader>tb",
				gitsigns.toggle_current_line_blame,
				{ desc = "[T]oggle git show [b]lame line", buf = bufnr }
			)
			vim.keymap.set(
				"n",
				"<leader>tw",
				gitsigns.toggle_word_diff,
				{ desc = "[T]oggle git intra-line [w]ord diff", buf = bufnr }
			)
			-- Text object
			vim.keymap.set(
				{ "o", "x" },
				"ih",
				gitsigns.select_hunk,
				{ desc = "text object [i]nside [h]unk", buf = bufnr }
			)
		end,
	})

	-- Useful plugin to show you pending keybinds.
	vim.pack.add({ gh("folke/which-key.nvim") })
	require("which-key").setup({
		-- Delay between pressing a key and opening which-key (milliseconds)
		delay = 0,
		icons = { mappings = vim.g.have_nerd_font },
		-- Document existing key chains
		spec = {
			{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
			{ "gr", group = "LSP Actions", mode = { "n" } },
		},
	})

	-- Colorscheme
	vim.pack.add({ gh("folke/tokyonight.nvim") })
	---@diagnostic disable-next-line: missing-fields
	require("tokyonight").setup({
		styles = {
			comments = { italic = false }, -- Disable italics in comments
		},
	})
	vim.cmd.colorscheme("tokyonight-night")

	-- Highlight todo, notes, etc in comments
	vim.pack.add({ gh("folke/todo-comments.nvim") })
	require("todo-comments").setup({ signs = false })

	-- [[ mini.nvim ]] A collection of various small independent plugins/modules
	vim.pack.add({ gh("nvim-mini/mini.nvim") })
	if vim.g.have_nerd_font then
		require("mini.icons").setup()
		MiniIcons.mock_nvim_web_devicons()
	end

	-- Better Around/Inside textobjects
	require("mini.ai").setup({
		mappings = {
			around_next = "aa",
			inside_next = "ii",
		},
		n_lines = 500,
	})

	-- Add/delete/replace surroundings (brackets, quotes, etc.)
	require("mini.surround").setup()

	-- Simple and easy statusline.
	local statusline = require("mini.statusline")
	statusline.setup({ use_icons = vim.g.have_nerd_font })
	---@diagnostic disable-next-line: duplicate-set-field
	statusline.section_location = function()
		return "%2l:%-2v"
	end
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
	-- [[ Fuzzy Finder (files, lsp, etc) ]]
	local telescope_plugins = {
		gh("nvim-lua/plenary.nvim"),
		gh("nvim-telescope/telescope.nvim"),
		gh("nvim-telescope/telescope-ui-select.nvim"),
	}
	if vim.fn.executable("make") == 1 then
		table.insert(telescope_plugins, gh("nvim-telescope/telescope-fzf-native.nvim"))
	end

	vim.pack.add(telescope_plugins)

	require("telescope").setup({
		extensions = {
			["ui-select"] = { require("telescope.themes").get_dropdown() },
		},
	})

	-- Enable Telescope extensions if they are installed
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	-- See `:help telescope.builtin`
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
	vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
	vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
	vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
	vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

	-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
	-- If you later switch picker plugins, this is where to update these mappings.
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
		callback = function(event)
			local buf = event.buf
			vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })
			vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "[G]oto [I]mplementation" })
			vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })
			vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })
			vim.keymap.set(
				"n",
				"gW",
				builtin.lsp_dynamic_workspace_symbols,
				{ buffer = buf, desc = "Open Workspace Symbols" }
			)
			vim.keymap.set(
				"n",
				"grt",
				builtin.lsp_type_definitions,
				{ buffer = buf, desc = "[G]oto [T]ype Definition" }
			)
		end,
	})

	-- Override default behavior and theme when searching
	vim.keymap.set("n", "<leader>/", function()
		-- You can pass additional configuration to Telescope to change the theme, layout, etc.
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[/] Fuzzily search in current buffer" })

	-- It's also possible to pass additional configuration options.
	vim.keymap.set("n", "<leader>s/", function()
		builtin.live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, { desc = "[S]earch [/] in Open Files" })
end

-- ============================================================
-- SECTION 6: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
	-- Useful status updates for LSP.
	vim.pack.add({ gh("j-hui/fidget.nvim") })
	require("fidget").setup({})

	--  This function gets run when an LSP attaches to a particular buffer.
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			-- Function that lets us more easily define mappings specific for LSP related items.
			-- It sets the mode, buffer and description for us each time.
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			-- Rename the variable under your cursor.
			map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

			-- Execute a code action, usually your cursor needs to be on top of an error
			-- or a suggestion from your LSP for this to activate.
			map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

			--  Goto Declaration.
			map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

			-- Highlight references of the word under your cursor when your cursor rests there for a little while.
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client:supports_method("textDocument/documentHighlight", event.buf) then
				local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			-- Creates a keymap to toggle inlay hints in your code, if the language server you are using supports them
			if client and client:supports_method("textDocument/inlayHint", event.buf) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "[T]oggle Inlay [H]ints")
			end
		end,
	})

	-- Enable the following language servers
	local servers = {
		stylua = {},
		ruff = { init_options = { settings = { logLevel = "error" } } },

		clangd = {},
		pyright = {},
		bashls = {},
		rust_analyzer = {},

		-- Special Lua Config, as recommended by neovim help docs
		lua_ls = {
			on_init = function(client)
				client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
				client.config.settings.Lua = vim.tbl_deep_extend("force", current_settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
				})
			end,
			settings = {
				Lua = {
					format = { enable = false }, -- Disable formatting (formatting is done by stylua)
				},
			},
		},
	}

	vim.pack.add({
		gh("neovim/nvim-lspconfig"),
		gh("mason-org/mason.nvim"),
		gh("mason-org/mason-lspconfig.nvim"),
		gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
	})

	-- Automatically install LSPs and related tools to stdpath for Neovim
	require("mason").setup({})

	-- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
	require("mason-lspconfig").setup({
		automatic_enable = false,
	})

	-- Ensure the servers and tools above are installed
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"codelldb",
		"clang-format",
	})

	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	for name, server in pairs(servers) do
		vim.lsp.config(name, server)
		vim.lsp.enable(name)
	end
end

-- ============================================================
-- SECTION 7: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
do
	-- [[ Formatting ]]
	vim.pack.add({ gh("stevearc/conform.nvim") })
	require("conform").setup({
		notify_on_error = false,
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			c = { "clang_format" },
			h = { "clang_format" },
			cpp = { "clang_format" },
			lua = { "stylua" },
			python = { "ruff_format" },
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>f", function()
		require("conform").format({ async = true })
	end, { desc = "[F]ormat buffer" })
end

-- ============================================================
-- SECTION 8: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
do
	-- [[ Snippet Engine ]]
	vim.pack.add({ { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") } })
	require("luasnip").setup({})

	-- `friendly-snippets` contains a variety of premade snippets.
	--    See the README about individual language/framework/plugin snippets:
	--    https://github.com/rafamadriz/friendly-snippets
	--
	-- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
	-- require('luasnip.loaders.from_vscode').lazy_load()

	-- [[ Autocomplete Engine ]]
	vim.pack.add({ { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") } })
	require("blink.cmp").setup({
		keymap = { preset = "default" },
		appearance = { nerd_font_variant = "mono" },
		completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
		sources = { default = { "lsp", "path", "snippets" } },
		snippets = { preset = "luasnip" },
		fuzzy = { implementation = "lua" },
		signature = { enabled = true },
	})
end

-- ============================================================
-- SECTION 9: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
	vim.pack.add({ { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" } })

	-- Ensure basic parsers are installed
	local parsers = {
		"bash",
		"c",
		"diff",
		"html",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"query",
		"rust",
		"vim",
		"vimdoc",
	}
	require("nvim-treesitter").install(parsers)

	---@param buf integer
	---@param language string
	local function treesitter_try_attach(buf, language)
		-- Check if a parser exists and load it
		if not vim.treesitter.language.add(language) then
			return
		end

		-- Check if the buffer is valid (might not be after install completes)
		if not vim.api.nvim_buf_is_valid(buf) then
			return
		end

		-- Enable syntax highlighting and other treesitter features
		vim.treesitter.start(buf, language)

		-- Check if treesitter indentation is available for this language, and if so enable it
		-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
		local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

		-- Enable treesitter based indentation
		if has_indent_query then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end

	local available_parsers = require("nvim-treesitter").get_available()
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(args)
			local buf, filetype = args.buf, args.match

			local language = vim.treesitter.language.get_lang(filetype)
			if not language then
				return
			end

			local installed_parsers = require("nvim-treesitter").get_installed("parsers")

			if vim.tbl_contains(installed_parsers, language) then
				-- Enable the parser if it is already installed
				treesitter_try_attach(buf, language)
			elseif vim.tbl_contains(available_parsers, language) then
				-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
				require("nvim-treesitter").install(language):await(function()
					treesitter_try_attach(buf, language)
				end)
			else
				-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
				treesitter_try_attach(buf, language)
			end
		end,
	})
end

-- ============================================================
-- SECTION 10: MORE PLUGINS
-- ============================================================
do
	-- Auto parenthesis, brackets, etc.
	vim.pack.add({ gh("altermo/ultimate-autopair.nvim") })
	require("ultimate-autopair").setup({})

	-- Debug
	local dap_plugins = {
		gh("nvim-neotest/nvim-nio"),
		gh("mfussenegger/nvim-dap"),
		gh("rcarriga/nvim-dap-ui"),
	}
	vim.pack.add(dap_plugins)

	---@diagnostic disable-next-line: missing-fields
	require("dapui").setup({
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Initialize dap-ui
			dapui.setup()

			-- Define the GDB adapter
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}

			-- Define the CodeLLDB adapter (Server-based)
			dap.adapters.lldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb", -- Mason adds this binary to your PATH
					args = { "--port", "${port}" },
				},
			}

			-- Configure C file debugging with GDB
			-- local c_cpp_config_gdb = {
			-- 	{
			-- 		name = "Launch file (GDB)",
			-- 		type = "gdb",
			-- 		request = "launch",
			-- 		program = function()
			-- 			local path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			-- 			-- Force conversion to full absolute path (e.g., /home/user/proj/main)
			-- 			return vim.fn.fnamemodify(path, ":p")
			-- 		end,
			-- 		cwd = "${workspaceFolder}",
			-- 		stopAtBeginningOfMainSubprogram = false,
			-- 		-- Add this line to map current workspace to root relative paths:
			-- 		sourceFileMap = {
			-- 			["${workspaceFolder}"] = "${workspaceFolder}",
			-- 		},
			-- 	},
			-- }

			-- Configure C file debugging with LLDB
			local c_cpp_config_lldb = {
				{
					name = "Launch file (CodeLLDB)",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			dap.configurations.c = c_cpp_config_lldb
			dap.configurations.cpp = c_cpp_config_lldb

			-- Automatically open/close DAP UI when starting/ending a debugging session
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Toggle Breakpoint remains on Leader + b
			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

			-- Arrow key bindings from nvim-dap recommendations
			vim.keymap.set("n", "<S-Up>", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<S-Down>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<S-Right>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<S-Left>", dap.step_out, { desc = "Debug: Step Out" })

			-- Toggle UI
			vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

			-- Evaluate the word under the cursor (or selected text in Visual mode) in a float
			vim.keymap.set({ "n", "v" }, "<Leader>de", function()
				dapui.eval()
			end, { desc = "Debug: Evaluate in Float" })

			-- Double-tap/Focus float: Pressing this will open and jump your cursor straight into the floating window
			vim.keymap.set("n", "<Leader>dE", function()
				dapui.eval(nil, { enter = true })
			end, { desc = "Debug: Evaluate and Focus Float" })

			-- Terminate the current debugging session
			vim.keymap.set("n", "<Leader>dq", function()
				dap.terminate()
			end, { desc = "Debug: Stop/Terminate Session" })

			-- Prompt for a condition string and set a conditional breakpoint on the current line
			vim.keymap.set("n", "<Leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })
		end,
	})

	vim.pack.add({ gh("lervag/vimtex") })
	vim.g.vimtex_view_method = "zathura"
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
