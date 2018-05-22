" Pathogen
" --------

execute pathogen#infect()
syntax enable
filetype plugin indent on

" Configuration
" -------------

" Enable true colors if supported: https://gist.github.com/XVilka/8346728
if $COLORTERM ==# 'truecolor'
  set termguicolors
endif

set background=dark
colorscheme Base2Tone_PoolDark

if exists('+guifont')
  set guifont=Space\ Mono:h18
endif

" https://github.com/neovim/neovim/wiki/FAQ
if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
endif

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

set incsearch                   " Incremental search
set history=1024                " History size

set autoread                    " No prompt for file changes outside Vim
set noswapfile                  " No swap file
set nobackup                    " No backup file
set nowritebackup

set autowriteall                " Save when focus is lost


" File tree
" (netrw)
" ---------

" absolute width of netrw window
let g:netrw_winsize = 25
" tree-view
let g:netrw_liststyle = 3
" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'
" open file in a new tab
let g:netrw_browse_split = 3
" remove banner
let g:netrw_banner = 0


" Status line
" -----------

" lightline config
" -- INSERT -- is redundant because the mode information is displayed in the statusline:
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'Base2Tone_Pool',
      \ }
" (template is smart and detects light or dark colorscheme being used)


" Keybindings
" -----------
let mapleader = ","

" Indent/unindent visual mode selection
vmap <tab>      >gv
vmap <S-tab>    <gv

" Comment/uncomment lines (via tcomment)
map <leader>/   gcc

" auto-complete
set omnifunc=syntaxcomplete#Complete


" Search
" ------

" FuzzyFinder via :FZF
set rtp+=/usr/local/opt/fzf
map <leader>f :FZF<CR>

" Use Silver Searcher (Ag) with :Ack
" https://github.com/mileszs/ack.vim#can-i-use-ag-the-silver-searcher-with-this
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" JAVASCRIPT
" ----------

" Manage JS language packs directly instead of through polyglot
let g:polyglot_disabled = ['js']

" Ale
" ---
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\  'css': ['prettier'],
\  'scss': ['prettier'],
\  'markdown': ['prettier'],
\}

highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)

let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '🤔'

" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'

" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>
" ---

" Enable syntax highlighting for flow and JSDoc
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

" Highlight JSON files as javascript
autocmd BufRead,BufNewFile *.json set filetype=javascript

" 4 spaces in HTML
autocmd Filetype html,htmldjango set tabstop=4
autocmd Filetype html,htmldjango set shiftwidth=4

" 2 spaces everywhere else
autocmd Filetype javascript,css,sass,less,pug set tabstop=2
autocmd Filetype javascript,css,sass,less,pug set shiftwidth=2


" PYTHON
" ------

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
" -------------

silent! source ~/.vimrc.local

