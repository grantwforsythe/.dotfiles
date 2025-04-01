" -----------
" Settings
" -----------

" Disable compatible mode, it's not using vi
set nocompatible

" Change the way Vim caches filetype rules at runtime
filetype off

" Relative and absolute line numbers
set relativenumber
set number

" Use spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

" Don't wrap text
set nowrap

" Disable swap and backup files, enable persistent undo
set noswapfile
set nobackup
set undofile

" Set undo directory based on the OS
if has("win32") || has("win64")
  let &undodir = $HOME . '\.vim\undo'
else
  let &undodir = $HOME . '/.vim/undo'
endif

" Search settings
set incsearch
set nohlsearch
set ignorecase
set smartcase

" Enable more colors
set termguicolors

" Show at least 8 lines at the bottom while scrolling unless at the end of a file
set scrolloff=8
set signcolumn=yes

" Set the update time for various events
set updatetime=50

" Set space as leader key
let mapleader = " "

" Disable error bells
set noerrorbells

" Allow hidden buffers
set hidden

" Always show the sign column
set signcolumn=yes

" Enable mouse support
set mouse=a

" Show spaces and set list characters for tabs
set list
set listchars=tab:▸\ 

" Use system clipboard
set clipboard=unnamed

" Set background to dark
set background=dark

" Highlight column 100
set colorcolumn=100

" Highlight ColorColumn
highlight ColorColumn ctermbg=0 guibg=lightgrey

" -----------
" Remaps
" -----------

" Move highlighted line(s) up
xnoremap K :m '<-2<CR>gv=gv

" Move highlighted line(s) down
xnoremap J :m '>+1<CR>gv=gv

" Append the previous line to the current line w/o repositioning your cursor
nnoremap J mzJ`z

" Half page down and keep cursor in the middle
nnoremap <C-d> <C-d>zz

" Half page up and keep cursor in the middle
nnoremap <C-u> <C-u>zz

" Keep cursor in the middle when searching forwards from cursor
nnoremap n nzzzv

" Keep cursor in the middle when searching backwards from cursor
nnoremap N Nzzzv

" Do not replace copied text with deleted text
xnoremap <leader>p "_dP

" Copy into system clipboard (yanking)
nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Delete to void registry
nnoremap <leader>d "_d
xnoremap <leader>d "_d

" Disabled Q
nnoremap Q <nop>

" Open netrw
nnoremap - :Explore<CR>

" Quickfix list
nnoremap <C-j> <cmd>cnext<CR>zz
nnoremap <C-k> <cmd>cprev<CR>zz

" Location list
nnoremap <leader>k <cmd>lnext<CR>zz
nnoremap <leader>j <cmd>lprev<CR>zz

" Find and replace all of the words your cursor is on
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Make current file executable
nnoremap <leader>xx <cmd>!chmod +x %<CR>

" Window navigation in terminal mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

" Window navigation in normal mode
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Enter command mode in terminal mode
tnoremap <ESC> <C-\><C-n>
