" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" Make Vim more useful
set nocompatible

" Pathogen setup
filetype plugin indent on
execute pathogen#infect()
" Enable syntax highlighting
syntax on

" Press '' quickly in insert mode instead of Esc
imap '' <Esc>

" Treat all numerals as decimal even if zero padded
set nrformats=

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Hide buffers instead of closing them
set hidden

" Don't use old ways of protecting against data loss
set nobackup
set noswapfile

set pastetoggle=<leader>p

" Set indentation preferences
"   ts='number of spaces that <Tab> in file uses'
"   sts='number of spaces that <Tab> uses while editing'
"   sw='number of spaces to use for (auto)indent step'
" for details see: vimdoc.sourceforge.net/htmldoc/quickref.html#option-list
set expandtab
set ts=4 sw=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype sh setlocal ts=4 sts=4 sw=4

" Show column rulers
set colorcolumn=72,80


" Show whitespace
set list
set listchars=eol:¬,tab:>>,trail:.,extends:>,precedes:<

" vim-flake8
" Run flake8 when saving a python file
autocmd BufWritePost *.py call Flake8()

" NERDTree settings
" map <C-n> :NERDTreeToggle<CR>
nmap <leader>nt :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$','^\.DS_Store$']

" Might as well set the built in Explorer too
let g:netrw_liststyle=3

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" No wrap"
set nowrap
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Remove trailing whitespace for certain filetypes
fun! <SID>StripTrailingWhitespaces()
    let l=line(".")
    let c=col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,sh,vim autocmd BufWritePre
        \ <buffer> :call <SID>StripTrailingWhitespaces()

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif


" Setting for ctrlp plugin
let g:ctrlp_map='<c-p>'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_working_path_mode=''
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
set wildignore+=.DS_Store
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
set wildignore+=tags

let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'coverage':  '\v(htmlcov|\.?coverage)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Integrate ctrlp with ctags
nnoremap <leader>. :CtrlPTag<cr>


" Set up ag.vim
" Always start searching from the project root dir
let g:ag_working_path_mode="r"
nmap <leader>ag :Ag<SPACE>""<Left>

" Override grep to use Ag instead

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K yiw:Ag<SPACE><C-R>0<CR>


" Set up tagbar
nmap <leader>tb :TagbarToggle<CR>


" Setup rspec-vim
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
