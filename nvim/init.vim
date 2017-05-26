" Auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" -- Misc
Plug 'airblade/vim-rooter', { 'do': ':UpdateRemotePlugins' }
Plug 'b4winckler/vim-angry'
Plug 'jceb/vim-orgmode'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
" Plug 'justinmk/vim-sneak'
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
Plug 'Rip-Rip/clang_complete'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neomake/neomake'

let g:deoplete#enable_at_startup = 1
let g:neomake_open_list = 2

let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
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

" Leader
let mapleader=" "

" Colorscheme
if($TERM != 'screen')
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
nnoremap <C-l> :noh<CR><C-l>

" Search
set inccommand=split
set ignorecase smartcase
nnoremap / :noh<CR>/
" -- Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Automake
function! SetAutoMake(val)
    augroup automake
        au!
        if(a:val)
            echo 'Enable auto make'
            au BufWritePost * Neomake!
        else
            echo 'Disable auto make'
        endif
    augroup END
endfunction

nnoremap <Leader>m :call SetAutoMake(1)<CR>
nnoremap <Leader>M :call SetAutoMake(0)<CR>

" Windows
nnoremap <Leader><Tab> <C-^>
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

augroup quickfix
  au!
  " This trigger takes advantage of the fact that the quickfix window can be
  " easily distinguished by its file-type, qf. The wincmd J command is
  " equivalent to the Ctrl+W, Shift+J shortcut telling Vim to move a window to
  " the very bottom (see :help :wincmd and :help ^WJ).
  au FileType qf wincmd J
augroup END

" Tags
set csprg=gtags-cscope
noremap =t :NeomakeSh! global -u<CR>
nnoremap <Leader>G :Denite -buffer-name=gtags_completion gtags_completion<CR>
nnoremap <Leader>d :DeniteCursorWord -buffer-name=gtags_context gtags_context<CR>
nnoremap <Leader>D :DeniteCursorWord -buffer-name=gtags_ref gtags_ref<CR>
nnoremap <Leader>g :Tagbar<CR>

" Denite
nnoremap <Leader>f :Denite file_rec<CR>
nnoremap <Leader>r :Denite file_old<CR>
nnoremap <Leader>b :Denite buffer<CR>
nnoremap <Leader>o :Denite -auto-preview outline<CR>
nnoremap <Leader>l :Denite -auto-preview line<CR>
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
nnoremap <Leader>t :below 10new +terminal<CR>
nnoremap <Leader>T :below vnew +terminal<CR>

set secure
