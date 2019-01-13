" ale Options
let g:ale_linters = {
\   'python': ['pyflakes', 'pyls'],
\	'c': ['gcc'],
\   'sh': ['shellcheck'],
\}
let g:ale_completion_enabled=1
set completeopt=menu,menuone,preview,noselect,noinsert

" plugins
call plug#begin('~/.vim/plugged')

    "Plug 'vimwiki/vimwiki'

    " filetype plugins
        Plug 'mboughaba/i3config.vim'

    " utility plugins
        Plug 'farmergreg/vim-lastplace'
        Plug 'easymotion/vim-easymotion'
        "Plug 'ervandew/supertab'
        Plug 'luochen1990/rainbow'
            let g:rainbow_active = 1
        Plug 'Yggdroot/indentLine'

    " programming plugins
        Plug 'tpope/vim-commentary'
        Plug 'w0rp/ale'

    " graphical plugins
        Plug 'vim-scripts/xoria256.vim'

call plug#end()
