# NeoVim Configuration

This directory contains my personal NeoVim configuration files.

## Installation

1.  Clone this repository to `~/.config/nvim`.
2.  Run `nvim` and wait for the plugins to be installed.

## Plugins

This configuration uses the following plugins:

-   [ultimate-autopair.nvim](https://github.com/altermo/ultimate-autopair.nvim): A plugin for auto-pairing brackets and quotes.
-   [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): A collection of configurations for the built-in LSP client.
-   [mason.nvim](https://github.com/williamboman/mason.nvim): A plugin to manage external tools, LSPs, and more.
-   [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim): An extension to `mason.nvim` to bridge it with `nvim-lspconfig`.
-   [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): A source for `nvim-cmp` that provides completions from the built-in LSP client.
-   [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): A completion plugin for NeoVim.
-   [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): A statusline plugin for NeoVim.
-   [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): A fuzzy finder for NeoVim.
-   [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim): A plugin to manage terminals in NeoVim.
-   [tokyonight.nvim](https://github.com/folke/tokyonight.nvim): A color scheme for NeoVim.
-   [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua): A file explorer for NeoVim.
-   [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): A plugin for incremental parsing and syntax highlighting.

## Keybindings

### General

| Key | Action |
| --- | --- |
| `<C-h>` | Move to the window on the left |
| `<C-j>` | Move to the window below |
| `<C-k>` | Move to the window above |
| `<C-l>` | Move to the window on the right |
| `<C-d>` | Scroll down half a page |
| `<C-u>` | Scroll up half a page |
| `<C-Up>` | Resize window height +1 |
| `<C-Down>` | Resize window height -1 |
| `<C-Left>` | Resize window width -1 |
| `<C-Right>` | Resize window width +1 |
| `<S-l>` | Next buffer |
| `<S-h>` | Previous buffer |
| `<leader>e` | Toggle NvimTree |
| `<C-p>` | Find files with Telescope |
| `<C-t>` | Toggle terminal |

### LSP

| Key | Action |
| --- | --- |
| `K` | Hover |
| `<leader>k` | Open float |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `go` | Go to type definition |
| `gr` | Go to references |
| `gs` | Signature help |
| `<F2>` | Rename |
| `<F4>` | Code action |

### Telescope

| Key | Action |
| --- | --- |
| `<leader>fg` | Git files |
| `<leader>fr` | Live grep |
| `<leader>ff` | Find files |
| `<leader>fb` | Buffers |
| `<leader>fh` | Find hidden files |

### Git

| Key | Action |
| --- | --- |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame line |
| `<leader>gd` | Diff current file |
| `<leader>gc` | List changed files (Telescope) |

### Debugging (DAP)

| Key | Action |
| --- | --- |
| `<F5>` | Start/Continue debugging |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<F12>` | Step Out |
| `<leader>b` | Toggle Breakpoint |
| `<leader>B` | Set Conditional Breakpoint |
| `<leader>dr` | Open REPL |
| `<leader>du` | Toggle Debug UI |

## Configuration

The following options are set:

-   `backup = false`
-   `clipboard = "unnamedplus"`
-   `cmdheight = 2`
-   `completeopt = { "menuone", "noselect" }`
-   `conceallevel = 0`
-   `fileencoding = "utf-8"`
-   `hlsearch = true`
-   `incsearch = true`
-   `ignorecase = true`
-   `ro = false`
-   `mouse = "a"`
-   `pumheight = 10`
-   `showmode = false`
-   `showtabline = 2`
-   `smartcase = true`
-   `smartindent = true`
-   `splitbelow = true`
-   `splitright = true`
-   `swapfile = false`
-   `termguicolors = true`
-   `timeoutlen = 1000`
-   `undofile = true`
-   `updatetime = 300`
-   `writebackup = false`
-   `expandtab = true`
-   `shiftwidth = 4`
-   `tabstop = 4`
-   `cursorline = false`
-   `number = true`
-   `relativenumber = false`
-   `numberwidth = 4`
-   `signcolumn = "yes"`
-   `wrap = false`
-   `scrolloff = 4`
-   `sidescrolloff = 4`
-   `guifont = "JetBrains Mono:h11"`
