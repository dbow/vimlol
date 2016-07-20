" Pathogen
" --------

execute pathogen#infect()
syntax enable
filetype plugin indent on

" Configuration
" -------------
colorscheme base16-oceanicnext
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


let NERDTreeShowHidden=1        " Show . hidden files/folders in NERDTree
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

" JS, CSS, SASS, LESS, JADE/PUG
" 2 spaces
autocmd Filetype javascript,css,sass,less,jade,pug set tabstop=2
autocmd Filetype javascript,css,sass,less,jade,pug set shiftwidth=2

" HTML
" 4 spaces in HTML
autocmd Filetype html,htmldjango set tabstop=4
autocmd Filetype html,htmldjango set shiftwidth=4

" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

" Machine-local vim settings - keep this at the end
silent! source ~/.vimrc.local
