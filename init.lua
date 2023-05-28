-- { Plugins } -----------------------------------------------------------

-- Installs lazy package manager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local install_cmd = string.format(
        "git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable %s", lazypath)
    vim.fn.system(install_cmd)
end
vim.opt.runtimepath:prepend(lazypath)

-- Startup function.
require("lazy").setup({

    -- PDE Features :

    -- colorscheme
    -- file explorer
    -- terminal window
    -- status line

    -- fuzzy finder
    -- session manager

    -- syntax highlighting
    -- lsp support
    -- autocompletion
    -- git integration

    -- autopairs
    -- indentation guides

    -- Development :

    -- neovim
    -- web
    -- go
    --

}, {})



-- { Keymaps } -----------------------------------------------------------

-- Sets leader key.
vim.g.mapleader = "\\"

-- { Settings } ----------------------------------------------------------

-- Show line numbers.
vim.o.number = true

-- Show relative line numbers.
vim.o.relativenumber = true

-- Highlight current line.
vim.o.cursorline = true

-- Color column to indicate optimal line length.
vim.o.colorcolumn = "75"

-- Disable line wrapping.
vim.o.wrap = false

-- Additional column for indications.
vim.o.signcolumn = "yes"

-- Always show 8 lines above and below the cursor.
vim.o.scrolloff = 8

-- Indentation setting.
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Use undo instead of swap or backup.
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")

-- Set search options.
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set wild menu options.
vim.o.wildmenu = true
vim.o.wildmode = "list:longest"
vim.o.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- Use system clipboard for yank,delete etc.
vim.o.clipboard = "unnamedplus"

-- Set file encoding.
vim.o.fileencoding = 'utf-8'

-- Split new windows to the right.
vim.o.splitright = true

-- Split new windows below.
vim.o.splitbelow = true

-- Hide buffers when they are not displayed.
vim.o.hidden = true
                    
-- Enable 256-color support.
vim.o.termguicolors = true

-- Enable dark mode.
vim.o.background = "dark"
