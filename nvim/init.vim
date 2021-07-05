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
Plug 'jpalardy/vim-slime'
let g:slime_target = 'neovim'

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

" -- Web browser
Plug 'shumphrey/fugitive-gitlab.vim'
let g:fugitive_gitlab_domains = ['https://gl.phiar.net']
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
"nmap <Leader>A <Plug>(altr-back)
Plug 'qpkorr/vim-bufkill'
let g:BufKillCreateMappings = 0

" -- Productivity
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]

" -- Git
Plug 'tpope/vim-fugitive'
nmap <Leader>gg :Gstatus<CR><C-w>K
nmap <Leader>gc :Gcommit -v<CR>
nmap <Leader>gC :Gcommit --amend -v<CR>
Plug 'airblade/vim-gitgutter'
nmap <Leader>gs <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
" Fix conflict with textobj-comment
omap iC <Plug>(GitGutterTextObjectInnerPending)
omap aC <Plug>(GitGutterTextObjectOuterPending)
xmap iC <Plug>(GitGutterTextObjectInnerVisual)
xmap aC <Plug>(GitGutterTextObjectOuterVisual)

" -- LSP, Navigation & Autocomplete
Plug 'w0rp/ale'
let g:ale_c_lizard_options = '-ENS -EIgnoreAssert -T length=100'
let g:ale_python_auto_pipenv = 1
let g:ale_linters = {
      \ 'cpp': ['clangtidy'],
      \ 'c': ['clangtidy']
      \ }
let g:ale_cpp_clangtidy_checks = [
      \ 'bugprone-*',
      \ 'cppcoreguidelines*',
      \ 'modernize-*',
      \ 'openmp-*',
      \ 'performance-*',
      \ 'readability-*',
      \ '-modernize-use-trailing-return-type'
      \]
let g:ale_c_build_dir_names = ['.', 'build', 'bin']
let g:ale_cpp_build_dir_names = ['.', 'build', 'bin']

Plug 'cdelledonne/vim-cmake'

" Plug 'ludovicchabant/vim-gutentags'
" nnoremap <Leader>ug :GutentagsUpdate<CR>
" let g:gutentags_ctags_extra_args = ['--exclude=*.ccls-cache/*']

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
"
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

Plug 'neovim/nvim-lspconfig'
Plug 'folke/lsp-colors.nvim'
Plug 'kabouzeid/nvim-lspinstall'

nnoremap <leader>A <cmd>ClangdSwitchSourceHeader<cr>
nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <leader>cr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>cc <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>cf <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>m <cmd>make<CR>
nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
inoremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>f <cmd>Telescope file_browser<cr>
nnoremap <leader>r <cmd>Telescope oldfiles<cr>
nnoremap <leader>q <cmd>Telescope quickfix<cr>
nnoremap <leader>" <cmd>Telescope registers<cr>
nnoremap <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <leader>* <cmd>Telescope grep_string<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
nnoremap <leader>o <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>O <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>e <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <leader>E <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>gi <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>ga <cmd>Telescope lsp_code_actions<cr>

Plug 'hrsh7th/nvim-compe'
set completeopt=menuone,noselect
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" -- Highlighting
Plug 'sheerun/vim-polyglot'
Plug 'ekalinin/Dockerfile.vim'  " polyglot version does not work: https://github.com/sheerun/vim-polyglot/issues/361

" -- Colorschemes
Plug 'iCyMind/NeoSolarized'
Plug 'arcticicestudio/nord-vim'
Plug 'romainl/Apprentice'
Plug 'tomasr/molokai'
" Plug 'shime/molokai'
Plug 'tanvirtin/monokai.nvim'

" -- Debugger
Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }

" Initialize plugin system
call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    if server == "clangd" then
      require'lspconfig'[server].setup{
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--completion-style=detailed" }
      }
    elseif server == "kotlin" then
      require'lspconfig'[server].setup{
          settings = { kotlin = { compiler = { jvm = { target = "1.8" } } } }
      }
    else
      require'lspconfig'[server].setup{
        capabilities = capabilities,
      }
    end
  end
end

setup_servers()
-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = false;
  };
}

require'lsp-colors'.setup()
EOF

" Colorscheme
if $TERM ==# 'stterm-256color' || $TERM ==# 'xterm-kitty' || $TERM ==# 'screen-256color'
  set termguicolors
endif
set background=dark
colorscheme monokai

" Misc
set autowrite
set exrc
set hidden
set mouse=a
set noshowmode
set nowrap
set title
set undofile
set updatetime=100
set wildmode=longest:full,full

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
  autocmd TermOpen * echom 'Terminal id: ' b:terminal_job_id
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

" Default
nmap <LocalLeader><LocalLeader> gd

" Type-specific
augroup type_specific_conf
  au!
  au FileType c,cpp setlocal colorcolumn=120 list spell
  au FileType c,cpp setlocal errorformat^=%I%f:%l:%c:\ note:%m,%I%f:%l:\ note:%m,%f:%l:%c:\ %t%*[^:]:%m,%f:%l:\ %t%*[^:]:%m
  au FileType c,cpp nnoremap <buffer> <LocalLeader>l :tabnew<CR>
        \:silent 0r ! lizard -ENS -EIgnoreAssert -T length=100 #<CR>
        \:silent setl nomodified nomodifiable<CR>
        \:silent nnoremap <buffer> q :tabclose<lt>CR><CR>
  au FileType c,cpp iabbrev <buffer> anoo __attribute__((optimize("O0"))) // FIXME
  au FileType c,cpp iabbrev <buffer> gnoo #pragma GCC optimize("O0") // FIXME
  au FileType c,cpp iabbrev <buffer> cnoo #pragma clang optimize off // FIXME

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

lua require'packages'
