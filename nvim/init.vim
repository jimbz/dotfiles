" Leader
let g:mapleader=' '
let g:maplocalleader=','
let g:polyglot_disabled = ['radiance']

lua require'packages'

nnoremap <leader>m <cmd>make<CR>

set termguicolors
set background=dark

" Misc
set autowrite
set exrc
set hidden
set mouse=a
set noshowmode
set nowrap
set title
set undofile
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

" Abbrevs
iabbrev ymd <C-r>=strftime('%Y%m%d')<CR>

" Default
nmap <LocalLeader><LocalLeader> gd

" Type-specific
augroup type_specific_conf
  au!
  au FileType c,cpp setlocal colorcolumn=100 list spell
  au FileType c,cpp setlocal errorformat^=%I%f:%l:%c:\ note:%m,%I%f:%l:\ note:%m,%f:%l:%c:\ %t%*[^:]:%m,%f:%l:\ %t%*[^:]:%m
  au FileType c,cpp nnoremap <buffer> <LocalLeader>l :tabnew<CR>
        \:silent 0r ! lizard -ENS -EIgnoreAssert -T length=100 #<CR>
        \:silent setl nomodified nomodifiable<CR>
        \:silent nnoremap <buffer> q :tabclose<lt>CR><CR>
  au FileType c,cpp iabbrev <buffer> anoo __attribute__((optimize("O0"))) // FIXME
  au FileType c,cpp iabbrev <buffer> gnoo #pragma GCC optimize("O0") // FIXME
  au FileType c,cpp iabbrev <buffer> cnoo #pragma clang optimize off // FIXME

  au FileType git set foldmethod=syntax

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
