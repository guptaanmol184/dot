let mapleader =" "

call plug#begin('~/.vim/plugged')
Plug 'mboughaba/i3config.vim'
"Plug 'vimwiki/vimwiki'
Plug 'farmergreg/vim-lastplace'
Plug 'vim-scripts/xoria256.vim'
call plug#end()

" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmenu
	set wildmode=list:longest,full
" Disable cursor styling because it messes up the cursor
	set guicursor=
" Enable mouse
	set mouse=a
" Search options
	set hlsearch
	set incsearch
	set smartcase
" Tab settings
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
    set expandtab
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
	vnoremap <C-c> "+y
	map <C-p> "+P

" AUTOCOMMANDS
" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e
" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost ~/.bmfiles,~/.bmdirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost ~/.Xresources,~/.Xdefaults !xrdb %

" GRAPHICAL OPTIONS
	set background=dark
    colorscheme xoria256

