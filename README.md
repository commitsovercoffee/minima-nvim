# MinimaNvim

This repo contains my neovim config as a single `init.lua` file that sets up ...

- file explorer ( not file tree ) ~ open/edit files and folders.
- fuzzy finder ~ search for text, files, diagnostics and a lot more.
- terminal support ~ open terminal within neovim.
- session manager ~ blink back to what you were working on.
- statusline ~ to display relevant info.
- syntax highlighting ~ installed automatically for opened file.
- git support ~ run git commands from within neovim, and display git signs.
- catppuccin colorscheme ~ to make it beautiful.
- mason ~ install any lsp, formatter, linter or dap. ( how to setup )
- auto-completion support with snippets.

Along with sane defaults and keymappings.

## What is neovim ?

It is an editor just like notepad or gedit. What's special about neovim is that it is a modal text editor that is designed to be fast and efficient. And you can extend its functionality using plugins, and hence it makes up for a
great programming editor since you can add functionalities that you want, and ultimately create your [PDE](https://www.youtube.com/watch?v=QMVIJhC9Veg) ( personalized development environment ).

## Usage

- Install neovim.
- Copy init.lua file to ~/.config/nvim/
- Open neovim. ( it may show black screen for a second or two )
- All packages will be automatically installed.

## Mason package not working ?

After installing packages using ":mason" you will need to add that package in the config. To setup ...

- lsp follow [these](https://github.com/commitsovercoffee/minima-nvim/blob/main/init.lua#L234) steps.
- linter, formatter etc follow [these](https://github.com/commitsovercoffee/minima-nvim/blob/main/init.lua#L286) steps.

## Status

This project is my daily driver. I contribute to this project if and when I come across something useful or to add bugfixes.


