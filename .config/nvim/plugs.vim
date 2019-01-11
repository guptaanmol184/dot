
call plug#begin('~/.vim/plugged')

    "Plug 'vimwiki/vimwiki'

    " filetype plugins
        Plug 'mboughaba/i3config.vim'

    " utility plugins
        Plug 'farmergreg/vim-lastplace'
        Plug 'easymotion/vim-easymotion'

    " programming plugins
        Plug 'tpope/vim-commentary'
        Plug 'w0rp/ale'

    " graphical plugins
        Plug 'vim-scripts/xoria256.vim'

call plug#end()

" ale Options
let g:ale_linters = {
\   'python': ['pyflakes'],
\	'c': ['gcc'],
\   'sh': ['shellcheck'],
\}
