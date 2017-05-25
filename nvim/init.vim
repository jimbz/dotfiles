" Auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" -- Misc
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-rooter', { 'do': ':UpdateRemotePlugins' }
Plug 'b4winckler/vim-angry'
Plug 'jceb/vim-orgmode'
Plug 'junegunn/vim-easy-align'
" Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'

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

let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_library_path = '/usr/local/opt/llvm/lib/'

" -- Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'iCyMind/NeoSolarized'

" Initialize plugin system
call plug#end()

" Leader
let mapleader=" "

" Colorscheme
set termguicolors
set background=dark
colorscheme NeoSolarized

" Misc
set exrc
set cino=(0
set wildmode=longest:full,full

" Search
set inccommand=split
set ignorecase smartcase
nnoremap / :noh<CR>/

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

" Tags
set csprg=gtags-cscope
noremap =t :!global -u<CR>
nnoremap <Leader>G :cstag 
nnoremap <Leader>g :Tagbar<CR>

" Denite
nnoremap <Leader>f :Denite file_rec<CR>
nnoremap <Leader>r :Denite file_old<CR>
nnoremap <Leader>b :Denite buffer<CR>
nnoremap <Leader>o :Denite outline<CR>
nnoremap <Leader>l :Denite line<CR>
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
set splitbelow splitright
nnoremap <Leader>t :10new +terminal<CR>
nnoremap <Leader>T :vnew +terminal<CR>

set secure
