" Define the plugins you want to use
call plug#begin('~/.config/nvim/plugged')

" Core Functionality
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'exafunction/codeium.vim'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'karb94/neoscroll.nvim'
Plug 'preservim/nerdtree'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'

" Theming
Plug 'datwaft/bubbly.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'Mofiqul/dracula.nvim'
Plug 'luochen1990/rainbow'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Specific Functionality
Plug 'dalance/vseq.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'phaazon/hop.nvim'
Plug 'folke/trouble.nvim'

" End the list of plugins
call plug#end()


" Define the Bubbly status line palette
let g:bubbly_palette = {
      \ 'background': '#282a36',
      \ 'foreground': '#f8f8f2',
      \ 'black': '#44475a',
      \ 'red': '#ff5555',
      \ 'green': '#50fa7b',
      \ 'yellow': '#f1fa8c',
      \ 'blue': '#bd93f9',
      \ 'purple': '#ff79c6',
      \ 'cyan': '#8be9fd',
      \ 'white': '#f8f8f2',
      \ 'lightgrey': '#6272a4',
      \ 'darkgrey': '#44475a',
      \ }

autocmd ColorScheme * highlight NormalFloat guibg=none
autocmd ColorScheme * highlight FloatBorder guibg=none

" Rainbow Brackets
let g:rainbow_active = 1
let g:rainbow_conf = {
      \ 'guifgs': ['#8BE9FD', '#FF79C6', '#BD93F9', '#f1fa8c', '#50FA7B'],
      \ 'guifgb': ['#44475A', '#44475A', '#44475A', '#44475A', '#44475A'],
      \ }

" Set the Dracula theme
colorscheme dracula
            
" Enable line numbers
set number

" Enable syntax highlighting
syntax enable

" Ignore casing when searching
set ignorecase

" Enable search highlighting
set hlsearch

" Enable line wrapping
set wrap

" Enable auto-indentation
set autoindent

" Enable mouse support
set mouse=a

" Use true color
if (has("termguicolors"))
    set termguicolors
endif

" Telescope features
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap fm <cmd>Telescope keymaps<cr>

" Save undo history
set undofile

" Set timeout for key mapping
set timeoutlen=250

" Enable clipboard integration
set clipboard=unnamedplus

" Tab settings (customize as you like)
set tabstop=4
set shiftwidth=4
set expandtab

" Highlight search results as you type
set incsearch

" Set leader
let mapleader = ";"

" Map Ctrl + / to comment out selected code
nmap <C-/> :Commentary<CR>
xmap <C-/> :Commentary<CR>

" Move between splits using Ctrl + J/K/L/H
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Save and quit commands
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>qa :qa<CR>

" Toggle line numbers
nnoremap ln :set relativenumber!<CR>

" Chadtree settings
nnoremap tt :NERDTreeToggle<CR>

" Hop functions
lua require'hop'.setup()
nnoremap s :HopWord<CR>
nnoremap S :HopChar1<CR>
hi HopNextKey guifg=#8be9fd
hi HopNextKey1 guifg=#ff79c6
hi HopNextKey2 guifg=#bd93f9
hi HopChar1 guifg=#ff79c6
hi HopChar2 guifg=#bd93f9
hi HopUnmatched guifg=#6272a4

" Setups
lua local colors = require('dracula').colors()
lua require'colorizer'.setup()
lua require("mason").setup()
lua require("mason-lspconfig").setup()
lua require("ibl").setup()
lua require("telescope").load_extension("ui-select")
source ~/.config/nvim/sourceme.lua











