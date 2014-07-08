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
set omnifunc=syntaxcomplete#Complete
" set ofu=syntaxcomplete#Complete

noremap <C-C> :botright cope<CR>
noremap <C-N> :cn<CR>
noremap <C-P> :cp<CR>

" to byvalo <S-M>, ale to koliduje s 'vyber prostredni radku'
noremap <Leader>m :make<CR>

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
inoremap <up> <nop>
vnoremap <up> <nop>
nnoremap <up> <nop>
inoremap <down> <nop>
vnoremap <down> <nop>
nnoremap <down> <nop>
inoremap <left> <nop>
vnoremap <left> <nop>
nnoremap <left> <nop>
inoremap <right> <nop>
vnoremap <right> <nop>
nnoremap <right> <nop>

" unlearn moving by single characters
"vnoremap h <nop>
"nnoremap h <nop>
"vnoremap l <nop>
"nnoremap l <nop>

" navigace mezi okny: krome Ctrl-W ... taky Ctrl-h,j,k,l,w
" zR: open all folds

set showcmd
set laststatus=2

" set statusline+=%{SyntasticStatuslineFlag()}
" let g:syntastic_enable_signs=1
" let g:syntastic_check_on_open=1
" let g:syntastic_error_symbol='✗'
" let g:syntastic_auto_loc_list=1
" " Passive Python, because Syntastic cries about print statements in Python 2.
" let g:syntastic_mode_map = { 'mode': 'active',
" \ 'active_filetypes': [ 'ruby', 'php', 'c' ],
" \ 'passive_filetypes': [ 'python' ]
" \ }

" Bundly: Airline, (uz ne) Syntastic
call pathogen#infect()

let g:airline_left_sep='' " was '>'
let g:airline_right_sep='' " was '<'
if !exists('g:airline_symbols')
	let g:airline_symbols={}
endif
let g:airline_symbols.readonly='RO'

" let g:airline#extensions#tabline#enabled = 1

" mensi tabulatory v Ruby a Railsovych templatech

" moje: chci tabulatory
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2 textwidth=80

autocmd Filetype python setlocal ts=2 sts=2 sw=2 textwidth=80
autocmd Filetype haml setlocal ts=2 sts=2 sw=2 noexpandtab textwidth=80
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2 textwidth=80
autocmd Filetype coffee setlocal ts=2 sts=2 sw=2 textwidth=80
autocmd Filetype tex setlocal textwidth=80

" skryj swapfily v NetRW
let g:netrw_list_hide='.*\.swp$'

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

set colorcolumn=80,120,+0

"let g:solarized_termcolors=256
set background=dark
colorscheme solarized
