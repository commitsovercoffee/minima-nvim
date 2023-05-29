-- { Plugins } -----------------------------------------------------------

-- Dependencies :
-- nerd-fonts
-- livegrep, fd
-- tree-sitter

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
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
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
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "astro", "bash", "c", "css", "fish", "gdscript", "go", "html", "javascript", "json",
                    "lua", "python", "regex", "sql", "svelte", "toml", "yaml" },
                sync_install = true,
                auto_install = true, -- requires `tree-sitter` cli
                ignore_install = { "" },
                highlight = {
                    enable = true,
                    disable = {},
                    -- disables slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end
                },
            })
        end
    },

    -- lsp support with auto-completion, auto-pairs and indentation guides.
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for Neovim
            {
                'williamboman/mason.nvim',
                config = function()
                    require('mason').setup()
                end
            },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim',     opts = {} },
            'folke/neodev.nvim',

            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",

            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            { "windwp/nvim-autopairs", opts = {} },
            {
                "lukas-reineke/indent-blankline.nvim",
                opts = {
                    char = "|",
                    show_trailing_blankline_indent = false,
                },
            }
        },
    }

    -- git integration

    -- Development :

    -- neovim
    -- web
    -- go

}, {})

-- { Keymaps } -----------------------------------------------------------

-- Sets leader key.
vim.g.mapleader = "\\"

-- Edit filesystem as a buffer
vim.keymap.set('n', '<leader>ee', require('oil').open, {})

-- Search for sessions
vim.keymap.set("n", "<leader>ss", require("auto-session.session-lens").search_session, { noremap = true, })

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

-- { Plugin Config } -----------------------------------------------------

-- [ LSP ]

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    vim.api.nvim_set_keymap("n", "<Leader>zz", ":Format<CR>", { noremap = true, silent = true })
end

local servers = {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

-- [ Auto Completion  ]

local cmp = require('cmp')
local luasnip = require('luasnip')

-- Load snippets from VSCode
require('luasnip.loaders.from_vscode').lazy_load()

-- Configure luasnip
luasnip.config.setup {}

-- Setup nvim-cmp
cmp.setup {
    -- Configure snippet expansion behavior
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- Configure key mappings
    mapping = cmp.mapping.preset.insert {
        -- Navigation mappings
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Completion and confirmation mappings
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },

        -- Tab-based mappings for completion and snippet expansion
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },

    -- Configure completion sources
    sources = {
        { name = 'nvim_lsp' }, -- Use nvim-lsp as a completion source
        { name = 'luasnip' },  -- Use luasnip as a completion source
        { name = "path" },     -- filesystem paths cmp
        { name = "calc" },     -- math calculations cmp
    },
}
