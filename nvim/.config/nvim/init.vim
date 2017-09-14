" .config/nvim/init.vim configuration file
" Copyright (C) 2017 Matthew B. Gray
"
" This program is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.

" setting <leader>
let mapleader = "\<tab>"

" Remove ALL autocommands for the current group.
" autocmd!
" Comment out just in case it's doing something with the highlights

call plug#begin('~/.config/nvim/plugged')
Plug 'git@github.com:heymatthew/vim-unclutter.git'
Plug 'git@github.com:heymatthew/vim-visible-whitespace.git'
Plug 'git@github.com:heymatthew/vim-prose.git'
Plug 'antoyo/vim-licenses'               " Help with open source licences
Plug 'Yggdroot/indentLine'               " Show indent levels
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " Golang tools
" Plug 'rhysd/vim-textobj-ruby'          " Ruby text objects NVIM BUSTED??
Plug 'tpope/vim-rails'                   " Rails tools
Plug 'ecomba/vim-ruby-refactoring'       " TODO make some habits around this
Plug 'vim-ruby/vim-ruby'                 " Make ruby files FAST
Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'godlygeek/tabular'                 " Align stuff
Plug 'michaeljsmith/vim-indent-object'   " Select indents as an object
Plug 'roman/golden-ratio'                " Layout splits with golden ratio
Plug 'nelstrom/vim-textobj-rubyblock'    " Match ruby blocks
Plug 'vim-syntastic/syntastic'           " Generic linter
Plug 'vim-scripts/LargeFile'             " turn off slow stuff in files > 20mb
let g:golden_ratio_autocommand = 0
nnoremap <silent> <C-w>- :GoldenRatioResize<CR>:GoldenRatioResize<CR>
Plug 'scrooloose/nerdtree'               " File browser
let NERDTreeShowLineNumbers = 1          " Make nerdtree honor numbers
let NERDTreeShowHidden = 1               " Show dotfiles
autocmd FileType nerdtree setlocal number relativenumber
Plug 'tpope/vim-fugitive'                " Git integration, TODO adjust habits
Plug 'mattn/gist-vim'                    " Create gists
Plug 'tpope/vim-surround'                " Delete, or insert around text objects
Plug 'altercation/vim-colors-solarized'  " Sexy has a new plugin
Plug 't9md/vim-textmanip'                " Move text about
Plug 'rakr/vim-one'                      " Like Atom
Plug 'sickill/vim-monokai'               " Like Sublime
Plug 'elzr/vim-json'                     " JSON
Plug 'kchmck/vim-coffee-script'          " Syntax for coffeescript
let g:vim_json_syntax_conceal = 0        " Don't hide quotes in JSON files
Plug 'junegunn/fzf', { 'dir': '~/code/fzf', 'do': 'yes \| ./install' }
Plug 'ctrlpvim/ctrlp.vim'                " Fuzzy search files, recent files, and buffers
Plug 'reedes/vim-lexical'                " Spell-check and thesaurus/dictionary completion
Plug 'reedes/vim-wordy'                  " Identify phrases for history of misuse, abuse, and overuse
Plug 'reedes/vim-textobj-sentence'       " Sophisticated sentence text object
Plug 'tpope/vim-commentary'              " Toggle comments on lines
Plug 'reedes/vim-pencil'
Plug 'haya14busa/incsearch.vim'          " incremental search tool
let g:incsearch#auto_nohlsearch = 1
Plug 'bronson/vim-visual-star-search'    " Vim multiline search
" Plug 'othree/eregex.vim'                 " PCRE engine for VIM
" nnoremap / :M/
" nnoremap ,/ /
let g:pencil#textwidth = 120
"autocmd FileType markdown,mkd call pencil#init()
"                          \ | call lexical#init()
"                          \ | call textobj#sentence#init()

call plug#end()

set relativenumber        " better navigation
set number                " give line number that you're on
set scrolloff=5           " when scrolling, keep cursor 5 lines away from border
set foldmethod=manual     " Fold by indent level
set autoread              " When someone modifies a file externally, autoread it back in
set textwidth=120         " Line length should be ~120 chars #modern
set clipboard=unnamedplus " yank and put straight to system clipboard


""""""""""""""""""""""""""""""""""""""""
" Spelling and autocorrect
set spl=en spell       " Use English for spellchecking,
iabbrev waht what
iabbrev tehn then
iabbrev teh the
iabbrev hte the
iabbrev functino function
iabbrev iamge image
iabbrev wehn when

" spell checker automatically there for text and markdown
set nospell

""""""""""""""""""""""""""""""""""""""""
" Searching
set hlsearch           " Highlight my searches :)
set ignorecase         " Do case insensitive matching.
set smartcase          " Do smart case matching.
set incsearch          " Incremental search.
set magic              " Allows pattern matching with special characters

" Search and page mappings: center cursor when jumping in search
nnoremap N Nzz
nnoremap n nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

""""""""""""""""""""""""""""""""""""""""
" Code
set expandtab          " Pressing tab inserts spaces
set autoindent         " indent on newlines
set smartindent        " recognise syntax of files
set colorcolumn=120    " Show 120th char visually

" Whitespace management
set                                expandtab   tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype go       setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype markdown setlocal expandtab   tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype perl     setlocal expandtab   tabstop=4 softtabstop=4 shiftwidth=4

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
" if exists(":Tabularize") > 0
  vnoremap <cr> :Tabularize /
" endif

" Quickly open rc files
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>zz :e $HOME/.zshrc<CR>

nnoremap H <C-o> " Browse code like you're using vimium back button
nnoremap L <C-i> " Browse code like you're using vimium forward button

" Colours
try
  " silent colorscheme solarized
  " set background=light
  set background=dark
  colorscheme solarized
  set guifont=hack:h12
catch
  " If colors and fonts fail, this isn't a big deal
endtry

" Search [f]iles, [l]ines, [r]ecent files
nnoremap <leader>f :FZF<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|tmp)$',
  \ 'file': '\.pyc$\|\.pyo$|\.class$|\.min\..*\.js',
  \ }

" Source local configuration files if available
if filereadable($HOME . '/.vimrc.local')
    source $HOME/.vimrc.local
endif

" For vim stuff local to the host you're on
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" If we're in a fresh vim, under $HOME
" AND there is a pinned directory present
"   THEN Change to this directory
"   SO that we can act as if we're in the default system project
if filereadable($HOME . "/.pindir") && getcwd() == $HOME
    let pindir_lines = readfile($HOME . "/.pindir")
    if len(pindir_lines) > 0
        exe "chdir " . pindir_lines[0]
    endif
endif

" Quickfix window when shelling out to grep
" Also works for Git grep
"   e.g. :Ggrep FIXME
"   see https://github.com/tpope/vim-fugitive
" autocmd QuickFixCmdPost *grep* cwindow
"
" Also http://stackoverflow.com/a/39010855/81271
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Quickfix horizontal
" https://stackoverflow.com/a/16743676
autocmd FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L


" Find/Search: Remap CTRL F, most of this is a workaround to how grep windows work
vnoremap * y/<C-R>"<CR>
vmap <C-F> :cclose<CR>y:silent Ggrep -I "<C-R>""<CR>
nmap <C-F> :cclose<CR>yiw:silent Ggrep -I "<C-R>""<CR>

" ^^ open window in new tab, split and search
" TODO Detect :Ggrep, fall back on :grep

" Shared data across nvim sessions
" '500  : save last 500 files local marks [a-z]
" f1    : also store global marks [A-Z0-9]
" <500  : store only 500 lines of registers
set shada='500,f1

" EXCEPTION, cursor placement at top on git commit
autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"

" Quickly open, reload and edit rc files
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>vrr :source $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>:PlugUpdate<CR>:source $MYVIMRC<CR>
nnoremap <leader>zz :e $HOME/.zshrc<CR>

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

" Ticket lookup based on branch for pleasant lawyer
autocmd FileType gitcommit nnoremap T O<ESC>:.!git rev-parse --abbrev-ref HEAD<CR>g~iWA 


" Vertical split for help files
" autocmd FileType help wincmd L

set splitright
" set splitbelow

" jj is like escape
inoremap jj <ESC>

" Copy current file to clipboard
nnoremap <leader>cf :let @*=expand("%")<CR>

" Triage stuff: Quickly open and close tabs
nnoremap <leader><leader> :tab split<cr>
nnoremap <backspace><backspace> :tabclose<cr>

" Quickly split current view
nmap <leader>y :split<cr><C-w>-
nmap <leader>x :vsplit<cr><C-w>-

" Ctrl + w actions in terminal windows
tnoremap <C-w> <C-\><C-N><C-w>

" Double Escape and jj leave insert mode
tnoremap <ESC><ESC> <C-\><C-N>

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave             term://* stopinsert
autocmd TermOpen * setlocal statusline=%{b:term_title}


" tnoremap jj <C-\><C-N>
" tnoremap <C-h> <C-\><C-N><C-w>h
" tnoremap <C-j> <C-\><C-N><C-w>j
" tnoremap <C-k> <C-\><C-N><C-w>k
" tnoremap <C-l> <C-\><C-N><C-w>l
" inoremap <C-h> <C-\><C-N><C-w>h
" inoremap <C-j> <C-\><C-N><C-w>j
" inoremap <C-k> <C-\><C-N><C-w>k
" inoremap <C-l> <C-\><C-N><C-w>l
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Movement stuff
let g:textmanip_startup_mode = "insert"
xmap <up>    <Plug>(textmanip-move-up)
xmap <down>  <Plug>(textmanip-move-down)
xmap <left>  <Plug>(textmanip-move-left)
xmap <right> <Plug>(textmanip-move-right)

" Experimental go stuff
autocmd Filetype go nnoremap <buffer> R  :GoRun<CR>
autocmd Filetype go nnoremap <buffer> TT :GoAlternate<CR>
autocmd Filetype go nnoremap <buffer> T  :GoTest<CR>
let g:go_template_autocreate = 0

" Set title on terminal to focused buffer filename
auto BufEnter * :set title | let &titlestring = 'v:' . expand('%')

" Use system clipboard
set clipboard=unnamed
" set clipboard=unnamedplus

" w!! saves as sudo
cmap w!! w !sudo tee > /dev/null %

let git_user = systemlist("git config user.name")[0]
let g:licenses_copyright_holders_name = ($EMPLOYER == "" ? git_user : $EMPLOYER)
