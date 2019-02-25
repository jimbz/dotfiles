" Auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Leader
let g:mapleader=' '
let g:maplocalleader=','

" -- Misc system
Plug 'airblade/vim-rooter'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'

" -- Misc editing
Plug 'AndrewRadev/linediff.vim'
Plug 'jceb/vim-editqf'
Plug 'junegunn/goyo.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
let g:lion_squeeze_spaces = 1
Plug 'tpope/vim-commentary'
nmap <Leader>; gc
nmap <Leader>;; gcc
nmap <Leader>;y yyPgccj
nmap <Leader>;Y yypgcck
vmap <Leader>; gc
vmap <Leader>;Y yPgvgc'[
vmap <Leader>;y yP`[v`]gc']j
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

" -- Search
Plug 'dyng/ctrlsf.vim'

" -- Web browser
Plug 'tpope/vim-rhubarb'
Plug 'szw/vim-g'
noremap <Leader>K :Googlef<CR>

" -- Textobjects
Plug 'fvictorio/vim-textobj-backticks'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'PeterRincker/vim-argumentative'

" -- Buffers
Plug 'kana/vim-altr'
nmap <Leader>a <Plug>(altr-forward)
nmap <Leader>A <Plug>(altr-back)
Plug 'qpkorr/vim-bufkill'
let g:BufKillCreateMappings = 0

" -- Productivity
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
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
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h %<(18,trunc)%an%d %s %C(bold)%cr"'
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
command! -bang -nargs=* -complete=dir Agg
  \ call fzf#vim#ag_raw(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <Leader>p :GitFiles<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :History<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>o m':BTags<CR>
nnoremap <Leader>O m':Tags<CR>
nnoremap <Leader>l m':BLines<CR>
nnoremap <Leader>L m':Lines<CR>
nnoremap <Leader>gl m':BCommits<CR>
nnoremap <Leader>gL m':Commits<CR>
nnoremap <Leader>: :Commands<CR>

nnoremap <Leader>/ m':Ag<CR>
nnoremap <Leader>? m':Ag<Space>
nnoremap <Leader>* m':Ag \b<C-R><C-W>\b<CR>

" -- Git
Plug 'tpope/vim-fugitive'
nmap <Leader>gg :Gstatus<CR><C-w>K
nmap <Leader>gc :Gcommit -v<CR>
nmap <Leader>gC :Gcommit --amend -v<CR>
Plug 'airblade/vim-gitgutter'
nmap <Leader>gs <Plug>GitGutterStageHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk
nmap <Leader>gp <Plug>GitGutterPreviewHunk
" Fix conflict with textobj-comment
omap iC <Plug>GitGutterTextObjectInnerPending
omap aC <Plug>GitGutterTextObjectOuterPending
xmap iC <Plug>GitGutterTextObjectInnerVisual
xmap aC <Plug>GitGutterTextObjectOuterVisual
Plug 'junegunn/gv.vim'

" -- Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger='<c-j>'

" -- Sidebars, status bars
Plug 'majutsushi/tagbar'
let g:tagbar_sort = 0
let g:tagbar_compact = 1
nnoremap <Leader>T :TagbarOpenAutoClose<CR>
Plug 'mbbill/undotree'
let g:undotree_WindowLayout = 2

set statusline=
set statusline+=%#CursorColumn#
set statusline+=%(\ %f%(\ %m%)%)
set statusline+=%(\ (%{fugitive#head(6)})%)
set statusline+=\ 
set statusline+=%#StatusLine#
set statusline+=%<
set statusline+=%(\ %{tagbar#currenttag('%s',\ '',\ 'f')}\ %)
set statusline+=%=
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

" -- Autocomplete / lint
Plug 'skywind3000/asyncrun.vim'
command! -bang -nargs=* -complete=file Make AsyncRun<bang> -save=2 -post=checktime -program=make @ <args>
nnoremap <Leader>m :Make<CR>
nnoremap <Leader>k :AsyncStop<CR>
augroup qf_toggle
  au!
  autocmd User AsyncRunStart call asyncrun#quickfix_toggle(12, 1)
augroup END
Plug 'w0rp/ale'
let g:ale_c_lizard_options = '-ENS -EIgnoreAssert -T length=100'
let g:ale_python_auto_pipenv = 1

Plug 'ludovicchabant/vim-gutentags'
nnoremap <Leader>ug :GutentagsUpdate<CR>

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --quiet --clang-completer --rust-completer'  }
let g:ycm_python_binary_path = 'python'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_blacklist = {
      \ 'c': 1,
      \ 'cpp': 1,
      \ 'objc': 1,
      \ 'objcpp': 1,
      \}

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
let g:coc_user_config = {
      \  'languageserver': {
      \    'ccls': {
      \      'command': 'ccls',
      \      'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
      \        'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
      \        'initializationOptions': {
      \                'cacheDirectory': '/tmp/ccls'
      \        }
      \    }
      \  }
      \}
augroup coc_global
    " autocmd User CocNvimInit highlight! CocHighlightText cterm=bold gui=bold ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
    " autocmd User CocNvimInit highlight! link CocHighlightText StatusLine
    autocmd User CocNvimInit highlight! link CocHighlightText Search
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" -- Highlighting
Plug 'sheerun/vim-polyglot'
Plug 'ekalinin/Dockerfile.vim'  " polyglot version does not work: https://github.com/sheerun/vim-polyglot/issues/361

" -- Colorschemes
Plug 'iCyMind/NeoSolarized'
Plug 'arcticicestudio/nord-vim'
Plug 'romainl/Apprentice'
" Plug 'tomasr/molokai'
Plug 'shime/molokai'

" -- Debugger
Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }

" Initialize plugin system
call plug#end()

" Colorscheme
if $TERM ==# 'stterm-256color' || $TERM ==# 'xterm-kitty'
  set termguicolors
endif
set background=dark
colorscheme molokai

" Misc
set exrc
set cinoptions=(0
set wildmode=longest:full,full
set mouse=a
set hidden
set noshowmode
set nowrap
set undofile
set updatetime=100

nnoremap <Leader>c :echo systemlist('date')[0]<CR>

augroup auto_checktime
  au!
  autocmd BufEnter,FocusGained * checktime
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
set ignorecase
set smartcase
set hlsearch
nnoremap / :noh<CR>/
nnoremap <C-A-a> m':keeppattern ?^\w<CR>:noh<CR>
nnoremap <ESC>^[ <ESC>^[
nnoremap <silent> <CR> :noh<CR><CR>
nnoremap <silent> <ESC> :noh<CR><ESC>
nnoremap & :keepjumps normal *#<cr>

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
tnoremap <C-w>h <C-\><C-N><C-w>h
tnoremap <C-w>j <C-\><C-N><C-w>j
tnoremap <C-w>k <C-\><C-N><C-w>k
tnoremap <C-w>l <C-\><C-N><C-w>l
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
tnoremap <C-PageUp> <C-\><C-N>gT
tnoremap <C-PageDown> <C-\><C-N>gt
inoremap <A-End> gt
inoremap <A-Home> gT
nnoremap <A-End> gt
nnoremap <A-Home> gT

nnoremap <Leader>ts :tab split<CR>
nnoremap <Leader>tn :tab new<CR>
nnoremap <Leader>tc :tabclose<CR>

augroup my_quickfix
  au!
  " This trigger takes advantage of the fact that the quickfix window can be
  " easily distinguished by its file-type, qf. The wincmd J command is
  " equivalent to the Ctrl+W, Shift+J shortcut telling Vim to move a window to
  " the very bottom (see :help :wincmd and :help ^WJ).
  au FileType qf wincmd J
augroup END

" Terminal
nnoremap <Leader>th :below 10new +terminal<CR>
nnoremap <Leader>tv :below vnew +terminal<CR>
nnoremap <Leader>tt :tabnew +terminal<CR>
nnoremap <Leader>gt :vnew term://tig --first-parent<CR>
augroup my_terminal
  au!
  autocmd BufEnter,TermOpen term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup END

" Commands
command! -nargs=1 VimwikiDiaryDay execute "edit "
      \. "~/vimwiki/diary/"
      \. systemlist('date --date="<args>" +%Y-%m-%d')[0]
      \. ".md"

" Abbrevs
iabbrev ymd <C-r>=strftime('%Y%m%d')<CR>

function! s:init_coc() abort
  " Use <c-space> for trigger completion.
  inoremap <buffer> <silent><expr> <c-space> coc#refresh()

  " Remap keys for gotos
  nmap <buffer> <silent> <localleader>gd <Plug>(coc-definition)
  nmap <buffer> <silent> <localleader><localleader> <Plug>(coc-definition)
  nmap <buffer> <silent> <localleader>gD <Plug>(coc-type-definition)
  nmap <buffer> <silent> <localleader>gi <Plug>(coc-implementation)
  nmap <buffer> <silent> <localleader>gr <Plug>(coc-references)

  " Remap for rename current word
  nmap <buffer> <localleader>r <Plug>(coc-rename)

  " Use k for show documentation in preview window
  nnoremap <buffer> <silent> <localleader>k :call CocAction('doHover')<CR>
endfunction

" Default
nmap <LocalLeader><LocalLeader> gd

" Type-specific
augroup type_specific_conf
  au!
  au FileType c,cpp setlocal colorcolumn=80 list spell
  au FileType c,cpp setlocal errorformat^=%I%f:%l:%c:\ note:%m,%I%f:%l:\ note:%m,%f:%l:%c:\ %t%*[^:]:%m,%f:%l:\ %t%*[^:]:%m
  au FileType c,cpp nnoremap <buffer> <LocalLeader>c :AsyncRun -auto=make clang-tidy -header-filter='^%:h/.*' %<CR>
  au FileType c,cpp nnoremap <buffer> <LocalLeader>l :tabnew<CR>
        \:silent 0r ! lizard -ENS -EIgnoreAssert -T length=100 #<CR>
        \:silent setl nomodified nomodifiable<CR>
        \:silent nnoremap <buffer> q :tabclose<lt>CR><CR>
  au FileType c,cpp iabbrev <buffer> anoo __attribute__((optimize("O0"))) // FIXME
  au FileType c,cpp iabbrev <buffer> gnoo #pragma GCC optimize("O0") // FIXME
  au FileType c,cpp iabbrev <buffer> cnoo #pragma clang optimize off // FIXME

  au FileType rust,python nnoremap <buffer> <LocalLeader><LocalLeader> :YcmCompleter GoTo<CR>
  au FileType c,cpp call s:init_coc()

  au FileType vimwiki nnoremap <buffer> <LocalLeader>p :VimwikiDiaryPrevDay<CR>
  au FileType vimwiki nnoremap <buffer> <LocalLeader>n :VimwikiDiaryNextDay<CR>
  au FileType vimwiki nnoremap <buffer> <LocalLeader>d :VimwikiDiaryDay 
  au FileType vimwiki nnoremap <buffer> <LocalLeader>o 2o<ESC>:keeppattern s/.*/\="##### " . strftime("%a %D %H:%M")/<CR>o
  au FileType vimwiki nnoremap <buffer> <LocalLeader>N :keeppattern g/^\s*- \[[^xX]]/t$<CR>
  au FileType vimwiki nnoremap <buffer> <LocalLeader>s :keeppattern g/^\s*- \[[^ ]]/t$<CR>
  au FileType vimwiki nnoremap <buffer> <LocalLeader>S mmo# Summary<ESC>:keeppattern g/^\s*- \[[^ ]]/t$<CR>o<C-u><CR><CR># Next<CR><ESC>mnk:keeppattern 0,'mg/^# Backlog\\|^# Plan\\|^\s*- \[[^xX]]/t$<CR>:keeppattern 'n,$s/^#/##<CR>'nddG
  au FileType vimwiki setlocal wrap linebreak sidescrolloff=0 spell

  au Filetype cmake setlocal commentstring=#\ %s

  au FileType rust compiler cargo
  au FileType rust setlocal makeprg=cargo\ check

  au FileType tex let g:LatexBox_latexmk_preview_continuously=1 | let g:LatexBox_quickfix=2
augroup END

set secure
