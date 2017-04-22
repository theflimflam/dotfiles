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

let mapleader = "\<tab>"
"let mapleader = ","


call plug#begin('~/.config/nvim/plugged')
Plug 'git@github.com:wohyah/vim-unclutter.git'
Plug 'git@github.com:wohyah/vim-visible-whitespace.git'
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
Plug 'rakr/vim-one'                      " Like Atom
Plug 'sickill/vim-monokai'               " Like Sublime
Plug 'elzr/vim-json'                     " JSON
Plug 'kchmck/vim-coffee-script'          " Syntax for coffeescript
let g:vim_json_syntax_conceal = 0        " Don't hide quotes in JSON files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'ctrlpvim/ctrlp.vim'                " Fuzzy search files, recent files, and buffers
Plug 'reedes/vim-lexical'                " Spell-check and thesaurus/dictionary completion
Plug 'reedes/vim-wordy'                  " Identify phrases for history of misuse, abuse, and overuse
Plug 'reedes/vim-textobj-sentence'       " Sophisticated sentence text object
Plug 'tpope/vim-commentary'              " Toggle comments on lines
Plug 'reedes/vim-pencil'
Plug 'othree/eregex.vim'                 " PCRE engine for VIM
nnoremap / :M/
nnoremap ,/ /
let g:pencil#textwidth = 120
"autocmd FileType markdown,mkd call pencil#init()
"                          \ | call lexical#init()
"                          \ | call textobj#sentence#init()

call plug#end()

set relativenumber    " better navigation
set number            " give line number that you're on
set scrolloff=5       " when scrolling, keep cursor 5 lines away from border
set foldmethod=manual " Fold by indent level
set autoread          " When someone modifies a file externally, autoread it back in


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

" Search visual mode selection with *
vnoremap * y/<C-R>"<CR>

" Search mappings: center cursor when jumping in search
nnoremap N Nzz
nnoremap n nzz


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
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <leader>aip)
nmap <leader>a <Plug>(EasyAlign)

" Quickly open rc files
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>zz :e $HOME/.zshrc<CR>

nnoremap H <C-o> " Browse code like you're using vimium back button
nnoremap L <C-i> " Browse code like you're using vimium forward button

" Colours
try
  " silent colorscheme solarized
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

" Remap CTRL F to
vnoremap * y/<C-R>"<CR>
nmap <C-F> "zyiw:Ggrep <C-R>z
vmap <C-F> y:Ggrep "<C-R>""<CR>

" Shared data across nvim sessions
" '500  : save last 500 files local marks [a-z]
" f1    : also store global marks [A-Z0-9]
" <500  : store only 500 lines of registers
set shada='500,f1

" EXCEPTION, cursor placement at top on git commit
autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"

" Quickly open, reload and edit rc files
nnoremap <leader>vv :e $MYVIMRC<CR>
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
autocmd FileType gitcommit nnoremap @@ O<ESC>!!btil<CR>A<SPACE>

" Vertical split for help files
" autocmd FileType help wincmd L

set splitright
" set splitbelow

" jj is like escape
inoremap jj <ESC>

" Copy current file to clipboard
nmap <leader>cf :let @*=expand("%")<CR>
" nmap <leader>cl :let @*=expand("%")<CR>

function! ProseMode()
  let window_width = winwidth('%')
  let gutter       = 10 " avoid foldcolumn complaints
  let page_width   = window_width - (gutter * 2)

  if (page_width > 100)
    let page_width = 100
  endif

  exe printf('set textwidth=%.f', page_width - 1)
  exe printf('set colorcolumn=%.f', page_width)
  exe printf('set foldcolumn=%.f', gutter)
  set norelativenumber nonumber spell
endfunction

nmap <leader><leader> :call ProseMode()
