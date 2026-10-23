" Settings
set notermguicolors
set background=dark
set number
set relativenumber
set laststatus=2
set showmode
set hlsearch
set incsearch
set mouse=a
set noswapfile
syntax on

" https://linuxhandbook.com/vim-copy-clipboard/
set clipboard+=unnamedplus

" --- Plugin Auto Install ---
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Plugins --- 
call plug#begin('~/.vim/plugged')

Plug 'mg979/vim-visual-multi'  " Multiple cursors, QoL | Yes ctrl + v, shift + i works but sometime need visual que
Plug 'tpope/vim-surround'      " Highlights parentheses etc, Visual
Plug 'vim-fuzzbox/fuzzbox.vim' " Fuzzy finder file, Workflow

call plug#end()

" --- Key Mappings ---
nnoremap <C-f> :FuzzyFiles<CR>

" --- Appearance Overrides ---
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE


