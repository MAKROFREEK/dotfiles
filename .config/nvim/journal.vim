" Define the plugins you want to use
call plug#begin('~/.config/nvim/plugged-journal')
                             
" Core Functionality
Plug 'nvim-tree/nvim-web-devicons'
Plug 'karb94/neoscroll.nvim'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'williamboman/mason.nvim'



" Journal Plugins
Plug 'preservim/vim-lexical'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim' 
Plug 'junegunn/limelight.vim'

" Theming
" Plug 'datwaft/bubbly.nvim'
Plug 'Mofiqul/dracula.nvim'

" Specifics
Plug 'phaazon/hop.nvim'

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

" Rainbow Brackets
let g:rainbow_active = 1
let g:rainbow_conf = {
      \ 'guifgs': ['#8BE9FD', '#FF79C6', '#BD93F9', '#f1fa8c', '#50FA7B'],
      \ 'guifgb': ['#44475A', '#44475A', '#44475A', '#44475A', '#44475A'],
      \ }

" Set the Dracula theme
colorscheme dracula
   
" Journal Settings

syntax on
set nocompatible
filetype plugin on       " may already be in your .vimrc

augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END
let g:lexical#spell = 1
let g:lexical#spelllang = ['en_us','en_ca',]

let g:goyo_width = 80
let g:goyo_height = 90
let g:goyo_linenr = 0

set nocompatible
filetype plugin on

set cursorline

function! JournalHeader()
    let emojis = ["😀", "😍", "🚀", "🌟", "💡", "📝", "🔥", "🎉", "🌈", "👍", "🤖", "💪", "🙌", "🔑", "✨", "📚", "🤩", "🧐", "🎶", "🎯", "🌌", "🍀", "🌻", "👏", "💎"]
    let random_emoji = emojis[rand() % len(emojis)]
    let header = system('shuf -n 1 ~/.config/nvim/vimwiki/journal-header.txt')
    return "### " . random_emoji . " " . header
endfunction

function! InsertDateAndTime()
    let date = strftime('## 📅 %a %m/%d')
    let time = strftime('## ⏰ %H:%M')
    return [date, time]
endfunction

function! LoadQuotes()
    let quote = system('shuf -n 1 ~/.config/nvim/vimwiki/quotes.txt')
    return "## ✏️ Today's Quote: " . quote
endfunction

function! InsertTwoEmptyLines()
    return "\n\n"
endfunction

nnoremap <C-n> :r ~/.config/nvim/vimwiki/journal-template.md<CR>"=JournalHeader()<C-M>p<CR>2"=InsertTwoEmptyLines()<C-M>p<CR>"=InsertDateAndTime()[0]<C-M>p<CR>"=InsertDateAndTime()[1]<C-M>p<CR>"=LoadQuotes()<C-M>p<CR>

" Vimwiki Configuration
let g:vimwiki_list = [{'path': '~/.config/nvim/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md',
                      \ 'template_default': 'journal-template.md',
                      \ 'template_path': '~/.config/nvim/vimwiki/',}]

:au VimEnter * VimwikiDiaryIndex
:au VimEnter * if exists(':Goyo') | Goyo | endif
:au VimEnter * if exists(':Limelight') | Limelight | endif

" Set automatic relative line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Enable syntax highlighting
syntax enable

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

" Map Ctrl-Space to trigger code completion with Coc.nvim
inoremap <C-Space> :h (coc-completion)

" Map Ctrl + Tab to autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Map Ctrl + / to comment out selected code
nmap <C-/> :Commentary<CR>

" Move between splits using Ctrl + J/K/L/H
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Save and quit commands
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>

" Save and quit all buffers
nnoremap <leader>wa :wa<CR>
nnoremap <leader>qa :qa<CR>

" Reload Neovim configuration
nnoremap <leader>rv :source ~/.config/nvim/init.vim<CR>

" Toggle line numbers
nnoremap <leader>ln :set relativenumber!<CR>

" Map :FuzzySearch to <leader>f (for fuzzy finding)
nnoremap ff <cmd>Telescope find_files<CR>
nnoremap fg <cmd>Telescope live_grep<CR>

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

" Setup
lua local colors = require('dracula').colors()
lua require'colorizer'.setup()
lua require('glow').setup()
lua require('mason').setup()
















