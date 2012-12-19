" filetypes
filetype plugin on
filetype indent on

" tab width = 8
set tabstop=8
set shiftwidth=8
set softtabstop=8

" no line wrap
set nowrap

" indenting
set cindent
set smartindent
set autoindent

set encoding=utf-8
set wildmenu
set hidden
set number
set hlsearch
set background=dark

" ukazuj prvni match
set incsearch

" mouse in every mode
set mouse=a

" tabs, not spaces
set noexpandtab

" fold by syntax, open all by default
set foldmethod=syntax
set foldlevelstart=20

" all lowercase -> case insensitive search
" anything uppercase -> case sensitive
set ignorecase
set smartcase

" chci aspon 5 radku mezi koncem stranky a kurzorem
set scrolloff=5
syntax on

filetype plugin on
" set ofu=syntaxcomplete#Complete

noremap <C-C> :botright cope<CR>
noremap <C-N> :cn<CR>
noremap <C-P> :cp<CR>
noremap <S-M> :make<CR>

noremap <C-l> :noh<CR>

" noremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .

noremap <S-w>t :tabnew<CR>
noremap <S-w>c :tabclose<CR>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Nette templaty jsou vlastne PHP.
au BufNewFile,BufRead *.phpt set filetype=php

" au BufNewFile,BufRead,BufEnter *.cpp,*.h set omnifunc=omni#cpp#complete#Main

" no mistyped :w or :q...
:command W w
:command Q q

" for learning vim direction keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" navigace mezi okny: krome Ctrl-W ... taky Ctrl-h,j,k,l,w
" zR: open all folds

set showcmd
set laststatus=2

call pathogen#infect()
