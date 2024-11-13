" Install vim-plug if not present:
"     https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" NOTE(dbow): nvim doesn't like this after polyglot loads but vimr requires
" it...
let g:polyglot_disabled = ['javascript']

" Plugins (via vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-sensible'
Plug 'atelierbram/Base2Tone-vim'
Plug 'mileszs/ack.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdtree'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Configuration
" -------------

" Enable true colors if supported: https://gist.github.com/XVilka/8346728
if $COLORTERM ==# 'truecolor'
  set termguicolors
endif

set background=dark
colorscheme Base2Tone_SuburbDark

" Settings for vimdiff
if &diff
  syntax off
  colorscheme delek
endif

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
set smartindent
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
set cursorline                  " Highlight current line

set noswapfile                  " No swap file
set nobackup                    " No backup file
set nowritebackup

set autowriteall                " Save when focus is lost

" For keybindings
let mapleader = ","
" tcomment's 'ic' binding interferes with CoC below.
let g:tcomment_textobject_inlinecomment = ''

" CoC config
" largely based on https://github.com/neoclide/coc.nvim#example-vim-configuration
" ---------

set cmdheight=2                 " Give more space for displaying messages.
set updatetime=300              " Having longer updatetime leads to bad experience
set shortmess+=c                " Don't pass messages to |ins-completion-menu|.

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = ['coc-json', 'coc-yaml', 'coc-prettier', 'coc-eslint', 'coc-tsserver', 'coc-flow', 'coc-css', 'coc-cssmodules']

" File tree
" ---------

" Show . hidden files/folders in NERDTree
let NERDTreeShowHidden=1
" Small default width for NERDTree pane
let g:NERDTreeWinSize = 20
" Change working directory if you change root directories
let g:NERDTreeChDirMode=2


" Status line
" -----------

" lightline config
" -- INSERT -- is redundant because the mode information is displayed in the statusline:
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'Base2Tone_Suburb',
      \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
        \     [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
          \ 'cocstatus': 'coc#status'
          \ },
      \ }
" (template is smart and detects light or dark colorscheme being used)


" Keybindings
" -----------

" Indent/unindent visual mode selection
vmap <tab>      >gv
vmap <S-tab>    <gv

" Tab navigation
nnoremap <leader>n  :tabnext<CR>
nnoremap <leader>p  :tabprev<CR>
nnoremap <leader>t  :tabnew<CR>

" Comment/uncomment lines (via tcomment)
map <leader>/   gcc

" auto-complete
set omnifunc=syntaxcomplete#Complete


" Search
" ------

" FuzzyFinder via :FZF
map <leader>f :FZF<CR>

" Use ripgrep with :Ack
if executable('rg')
  let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
  " And feed ripgrep into FZF to respect .gitignore, etc.
  " https://github.com/junegunn/fzf#respecting-gitignore
  let $FZF_DEFAULT_COMMAND='rg --files'
" Or use Silver Searcher (Ag) with :Ack
" https://github.com/mileszs/ack.vim#can-i-use-ag-the-silver-searcher-with-this
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
  " And feed Silver Searcher into FZF to respect .gitignore, etc.
  " https://github.com/junegunn/fzf#respecting-gitignore
  let $FZF_DEFAULT_COMMAND='ag -g ""'
endif

" Any empty ack search will search for the word the cursor is on
let g:ack_use_cword_for_empty_search = 1

" JAVASCRIPT
" ----------

" Enable syntax highlighting for flow and JSDoc
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
" Require .jsx for JSX syntax
let g:jsx_ext_required = 1

" 4 spaces in HTML
autocmd Filetype html,htmldjango set tabstop=4
autocmd Filetype html,htmldjango set shiftwidth=4

" 2 spaces everywhere else
autocmd Filetype javascript,typescript,typescriptreact,css,sass,less,pug set tabstop=2
autocmd Filetype javascript,typescript,typescriptreact,css,sass,less,pug set shiftwidth=2


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

