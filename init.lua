--[[ {{ OPTIONS }} ------------------------------------------------------------
Vim has a number of internal variables and switches which can be set to
achieve special effects. Using 'vim.o' we can get or set vim options.
]]

local set = vim.o; 

set.autochdir=true; -- change directory to the file in the current window
set.cdhome=true; -- :cd without an argument changes the cwd to the $HOME directory

set.fileencoding="utf-8";
set.autoread=false; -- read file when changed outside of Vim

set.wrap=false; -- long lines wrap and continue on the next line
set.autoindent=true; -- take indent for new line from previous line
set.scrolloff=8; -- minimum nr. of lines above and below cursor

set.incsearch=true; -- highlight match while typing search pattern
set.smartcase=true; -- no ignore case when pattern has uppercase

set.number=true; -- print the line number in front of each line
set.relative=true; -- show relative line number in front of each line

set.signcolumn="yes"; -- when and how to display the sign column
set.colorcolumn="80"; -- highlights 80th column to indiate optimal code width
set.cursorline=true; -- highlight the screen line of the cursor

set.clipboard="unnamedplus" -- Vim will use the clipboard register "+" for all yank, delete, change and put operations.
set.selection="exclusive" -- what type of selection to use

set.spell=false; -- enable spell checking
set.spelllang='en_us'; -- language(s) to do spell checking for

set.swapfile=false; -- whether to use a swapfile for a buffer
set.backup=false; -- keep backup file after overwriting a file

set.undofile=true; -- save undo information in a file
set.undodir = vim.fn.expand("~/.config/nvim/undodir")

set.termguicolors = true;
set.background="dark"; -- "dark" or "light", used for highlight

--[[ TODO :
-- [-] implement autosave
]]
