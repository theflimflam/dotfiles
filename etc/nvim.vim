" .config/nvim/init.vim configuration file
" Copyright (C) 2016 Matthew B. Gray
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

let mapleader = "\<tab>"
"let mapleader = ","


call plug#begin('~/.config/nvim/plugged')
Plug 'git@github.com:theflimflam/vim-unclutter.git'
Plug 'git@github.com:theflimflam/vim-visible-whitespace.git'
Plug 'fatih/vim-go'                      " Golang tools
" Plug 'rhysd/vim-textobj-ruby'            " Ruby text objects NVIM BUSTED??
Plug 'tpope/vim-rails'                   " Rails tools
Plug 'ecomba/vim-ruby-refactoring'       " TODO make some habits around this
Plug 'vim-ruby/vim-ruby'                 " Make ruby files FAST
Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'junegunn/vim-easy-align'           " Generic align script
Plug 'michaeljsmith/vim-indent-object'   " Select indents as an object
Plug 'roman/golden-ratio'                " Layout splits with golden ratio
Plug 'nelstrom/vim-textobj-rubyblock'    " Match ruby blocks
let g:golden_ratio_autocommand = 0
nnoremap <silent> <C-w>- :GoldenRatioResize<CR>
nnoremap <silent> <C-k> <C-w>k:GoldenRatioResize<CR>
nnoremap <silent> <C-j> <C-w>j:GoldenRatioResize<CR>
nnoremap <silent> <C-l> <C-w>l:GoldenRatioResize<CR>
nnoremap <silent> <C-h> <C-w>h:GoldenRatioResize<CR>
Plug 'scrooloose/nerdtree'               " File browser
let NERDTreeShowLineNumbers=1            " Make nerdtree honor numbers
autocmd FileType nerdtree setlocal number relativenumber
Plug 'tpope/vim-fugitive'                " Git integration, TODO adjust habbits
Plug 'mattn/gist-vim'                    " Create gists
Plug 'tpope/vim-surround'                " Delete, or insert around text objects
Plug 'altercation/vim-colors-solarized'  " Damn it looks good
Plug 'elzr/vim-json'                     " JSON
let g:vim_json_syntax_conceal = 0        " Don't hide quotes in json files
Plug 'dyng/ctrlsf.vim'                   " Grep alternative, uses the Silver Searcher
vmap <C-F> <Plug>CtrlSFVwordExec
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'ctrlpvim/ctrlp.vim'                " fuzzy search files, recent files, and buffers
Plug 'reedes/vim-lexical'                " spell-check and thesaurus/dictionary completion
Plug 'reedes/vim-wordy'                  " identify phrases for history of misuse, abuse, and overuse
Plug 'reedes/vim-textobj-sentence'       " sophisticated sentence text object
Plug 'reedes/vim-pencil'
let g:pencil#textwidth = 120
"autocmd FileType markdown,mkd call pencil#init()
"                          \ | call lexical#init()
"                          \ | call textobj#sentence#init()

nmap <leader><leader> <Plug>TogglePencil
call plug#end()

set relativenumber    " better navigation
set number            " give line number that you're on
set scrolloff=5       " when scrolling, keep cursor 5 lines away from border
set foldmethod=manual " Easier to manage this myself imho
set autoread          " When someone modifies a file externally, autoread it back in
set clipboard=unnamed " yank and paste to and from OS clipboard


""""""""""""""""""""""""""""""""""""""""
" Spelling and autocorrect

set spl=en spell       " Use English for spellchecking,
iabbrev waht what
iabbrev tehn then
iabbrev teh the
iabbrev hte the
iabbrev functino function
iabbrev iamge image

" spell checker automatically there for text and markdown
autocmd FileType markdown,text :set spell


""""""""""""""""""""""""""""""""""""""""
" Searching
set hlsearch           " Highlight my searches :)
set ignorecase         " Do case insensitive matching.
set smartcase          " Do smart case matching.
set incsearch          " Incremental search.
set magic              " Allows pattern matching with special characters

" search visual mode selection with //
vnoremap // y/<C-R>"<CR>

" Search mappings: center cursor on search
nnoremap N Nzz
nnoremap n nzz


""""""""""""""""""""""""""""""""""""""""
" Code
set expandtab          " Pressing tab inserts spaces
set autoindent         " indent on newlines
set smartindent        " recognise syntax of files
set colorcolumn=120    " Show 120th char visually

" Whitespace management
set tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype perl setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd Filetype go setlocal tabstop=4 softtabstop=4 shiftwidth=4 nolist


" Open files edits
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>zz :e $HOME/.zshrc<CR>

nnoremap H <C-o> " Browse code with back button
nnoremap L <C-i> " Browse code with forward button

" Colours
colorscheme solarized
set background=dark
set guifont=hack:h12

" Search [f]iles, [l]ines, [r]ecent files
nnoremap <leader>f :FZF<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>

" Filetype switcher
"use t to change filetype
nmap <leader>tt :set filetype=text<CR>
nmap <leader>tm :set filetype=markdown<CR>
nmap <leader>tp :set filetype=perl<CR>
nmap <leader>th :set filetype=eruby<CR>
nmap <leader>tr :set filetype=ruby<CR>
nmap <leader>ts :set filetype=sql<CR>
nmap <leader>tx :set filetype=xml<CR>
nmap <leader>tj :set filetype=javascript<CR>
nmap <leader>ts :set filetype=sass<CR>
nmap <leader>tl :set filetype=less<CR>
nmap <leader>tv :set filetype=vim<CR>

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
autocmd QuickFixCmdPost *grep* cwindow

" Shared data across nvim sessions
" '500  : save last 500 files local marks [a-z]
" f1    : also store global marks [A-Z0-9]
" <500  : store only 500 lines of registers
set shada='500,f1

" On git commit, position cursor at the top
autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"

" Quickopen and edit config files
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>vr :PlugUpdate<CR>
nnoremap <leader>zz :e $HOME/.zshrc<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <leader>aip)
nmap <leader>a <Plug>(EasyAlign)

" turn off EX mode (it annoys me, I don't use it)
":map Q <Nop>
" More usefully, reformat paragraphs with vim rules
" - http://alols.github.io/2012/11/07/writing-prose-with-vim
" - https://github.com/reedes/vim-pencil
map Q gqap

" Display line numbers in help
autocmd FileType help setlocal number relativenumber
