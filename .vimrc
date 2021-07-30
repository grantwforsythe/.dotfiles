"---------------------
" Basic editing config
"---------------------
syntax on

set nocompatible " vim is not using vi
filetype off " change the way vim caches filetype rules at runtime
 
set noerrorbells
set guicursor= " set the type of cursor
set relativenumber " the number of lines are relative
set nu " numbers lines
set nohlsearch " after searching for a word, its no longer highlighted
set hidden " allow auto-hiding of edited buffers
set nowrap " doesn't wrap text
set autoindent " copies the indent when starting a new line 
set incsearch " incremental search (as string is being typed)
set scrolloff=8 " show 8 lines above and below the cursor 
set signcolumn=yes " adds the grey bar to the left
set noswapfile " prevents swap files from being created
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch " while you are typing, you will get results
set mouse=a " mouse

set clipboard=unnamed " allows to paste from outside sources

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase

" use tab to indent
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" =================================================

set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin() " specify a directory for plugins

Plugin 'VundleVim/Vundle.vim'   " let Vundle mange Vundle, required
Plugin 'morhetz/gruvbox'        " colorscheme

call vundle#end() 
filetype plugin indent on " re-establish the 'filetype' functionality

" =================================================
" Configuartion: gruvbox
colorscheme gruvbox
set background=dark
