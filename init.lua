--[[ {{ OPTIONS }} ------------------------------------------------------------
Vim has a number of internal variables and switches which can be set to
achieve special effects. Using 'vim.o' we can get or set vim options.
]]

local set = vim.o; 

set.autochdir=true; -- change directory to the file in the current window
set.cdhome=true; -- :cd without an argument changes the cwd to the $HOME dir

set.fileencoding="utf-8";
set.autoread=false; -- read file when changed outside of Vim

set.wrap=false; -- long lines wrap and continue on the next line
set.autoindent=true; -- take indent for new line from previous line
set.scrolloff=8; -- minimum nr. of lines above and below cursor

set.incsearch=true; -- highlight match while typing search pattern
set.smartcase=true; -- no ignore case when pattern has uppercase

set.number=true; -- print the line number in front of each line
set.relativenumber=true; -- show relative line number in front of each line

set.signcolumn="yes"; -- when and how to display the sign column
set.colorcolumn="80"; -- highlights 80th column to indiate optimal code width
set.cursorline=true; -- highlight the screen line of the cursor

-- Vim will use the clipboard register "+" for all yank, delete,
-- change and put operations.
set.clipboard="unnamedplus" 

set.selection="exclusive" -- what type of selection to use

set.spell=false; -- enable spell checking
set.spelllang='en_us'; -- language(s) to do spell checking for

set.swapfile=false; -- whether to use a swapfile for a buffer
set.backup=false; -- keep backup file after overwriting a file

set.undofile=true; -- save undo information in a file
set.undodir = vim.fn.expand("~/.config/nvim/undodir")

set.termguicolors = false;
set.background="dark"; -- "dark" or "light", used for highlight

-- TODO : add autosave

--[[ {{ Plugin Manager }} -----------------------------------------------------
We can extend the functionality of neovim using plugins. To install plugins,
we need a plugin manager. In this case, lazy.nvim :

Requirements for lazy.nvim : 
- Neovim >= 0.8.0
- Git >= 2.19.0
- A nerd font ( optional but recommended )
]]

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
require("lazy").setup({

--[[ {{ Plugins }} ------------------------------------------------------------
Plugins to extend neovim functionality.
]]

-- gruvbox colorscheme
{
	"ellisonleao/gruvbox.nvim",
	priority = 1000, 
	config = function () 
			require("gruvbox").setup({
  			contrast = "hard", -- can be "hard", "soft" or empty string
			})
			vim.cmd("colorscheme gruvbox")
	end
},

-- git signs
{
	"lewis6991/gitsigns.nvim",
	config = function()
			require('gitsigns').setup {
  				signs = {
    				add          = { text = '+' },
    				change       = { text = '~' },
    				delete       = { text = '-' },
    				topdelete    = { text = '-' },
    				changedelete = { text = '-~' },
    				untracked    = { text = '|' },
  				},
			}
	end
},

}, opts);
