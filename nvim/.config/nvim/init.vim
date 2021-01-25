" Copyright (c) 2021 Matthew B. Gray
"
" Permission is hereby granted, free of charge, to any person obtaining a copy of
" this software and associated documentation files (the "Software"), to deal in
" the Software without restriction, including without limitation the rights to
" use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
" the Software, and to permit persons to whom the Software is furnished to do so,
" subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
" FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
" COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
" IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
" CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

" .config/nvim/init.vim configuration file

" Quickly open rc files
let mapleader = "\<tab>"

"----------------------------------------
" Setting up Vundle, vim plugin manager
let plug_location=expand('~/.local/share/nvim/site/autoload/plug.vim')
if !filereadable(plug_location)
  echo "Installing plug"
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "Plug installed, reload?"
  finish " stop loading the rest of this script
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'roman/golden-ratio'                " golden ratio splits
" let g:golden_ratio_autocommand = 0     " not by default
nnoremap <silent> <C-w>- :GoldenRatioResize<CR>

" Tpope, just love his stuff
Plug 'tpope/vim-fugitive'     " Git integration, TODO adjust habits
Plug 'tpope/vim-surround'     " Delete, or insert around text objects
Plug 'tpope/vim-commentary'   " Toggle comments on lines
Plug 'tpope/vim-unimpaired'   " <3 pairings that marry ] and ['s REALLY GOOD, 5 stars

" fzf fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/code/fzf', 'do': 'yes \| ./install' }
augroup fuzzy_finder
  " let g:jzf_history_dir = '~/.local/share/nvim/site/autoload/plug.vim'
  " let g:fzf_command_prefix = 'Fzf'
  nnoremap <leader>f :FZF<CR>
  nnoremap <silent> <leader>m :History<CR>
augroup END

" Text search using pt - the platinum searcher
Plug 'nazo/pt.vim'
augroup text_search
  " Search word or highlight window in new tab, split and search
  vmap <C-f> y:silent Pt "<C-r>0"<CR>zz
  nmap <C-f> yiw:silent Pt "<C-r>0"<CR>
augroup END

call plug#end()

set relativenumber        " better navigation
set number                " give line number that you're on
set scrolloff=5           " when scrolling, keep cursor 5 lines away from border
set foldmethod=manual     " Fold by indent level
set autoread              " When someone modifies a file externally, autoread it back in
set textwidth=100         " Line length should be ~100 chars #modern
set colorcolumn=100       " Show 100th char visually
set clipboard=unnamedplus " yank and put straight to system clipboard
set nojoinspaces          " Single space after period when using J
set hlsearch              " Highlight my searches :)
set ignorecase            " Do case insensitive matching.
set smartcase             " Do smart case matching.
set incsearch             " Incremental search.
set magic                 " Allows pattern matching with special characters
set spl=en spell          " Use English for spellchecking,
set nospell               " Spellcheck is off initially
set autoindent            " indent on newlines
set smartindent           " recognise syntax of files
set mouse=a " Let vim use the mouse, grab and pull splits around etc.

iabbrev waht what
iabbrev tehn then
iabbrev teh the
iabbrev hte the
iabbrev functino function
iabbrev iamge image
iabbrev wehn when
 
" Search and page mappings: center cursor when jumping in search
nnoremap N Nzz
nnoremap n nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Whitespace management
set                                expandtab   tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype go       setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype markdown setlocal expandtab   tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype perl     setlocal expandtab   tabstop=4 softtabstop=4 shiftwidth=4
highlight TrailingWhitespace ctermbg=grey guibg=grey
match TrailingWhitespace /\s\+$/
 
nnoremap H <C-o> " Browse code like you're using vimium back button
nnoremap L <C-i> " Browse code like you're using vimium forward button
 
vmap <C-f> y:lclose<CR>:silent Glgrep -I "<C-r>0"<CR>zz
nmap <C-f> :call Find()<CR>

" Shared data across nvim sessions
" '500  : save last 500 files local marks [a-z]
" f1    : also store global marks [A-Z0-9]
" <500  : store only 500 lines of registers
set shada='500,f1
" SHADA EXCEPTION, cursor placement at top on git commit
autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"
 
" " Quickly open, reload and edit rc files
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>:PlugUpdate<CR>:source $MYVIMRC<CR>:GoInstallBinaries<CR>
nnoremap <leader>zz :e $HOME/.zshrc<CR>

function! UpdateEverything()
  exe('source ' . $MYVIMRC)
  exe('PlugUpdate')
  exe('source ' . $MYVIMRC)
  exe('GoInstallBinaries')
endfunction

" Syntax highlighting is often not quite right.
nnoremap <leader>t :set filetype=
 
" turn off EX mode (it annoys me, I don't use it)
":map Q <Nop>
" More usefully, reformat paragraphs with vim rules
" - http://alols.github.io/2012/11/07/writing-prose-with-vim
" - https://github.com/reedes/vim-pencil
map Q gqap
 
" Display line numbers in help
autocmd FileType help setlocal number relativenumber

" Vertical split for help files
autocmd FileType help wincmd L

" Copy current file to clipboard
nnoremap <leader>cf :let @*=expand("%")<CR>

" Triage stuff: Quickly cycle between contexts
nnoremap <leader><leader> :tab split<cr>
nnoremap <backspace><backspace> :tabclose<cr>
 
" Quickly split current view
nmap <leader>y 0:lclose<CR>:cclose<CR>:split<CR>
nmap <leader>x 0:lclose<CR>:cclose<CR>:vsplit<CR>
nmap <leader>n 0:rightbelow vnew<CR>
set splitright

" Open current focused file in new tab
nnoremap <leader><leader> :tab split<CR>
nnoremap <leader>q <C-w>q
 
" Set title on terminal to focused buffer filename
auto BufEnter * :set title | let &titlestring = 'v:' . expand('%')
"
" w!! saves as sudo
cmap w!! w !sudo tee > /dev/null %

" from https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" Open file browser in the directory of the current file
nnoremap <space><space> :edit %:p:h<CR>

" Open git status
nnoremap <leader>g :Gstatus<CR>

" " jj is like escape
" inoremap jj <ESC>
" 
" " Non chorded window commands, e.g. leader w v -> vsplit
" nmap <leader>w <C-w>
"
" " Double Escape and jj leave insert mode in terminal
" tnoremap <ESC><ESC> <C-\><C-N>
"
" " Ctrl + w actions in terminal windows
" tnoremap <C-w> <C-\><C-N><C-w>
"
" " Terminal enters insert mode automatically
" autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert
" autocmd BufLeave                      term://* stopinsert
" autocmd TermOpen * setlocal statusline=%{b:term_title}
