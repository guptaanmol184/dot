" KEY MAPPINGS
    let mapleader =" "
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>q :q<CR>
    nnoremap <Leader>e :e $MYVIMRC<CR>
    nnoremap <Leader>s :so $MYVIMRC<CR>
    nnoremap ;; :w<CR>
    map s <Plug>(easymotion-s)
    " Go to the first non-blank character of a line
    noremap 0 ^
    " Just in case you need to go to the very beginning of a line
    noremap ^ 0
    " nmap <Leader>w :w<cr>
    " nmap <Leader>s :source $MYVIMRC
    " nmap <Leader>q :q
    " nmap <Leader>c :e $MYVIMRC
    :nnoremap <F5> "=strftime("[%c]")<CR>P
    :inoremap <F5> <C-R>=strftime("[%c]")<CR>

" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number
" Enable wildmenu
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
" Add shebang line to new python files and make them executable
	"autocmd BufNewFile *.py silent !chmod +x <afile>
    au BufNewFile *.py call append(0, '#/usr/bin/env python')
" Set scripts to be executable from the shell
  "au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod +x <afile> | endif | endif

source ~/.config/nvim/plugs.vim    "plugins

" GRAPHICAL OPTIONS
	set background=dark
