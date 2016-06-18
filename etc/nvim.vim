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

set relativenumber    " better navigation
set number            " give line number that you're on
set scrolloff=5       " when scrolling, keep cursor 5 lines away from border
set foldmethod=manual " Easier to manage this myself imho
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
nnoremap <leader>zz :e $HOME/.zshrc<CR>

call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go'
Plug 'junegunn/vim-easy-align'
" Plug 'michaeljsmith/vim-indent-object'
" Plug 'roman/golden-ratio'
" Plug 'scrooloose/nerdtree'
" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-surround'
" Plug 'dyng/ctrlsf.vim'
" Plug 'tpope/vim-rails'
" Plug 'nelstrom/vim-textobj-rubyblock' | Plug 'kana/vim-textobj-user'
" Plug 'rhysd/vim-textobj-ruby' | Plug 'kana/vim-textobj-user'
call plug#end()

"let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

"let g:golden_ratio_autocommand = 0
"nnoremap <silent> <C-w>- :GoldenRatioResize<CR>

" Open files edits
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>zz :e $HOME/.zshrc<CR>

nnoremap H <C-o> " Browse code with back button
nnoremap L <C-i> " Browse code with forward button
