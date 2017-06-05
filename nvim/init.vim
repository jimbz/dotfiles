" Auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Leader
let mapleader=" "

" -- Misc
Plug 'airblade/vim-rooter', { 'do': ':UpdateRemotePlugins' }
Plug 'b4winckler/vim-angry'
Plug 'jceb/vim-orgmode'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
" Plug 'justinmk/vim-sneak'
Plug 'kana/vim-altr'
nmap <Leader>a <Plug>(altr-forward)
nmap <Leader>A <Plug>(altr-back)
Plug 'mtth/scratch.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'

" -- Denite
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ozelentok/denite-gtags'
Plug 'chemzqm/vim-easygit'
Plug 'chemzqm/denite-git'

" -- FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" -- Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" -- Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" -- Sidebars, status bars
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='solarized'

" -- Autocomplete / lint
Plug 'skywind3000/asyncrun.vim'
command! Make copen | wincmd p | AsyncRun -program=make -save=2
nnoremap <Leader>m :Make<CR>
Plug 'roxma/nvim-completion-manager'
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
Plug 'w0rp/ale'
let g:ale_linters = {
      \   'c': ['clangcheck', 'clangtidy'],
      \   'cpp': ['clangcheck', 'clangtidy'],
      \}
Plug 'roxma/clang_complete'
let g:clang_auto_user_options = '.clang_complete, compile_commands.json'
if len(glob('/usr/local/opt/llvm/lib/'))
  let g:clang_library_path = '/usr/local/opt/llvm/lib/'
elseif len(glob('/usr/lib/llvm-3.8/lib/'))
  let g:clang_library_path = '/usr/lib/llvm-3.8/lib/'
endif

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
set cino=(0
set wildmode=longest:full,full
set mouse=a
set hidden
set noshowmode

augroup my_au
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
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Search
set inccommand=nosplit
set ignorecase smartcase
nnoremap / :noh<CR>/
nnoremap <C-A-a> ?^\S<CR>
inoremap <C-A-a> ?^\S<CR>
noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
augroup my_hls
  au!
  au InsertEnter * call feedkeys("\<Plug>(StopHL)", "m")
augroup END

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
set csprg=gtags-cscope
noremap =t :silent !global -u<CR>
nnoremap <Leader>G :Denite -buffer-name=gtags_completion gtags_completion<CR>
nnoremap <Leader>d :DeniteCursorWord -buffer-name=gtags_context gtags_context<CR>
nnoremap <Leader>D :DeniteCursorWord -buffer-name=gtags_ref gtags_ref<CR>
nnoremap <Leader>g :Tagbar<CR>
nnoremap gd :DeniteCursorWord -immediately -buffer-name=gtags_context gtags_context<CR>
" augroup my_c_cpp
"   au!
"   au FileType c,cpp  nmap <buffer> gd <Plug>(clang_complete_goto_declaration)
" augroup END

" Denite / FZF
nnoremap <Leader>p :GitFiles<CR>
nnoremap <Leader>f :Files<CR>
" nnoremap <Leader>f :Denite file_rec<CR>
nnoremap <Leader>r :History<CR>
" nnoremap <Leader>r :Denite file_old<CR>
nnoremap <Leader>b :Buffers<CR>
" nnoremap <Leader>b :Denite buffer<CR>
nnoremap <Leader>o :BTags<CR>
" nnoremap <Leader>o :Denite -auto-preview outline<CR>
nnoremap <Leader>l :BLines<CR>
" nnoremap <Leader>l :Denite -auto-preview line<CR>

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
nnoremap <Leader>/ :Ag<CR>
" nnoremap <Leader>/ :Denite -auto-preview grep<CR>
nnoremap <Leader>* :Ag <C-R><C-W><CR>
" nnoremap <Leader>* :DeniteCursorWord -auto-preview grep<CR>
" call denite#custom#var('grep', 'command', ['ag'])
" call denite#custom#var('grep', 'default_opts',
"       \ ['-i', '--vimgrep'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', [])
" call denite#custom#var('grep', 'separator', ['--'])
" call denite#custom#var('grep', 'final_opts', [])

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
augroup my_terminal
  au!
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup END

" ALE
call ale#linter#Define('c', {
      \ 'name': 'clangcheck',
      \ 'output_stream': 'stderr',
      \ 'executable': 'clang-check',
      \ 'command': 'clang-check %s',
      \ 'callback': 'ale#handlers#gcc#HandleGCCFormat',
      \ 'lint_file': 1,
      \})
call ale#linter#Define('cpp', {
      \ 'name': 'clangcheck',
      \ 'output_stream': 'stderr',
      \ 'executable': 'clang-check',
      \ 'command': 'clang-check %s',
      \ 'callback': 'ale#handlers#gcc#HandleGCCFormat',
      \ 'lint_file': 1,
      \})

set secure
