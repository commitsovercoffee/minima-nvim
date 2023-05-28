-- { Plugins } -----------------------------------------------------------

-- Dependencies :
-- nerd-fonts
-- livegrep, fd

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
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
            })
            vim.cmd("colorscheme gruvbox")
        end
    },

    -- file explorer
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- terminal window
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 25,
                open_mapping = [[<c-\>]],
                direction = 'horizontal',
            })
        end
    },

    -- status line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                icons_enabled = false,
                theme = "gruvbox_dark",
                component_separators = "|",
                section_separators = "",
            },
        },
    },

    -- fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                        },
                    }
                },
            }
        end
    },

    -- session manager
    {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup({
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
            session_lens = {
                -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
                },
            })
        end
    },

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

-- Edit filesystem as a buffer
vim.keymap.set('n', '<leader>ee', require('oil').open, {})

-- Search for sessions
vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session, {noremap = true,})

-- Open telescope builtins
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

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
