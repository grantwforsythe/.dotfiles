"---------------------
" Basic editing config
"---------------------
syntax on
 
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

set clipboard=unnamed " allows to paste from outside sources

" set colorcolumn=gruvbox " sets the them
"high ColorColumn ctermbg=0 guibg=lightgrey 
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase

" execute pathogen#infect()

" colorscheme gruvbox
" set background=dark

" "if executable('rg')
" "    let g:rp_derive_root='true'
" "endif

" let g:ctrlp_user_command = ['.git/']
" let mapleader= " "
" let g:netrw_browse_split=2
" let g:netrw_banner=0
" let g:netrw_winsize=25

" let g:ctrlp_use_caching=0

