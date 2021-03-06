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
set smartindent

set encoding=utf-8
set wildmenu
set hidden
set number
set hlsearch

" ukazuj prvni match
set incsearch

set ttyfast

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
set omnifunc=syntaxcomplete#Complete

" to byvalo <S-M>, ale to koliduje s 'vyber prostredni radku'
noremap <Leader>m :make<CR>

noremap <C-l> :noh<CR>

" noremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" au BufNewFile,BufRead,BufEnter *.cpp,*.h set omnifunc=omni#cpp#complete#Main

" no mistyped :w or :q...
:command W w
:command Q q

" unlearn moving by single characters
"vnoremap h <nop>
"nnoremap h <nop>
"vnoremap l <nop>
"nnoremap l <nop>

set showcmd
set laststatus=2

" Vundle plugins
" To install: vim +PluginInstall +qall, or run :PluginInstall
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Plugin 'wincent/command-t'
" Plugin 'tpope/vim-fugitive'
Plugin 'niklasl/vim-rdf'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'overcache/NeoSolarized'
Plugin 'bling/vim-airline'
Plugin 'derekwyatt/vim-scala'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pbrisbin/vim-mkdir' " mkdir needed dirs before writing buffer
Plugin 'bazelbuild/vim-ft-bzl'
Plugin 'google/vim-maktaba'  " dependency of vim-codefmt
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'  " used to configure codefmt's maktaba flags
Plugin 'leafgarland/typescript-vim'
call vundle#end()

" Ignore error if Glaive not installed.
silent! call glaive#Install()

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif
let g:airline#extensions#tabline#enabled = 1

set textwidth=80
autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd Filetype haskell setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

autocmd Filetype c setlocal cindent nosmartindent
" TODO: enable this settings
" autocmd Filetype cpp setlocal cindent nosmartindent tabstop=2 softtabstop=2 expandtab
autocmd Filetype cpp setlocal cindent nosmartindent

" Hide stuff in:
"   anything from .gitignore,
"   the . and .. entries,
"   Vim swapfiles,
"   .git directory
"   unuseful stuff in ~
let g:netrw_list_hide= join([
\ netrw_gitignore#Hide(),
\  '.*\.sw?$',
\  '^\./$',
\  '^\.\./$',
\  '.*/\.git/$'],
\',')
" Hide netrw banner
let g:netrw_banner=0

" nechci intro
" f: (3 of 5) misto (file 3 of 5)
" i: [noeol]
" l: 999L, 888C misto 999 lines, 888 characters
" m: [+] misto modified
" n: [New] misto [New File]
" r: [RO]
" x: [dos], [unix], [mac]
" t: truncate file message zleva jestli je moc dlouha
" T: truncate uprostred jestli je moc dlouha
" o: overwrite message
" I: intro
set shortmess=filmnrxtToOI

let g:matchparen_insert_timeout=5

" Highlight end of line whitespace and mixed spaces and tabs
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/
au InsertLeave * match ExtraWhitespace /\s\+$\| \+\ze\t/

" u mad bro?
inoremap <Left> ←
inoremap <Right> →
inoremap <Up> ↑
inoremap <Down> ↓
inoremap <S-Left> ⇐
inoremap <S-Right> ⇒
inoremap <S-Up> ⇑
inoremap <S-Down> ⇓

" Highlight column 80
set colorcolumn=80,+0

set t_Co=256
set background=light

" Silence if colorscheme not installed.
set termguicolors
silent! colorscheme NeoSolarized

" Jump to last position on opening files (stolen from Destroy All Software)
" ('\" == mark when last exiting buffer, g` = go to, jumplist-nondestructive)
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Don't clear screen after exiting Vim.
" http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=

" HACK: to get syntax highlighting in Scala
" TODO: There's probably a proper mechanism to get this without autocmd.
au BufNewFile,BufRead *.scala set filetype=scala

au BufNewFile,BufRead *.ttl set filetype=turtle
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.textproto set filetype=proto

" Silence if Glaive not installed.
silent! Glaive codefmt google_java_executable="java -jar /home/agentydragon/bin/google-java-format.jar"

" Set autoformatter settings
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType rust AutoFormatBuffer rustfmt
  " autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
augroup END

set foldmethod=syntax
set foldcolumn=1
let javaScript_fold=1 "activate folding by JS syntax
set foldlevelstart=99
