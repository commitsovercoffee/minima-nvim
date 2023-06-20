--[[ Minima Nvim --------------------------------------------------------------

Minima Nvim is a minimal neovim config that aims to be fast, lightweight,
and easy to use. It is designed for beginners who want to get started with
neovim quickly and easily.

If you're new to Neovim, you can check out the repository's README to get a
quick overview of concepts that are common to Neovim, such as Vim motions,
configurations, and plugins.

--]]

-- OPTIONS --------------------------------------------------------------------

-- vim.o options are variables that control the behavior of neovim. They can
-- be set to change the appearance of Neovim or the way it behaves.

vim.o.autochdir = true       -- change directory to the file in the current window.
vim.o.cdhome = true          -- :cd without an argument changes the cwd to the $HOME dir.

vim.o.fileencoding = "utf-8" -- file encoding for multibyte text.
vim.o.autoread = false       -- read file when changed outside of Vim.

vim.o.wrap = false           -- long lines wrap and continue on the next line.
vim.o.autoindent = true      -- take indent for new line from previous line.
vim.o.scrolloff = 8          -- minimum nr. of lines above and below cursor.

vim.o.incsearch = true       -- highlight match while typing search pattern.
vim.o.smartcase = true       -- no ignore case when pattern has uppercase.

vim.o.number = true          -- print the line number in front of each line.
vim.o.relativenumber = true  -- show relative line number in front of each line.

vim.o.signcolumn = "yes"     -- always display the sign column.
vim.o.colorcolumn = "80"     -- highlight 80th column to indiate optimal code width.
vim.o.cursorline = true      -- highlight the screen line of the cursor.

-- use clipboard register "+" for all yank, delete, change and put operations.
vim.o.clipboard = "unnamedplus"
vim.o.selection = "exclusive" -- what type of selection to use.

vim.o.spell = false           -- enable spell checking.
vim.o.spelllang = "en_us"     -- language(s) to do spell checking for.

vim.o.swapfile = false        -- whether to use a swapfile for a buffer.
vim.o.backup = false          -- keep backup file after overwriting a file.

vim.o.undofile = true         -- save undo information in a file.
vim.o.undodir = vim.fn.expand("~/.config/nvim/undodir")

vim.o.background = "dark" -- use "dark" or "light" for highlight
vim.g.mapleader = " "     -- setting space as leader key.

-- PLUGIN MANAGER -------------------------------------------------------------

-- vim.o will only lets you set "internal" variables. To add more features, you
-- can install plugins. For this, we will need a plugin manager, which
-- is a tool that helps you install, update, and manage plugins for Neovim.

-- install "lazy" plugin manager ...
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- setup ...
require("lazy").setup({

	-- PLUGINS  -----------------------------------------------------------
	-- Here you can add plugins to extend functionality of neovim.

	-- Colorscheme ~ make it beautiful !
	{
		"catppuccin/nvim",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme catppuccin-mocha")
		end,
	},

	-- A File-explorer. duh ! ( this is not a file tree. )
	-- You can edit this as a normal neovim buffer.
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				keymaps = {
					["<BS>"] = "actions.parent",
				},
				vim.keymap.set("n", "<leader>ee", require("oil").open, {}),
			})
		end,
	},

	-- A terminal. sudo away !
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-space>]], -- use [Ctrl][Space] to toggle terminal.
				direction = "horizontal",
			})
		end,
	},

	-- A statusline. So you can ignore the useful info.
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin-mocha",
				component_separators = "|",
				section_separators = "",
			},
		},
		config = function()
			require("lualine").setup({})
		end,
	},

	-- A fuzzy finder. Trust me, you want it.
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				-- [leader][ff] will open fuzzy finder in "find files" mode. And so on ...
				vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {}),
				vim.keymap.set("n", "<leader>gg", require("telescope.builtin").live_grep, {}),
				vim.keymap.set("n", "<leader>gc", require("telescope.builtin").git_commits, {}),
				vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches, {}),
				vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, {}),
			})
		end,
	},

	-- A session manager. Blink back to work !
	{
		"rmagatti/auto-session", -- save a session using ":SessionSave".
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session, {}),
			})
		end,
	},

	-- Syntax highlighting.
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
					-- Disable slow treesitter highlight for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},

	--[[

Up to this point, we have completed some basic one-time setup, including adding
a file explorer, terminal, statusline, fuzzy finder, session manager and
automatic syntax highlighting.

In addition to these basic functionalities, you may need a :
- lsp : language server for code completion, warnings, errors etc.
- formatter : to format your code to a consistent style.
- linter : to check your code for errors and potential problems.
- dap : debug adapter protocol, to debug your code in neovim.

--]]

	-- We can install either of these with mason using the ":Mason" command.
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup({})
		end,
	},

	-- For the packages you install from mason to work, you need to add
	-- them in the config. Follow the step by step process below to do so.

	-- Guide : Setup installed LSP.
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Step 1 : Visit "github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md"
			-- Step 2 : Search the lsp you installed.
			-- Step 3 : Paste "snippet to enable lsp" command below.

			require("lspconfig").pyright.setup({}) -- python
			require("lspconfig").lua_ls.setup({}) -- lua
			require("lspconfig").svelte.setup({}) -- svelte

			-- Step 4 : Open file in neovim for which you have installed lsp.
			-- Step 5 : Run ":LspInfo", to verify that lsp is attached.

			-- Global mappings.
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

			-- Map keys if language server attaches to the current buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),

				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions.
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)

					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)

					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				end,
			})
		end,
	},

	-- Guide : Setup installed formatter or linter.
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup({
				sources = {

					-- Step 1 : Visit "https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#formatting"
					-- Step 2 : Search the formatter or linter you installed.
					-- Step 3 : Paste "usage" command below.

					require("null-ls").builtins.formatting.stylua,
					require("null-ls").builtins.formatting.prettierd.with({
						filetypes = { "html", "json", "yaml", "markdown", "svelte" },
					}),

					-- Step 4 : Open file for which you have installed formatter.
					-- Step 5 : Run ":LspInfo", you should see the client "null-ls".
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},

	-- Only one functionality remains to be added now i.e auto-completion.
	-- To make that work, we install below plugins.

	{
		"hrsh7th/nvim-cmp", -- completion plugin
		"L3MON4D3/LuaSnip", -- snippet Engine
		config = function()
			require("luasnip").setup({})
		end,

		-- source for ...
		"hrsh7th/cmp-nvim-lsp", -- builtin LSP client.
		"hrsh7th/cmp-buffer", -- buffer words.
		"hrsh7th/cmp-path", -- path.
		"hrsh7th/cmp-calc", -- math calculation.
		"saadparwaiz1/cmp_luasnip", -- luasnip.
		"hrsh7th/cmp-cmdline", -- vim's cmdline.
	},
}, {})

-- Auto Completion Config  ----------------------------------------------------

-- add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- load the snippets contained in the plugin on startup.
require("luasnip.loaders.from_vscode").lazy_load()

-- auto-completion setup ...
local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
		["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
		-- C-b (back) C-f (forward) for snippet placeholder navigation.
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {

		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "calc" },
		{ name = "luasnip" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})
