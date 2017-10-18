" Auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Leader
let g:mapleader=' '
let g:maplocalleader=','

" -- Misc
Plug 'airblade/vim-rooter', { 'do': ':UpdateRemotePlugins' }
Plug 'b4winckler/vim-angry'
Plug 'dyng/ctrlsf.vim'
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsFlyMode=1
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-altr'
Plug 'ludovicchabant/vim-gutentags'
nmap <Leader>a <Plug>(altr-forward)
nmap <Leader>A <Plug>(altr-back)
Plug 'michaeljsmith/vim-indent-object'
Plug 'mtth/scratch.vim'
Plug 'PeterRincker/vim-argumentative'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
nmap <Leader>; gc
nmap <Leader>;; gcc
nmap <Leader>;y yyPgccj
nmap <Leader>;Y yypgcck

vmap <Leader>; gc
vmap <Leader>;Y yPgvgc'[
vmap <Leader>;y yP`[v`]gc']j
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'vitalk/vim-simple-todo'
let g:simple_todo_map_keys = 0
nmap <Leader>si <Plug>(simple-todo-new)
nmap <Leader>sI <Plug>(simple-todo-new-start-of-line)
nmap <Leader>so <Plug>(simple-todo-below)
nmap <Leader>sO <Plug>(simple-todo-above)
nmap <Leader>sx <Plug>(simple-todo-mark-as-done)
nmap <Leader>sX <Plug>(simple-todo-mark-as-undone)
nmap <Leader>ss <Plug>(simple-todo-mark-switch)
vmap <Leader>sI <Plug>(simple-todo-new-start-of-line)
vmap <Leader>sX <Plug>(simple-todo-mark-as-undone)
vmap <Leader>sx <Plug>(simple-todo-mark-as-done)
vmap <Leader>ss <Plug>(simple-todo-mark-switch)

" -- FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" -- Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

" -- Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" -- Sidebars, status bars
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
let g:undotree_WindowLayout = 2
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='solarized'

" -- Autocomplete / lint
Plug 'skywind3000/asyncrun.vim'
command! -bang -nargs=* -complete=file Make AsyncRun -auto=make -save=2 -program=make @ <args>
nnoremap <Leader>m :Make<CR>
nnoremap <Leader>k :AsyncStop<CR>
augroup qf_toggle
  autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)
augroup END
Plug 'mh21/errormarker.vim'
Plug 'w0rp/ale'

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = 'location'
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd', '-enable-snippets', '-j=50'],
    \ 'cpp': ['clangd', '-enable-snippets', '-j=50'],
    \ }

Plug 'roxma/nvim-completion-manager', { 'do': ':UpdateRemotePlugins' }
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" -- Python
Plug 'roxma/python-support.nvim'
" ---- for NCM
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')
" ---- for ALE
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'flake8')

" -- Highlighting
Plug 'sheerun/vim-polyglot'

" -- Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'iCyMind/NeoSolarized'

" Initialize plugin system
call plug#end()

" Colorscheme
if(match($TERM, 'screen') < 0)
  set termguicolors
endif
set background=dark
colorscheme NeoSolarized

" Misc
set exrc
set cinoptions=(0
set wildmode=longest:full,full
set mouse=a
set hidden
set noshowmode
set nowrap
set undofile
let g:ale_c_lizard_options = '-ENS -EIgnoreAssert -T length=100'
augroup my_c_cpp
  au!
  au FileType c,cpp setlocal foldmethod=syntax | normal zR
  au FileType c,cpp setlocal colorcolumn=80
  au FileType c,cpp setlocal list
  au FileType c,cpp setlocal errorformat^=%I%f:%l:%c:\ note:%m,%I%f:%l:\ note:%m,%f:%l:%c:\ %t%*[^:]:%m,%f:%l:\ %t%*[^:]:%m
  au FileType c,cpp nnoremap <buffer> <LocalLeader>c :AsyncRun -auto=make clang-tidy -header-filter='^%:h/.*' %<CR>
  au FileType c,cpp nnoremap <buffer> <LocalLeader>l :tabnew<CR>
        \:silent 0r ! lizard -ENS -EIgnoreAssert -T length=100 #<CR>
        \:silent setl nomodified nomodifiable<CR>:q
augroup END

augroup my_au
  au!
  autocmd BufEnter,FocusGained,CursorHold,CursorHoldI * checktime
augroup END

" From defaults.vim
augroup vimStartup
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Highlight characters that cause problems
" (from https://github.com/fidian/bin/blob/master/conf/vimrc)
" \u00a0  hard space, non-breaking space
" \u1680  Ogham space mark (usually read as a dash)
" \u180e  Mongolian vowel separator (no width)
" \u2000  en quad
" \u2001  em quad
" \u2002  en space
" \u2003  em space
" \u2004  three-per-em space
" \u2005  four-per-em space
" \u2006  six-per-em space
" \u2007  figure space
" \u2008  punctuation space
" \u2009  thin space
" \u200a  hair space
" \u200b  zero width space
" \u2014  hyphen (not really whitespace)
" \u202f  narrow non-breaking space
" \u205f  medium mathematical space
" \u3000  ideographic space
" \uffff  zero width non-breaking space
highlight ErrorCharacters ctermbg=red guibg=red
match ErrorCharacters "[\u00a0\u1680\u180e\u2000-\u200b\u2014\u202f\u205f\u3000\uffff]"

" Search
set inccommand=nosplit
set ignorecase smartcase
nnoremap / :noh<CR>/
nnoremap <C-A-a> ?^\w<CR>:noh<CR>
inoremap <C-A-a> ?^\w<CR>:noh<CR>
nnoremap <ESC>^[ <ESC>^[
nnoremap <silent> <CR> :noh<CR><CR>
nnoremap <silent> <ESC> :noh<CR><ESC>
nnoremap <silent> i :noh<CR>i
nnoremap <silent> I :noh<CR>I
nnoremap <silent> a :noh<CR>a
nnoremap <silent> A :noh<CR>A
nnoremap <silent> o :noh<CR>o
nnoremap <silent> O :noh<CR>O

" Windows
nnoremap <Leader><Tab> <C-^>
nnoremap <Leader>w <C-w>
nnoremap <Leader>1 :1wincmd w<CR>
nnoremap <Leader>2 :2wincmd w<CR>
nnoremap <Leader>3 :3wincmd w<CR>
nnoremap <Leader>4 :4wincmd w<CR>
nnoremap <Leader>5 :5wincmd w<CR>
nnoremap <Leader>6 :6wincmd w<CR>
nnoremap <Leader>7 :7wincmd w<CR>
nnoremap <Leader>8 :8wincmd w<CR>
nnoremap <Leader>9 :9wincmd w<CR>

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

tnoremap <A-End> <C-\><C-N>gt
tnoremap <A-Home> <C-\><C-N>gT
inoremap <A-End> gt
inoremap <A-Home> gT
nnoremap <A-End> gt
nnoremap <A-Home> gT

augroup my_quickfix
  au!
  " This trigger takes advantage of the fact that the quickfix window can be
  " easily distinguished by its file-type, qf. The wincmd J command is
  " equivalent to the Ctrl+W, Shift+J shortcut telling Vim to move a window to
  " the very bottom (see :help :wincmd and :help ^WJ).
  au FileType qf wincmd J
augroup END

" Tags
augroup my_c_cpp_tags
  au!
  set cscopeprg=gtags-cscope
  set cscopetag
  set cscopequickfix=s-,d-,c-,t-,e-,i-,a-
  au FileType c,cpp nnoremap <buffer> <LocalLeader>t :AsyncRun global -u<CR>
  au FileType c,cpp nnoremap <buffer> <LocalLeader>G m':Denite -buffer-name=gtags_completion gtags_completion<CR>
  au FileType c,cpp nnoremap <buffer> <LocalLeader>d m':DeniteCursorWord -buffer-name=gtags_context gtags_context<CR>
  au FileType c,cpp nnoremap <buffer> <LocalLeader>D m':DeniteCursorWord -buffer-name=gtags_ref gtags_ref<CR>
  au FileType c,cpp nnoremap <buffer> <LocalLeader>g :Tagbar<CR>
  au FileType c,cpp nnoremap <buffer> <LocalLeader>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
  au FileType c,cpp nnoremap <buffer> <silent> gD m':call LanguageClient_textDocument_definition()<CR>
augroup END

" FZF
nnoremap <Leader>ug :GutentagsUpdate<CR>
nnoremap <Leader>p :GitFiles<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :History<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>o m':BTags<CR>
nnoremap <Leader>O m':Tags<CR>
nnoremap <Leader>l m':BLines<CR>
nnoremap <Leader>L m':Lines<CR>

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <Leader>/ m':Ag<CR>
nnoremap <Leader>? m':Ag<Space>
nnoremap <Leader>* m':Ag <C-R><C-W><CR>

nnoremap <Leader><Leader> :Denite 
call denite#custom#map(
      \ 'insert',
      \ '<Down>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<Up>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

" Terminal
nnoremap <Leader>th :below 10new +terminal<CR>
nnoremap <Leader>tv :below vnew +terminal<CR>
nnoremap <Leader>tt :tabnew +terminal<CR>
nnoremap <Leader>T :vnew term://tig<CR>
augroup my_terminal
  au!
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup END

set secure
