" Use vim-plug for plugin management
call plug#begin('~/.config/nvim/plugged')

" LSP, completion, and linting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'

" Dracula theme
Plug 'dracula/vim'

" Fuzzy Finder
Plug 'junegunn/fzf.vim'
call plug#end()

" Set Dracula colorscheme
colorscheme dracula

" Enable line numbers and relative numbers
set number
set relativenumber

" Enable true color support
if (has("termguicolors"))
    set termguicolors
endif

" Basic editor settings
set autoindent
set expandtab
set shiftwidth=4
set tabstop=4
set wrap

" Enable clipboard support
set clipboard=unnamedplus

" Enable syntax highlighting
syntax enable

" Search settings
set ignorecase
set hlsearch
set incsearch

" Enable mouse support
set mouse=a

" Set timeout for key mapping
set timeoutlen=250

" Use true color
if (has("termguicolors"))
    set termguicolors
endif

" Leader key configuration
let mapleader = ";"

" Fuzzy finder key mappings (Telescope)
nnoremap <leader>ff <cmd>Telescope find_files<cr>   " Find files
nnoremap <leader>fg <cmd>Telescope live_grep<cr>    " Live grep (search within files)
nnoremap <leader>fb <cmd>Telescope buffers<cr>      " Switch buffers
nnoremap <leader>fh <cmd>Telescope help_tags<cr>    " Help tags
nnoremap <leader>fm <cmd>Telescope keymaps<cr>      " Show key mappings

" Map Ctrl + / to comment out the current line or selected text
nmap <C-/> <cmd>Commentary<CR>  " Comment the current line in normal mode
xmap <C-/> <cmd>Commentary<CR>  " Comment the selected text in visual mode

