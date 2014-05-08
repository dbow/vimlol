" Pathogen
" --------

execute pathogen#infect()
syntax enable
filetype plugin indent on

" Configuration
" -------------
colorscheme molokai
set background=dark
set guifont=Inconsolata:h18
set guioptions-=T               " Remove GUI toolbar
set visualbell                  " Suppress audio/visual error bell
set notimeout                   " No command timeout
set showcmd                     " Show typed command prefixes while waiting for operator

set expandtab                   " Use soft tabs
set tabstop=2                   " Tab settings
set autoindent
set smartindent
set smarttab                    " Use shiftwidth to tab at line beginning
set shiftwidth=2                " Width of autoindent
set number                      " Line numbers
set cc=80                       " Highlight 80 char column
set nowrap                      " No wrapping
set ignorecase                  " Ignore case
set smartcase                   " ... unless uppercase characters are involved
set ofu=syntaxcomplete#Complete " OMNI-COMPLETE

set list                        " Show whitespace
set listchars=tab:▸\ ,trail:¬   " UTF-8 characters for trailing whitespace
set virtualedit=onemore         " Cursor can display one character past line
set showmatch                   " Show matching brackets
set hidden                      " Allow hidden, unsaved buffers
set splitright                  " Add new windows towards the right
set splitbelow                  " ... and bottom
set wildmode=list:longest       " Bash-like tab completion
set scrolloff=3                 " Scroll when the cursor is 3 lines from edge
set cursorline                  " Highlight current line
set laststatus=2                " Always show statusline

" Status Line
" {{ Filename }} |
" len: {{ Total Lines }} |
" type: {{ File Type }} |
" A/H {{ Ascii / Hex value of current char }} |
" line: {{ line number }}
" col: {{ column number }}
set statusline=
set statusline+=\ %t\ \|\ len:\ \%L\ \|\ type:\ %Y\ \|\ A=\%03.3b/H=\%2.2B\ \|\ line:\ \%2l\ \|\ col:\ \%c


set incsearch                   " Incremental search
set history=1024                " History size

set autoread                    " No prompt for file changes outside Vim
set noswapfile                  " No swap file
set nobackup                    " No backup file
set nowritebackup

set autowriteall                " Save when focus is lost

" Keybindings
" -----------
let mapleader = ","

" Indent/unindent visual mode selection
vmap <tab>      >gv
vmap <S-tab>    <gv

" File tree browser
map \           :NERDTreeToggle<CR>

" FuzzyFinder
map <leader>f :FufFile **/<CR>
map <leader>rf :FufRenewCache<CR>

" Git blame
map <leader>g   :Gblame<CR>

" Comment/uncomment lines
map <leader>/   <plug>NERDCommenterToggle

" Pad comment delimeters with spaces
let NERDSpaceDelims = 1

" Small default width for NERDTree pane
let g:NERDTreeWinSize = 20

" Change working directory if you change root directories
let g:NERDTreeChDirMode=2

" Default JS checker is google syntax
let g:syntastic_javascript_checkers=["gjslint"]

" Highlight JSON files as javascript
autocmd BufRead,BufNewFile *.json set filetype=javascript

" SOY
" Syntax like HTML but 2 spaces for some reason
autocmd BufRead,BufNewFile *.soy set syntax=html
autocmd BufRead,BufNewFile *.soy set tabstop=2
autocmd BufRead,BufNewFile *.soy set shiftwidth=2

" HTML
" 4 spaces in HTML
autocmd Filetype html,htmldjango set tabstop=4
autocmd Filetype html,htmldjango set shiftwidth=4

" Machine-local vim settings - keep this at the end
silent! source ~/.vimrc.local
