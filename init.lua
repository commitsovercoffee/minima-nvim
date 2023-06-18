--[[ OPTIONS ------------------------------------------------------------------

Vim has a number of internal variables and switches which can be set to
achieve special effects. Using 'vim.o' we can get or set vim options.

>> Lets do that to get some basic functionalities :

]]

local set = vim.o; 

set.autochdir=true; -- change directory to the file in the current window.
set.cdhome=true; -- :cd without an argument changes the cwd to the $HOME dir.

set.fileencoding="utf-8"; -- file encoding for multibyte text.
set.autoread=false; -- read file when changed outside of Vim.

set.wrap=false; -- long lines wrap and continue on the next line.
set.autoindent=true; -- take indent for new line from previous line.
set.scrolloff=8; -- minimum nr. of lines above and below cursor.

set.incsearch=true; -- highlight match while typing search pattern.
set.smartcase=true; -- no ignore case when pattern has uppercase.

set.number=true; -- print the line number in front of each line.
set.relativenumber=true; -- show relative line number in front of each line.

set.signcolumn="yes"; -- always display the sign column.
set.colorcolumn="80"; -- highlight 80th column to indiate optimal code width.
set.cursorline=true; -- highlight the screen line of the cursor.

-- use clipboard register "+" for all yank, delete, change and put operations.
set.clipboard="unnamedplus" 
set.selection="exclusive" -- what type of selection to use.

set.spell=false; -- enable spell checking.
set.spelllang='en_us'; -- language(s) to do spell checking for.

set.swapfile=false; -- whether to use a swapfile for a buffer.
set.backup=false; -- keep backup file after overwriting a file.

set.undofile=true; -- save undo information in a file.
set.undodir = vim.fn.expand("~/.config/nvim/undodir")

set.background="dark"; -- use "dark" or "light" for highlight

vim.g.mapleader = " " -- setting space as leader key.

--[[ PLUGIN MANAGER

After setting the options, you will want more. As a human you can never be
satisfied. To add "more" to neovim, we can install plugins. To install and
maintain plugins, we need a plugin manager. 

>> Lets install that : (yes. you are yak shaving.)

]]

-- install lazy plugin manager ...
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
vim.opt.rtp:prepend(lazypath);

-- setup ...
require("lazy").setup({

--[[ Plugins ------------------------------------------------------------------

While setting up the plugin manager, you can specify the plugins you want to
load, along with their configurations.

]]

-- 1. Colorscheme ~ Make it beautiful !
{
	"catppuccin/nvim",
 	priority = 1000,
	config = function () 
		vim.cmd "colorscheme catppuccin-mocha"
	end
},

-- 2. A file-explorer. duh ! ( this is not a file tree. )
{
	'stevearc/oil.nvim', -- use can edit this as a normal neovim buffer.
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function () 
		require("oil").setup({
			keymaps = {
				["<BS>"] = "actions.parent",
			},
		})
	end
},

-- 3. A terminal. sudo away !
{
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function() 
		require("toggleterm").setup({
			size=20,
			open_mapping = [[<c-space>]], -- use [Ctrl][Space] to toggle terminal.
			direction = 'horizontal',
		})
	end
},

-- 4. A statusline. So you can ignore the useful info.
{
	'nvim-lualine/lualine.nvim',
	-- Optional dependencies
	dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icons_enabled = true,
                theme = "catppuccin-mocha",
                component_separators = "|",
                section_separators = "",
            },
        },
	config = function () 
		require("lualine").setup({})
	end
},

-- 5. A fuzzy finder. Cause who needs a file manager ?
{
	'nvim-telescope/telescope.nvim', tag = '0.1.1',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function () 
		require("telescope").setup({
			-- [leader][ff] will open fuzzy finder in "find files" mode. And so on ...
			vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {}),
			vim.keymap.set('n', '<leader>gg', require('telescope.builtin').live_grep, {}),
			vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, {}),
			vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, {}),
			vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, {}),
		})
	end
},

-- 6. A session manager. Blink back to work !
{
	'rmagatti/auto-session', -- save a session using ":SessionSave".
	config = function () 
		require("auto-session").setup({
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
			vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session, {}),
		})
	end
},
    
}, opts);
