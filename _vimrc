" .vimrc configuration file
" Copyright (C) 2013 Matthew B. Gray
"
" Permission is granted to copy, distribute and/or modify this document
" under the terms of the GNU Free Documentation License, Version 1.3
" or any later version published by the Free Software Foundation;
" with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
" A copy of the license is included in the section entitled "GNU
" Free Documentation License".

" Create backup and history folders outside of the working dir
silent !mkdir -p ~/.vim/bak     > /dev/null 2>&1
silent !mkdir -p ~/.vim/swap    > /dev/null 2>&1
set directory=~/.vim/swap       " Put swap files here
set backupdir=~/.vim/bak        " Put backup files here

syntax enable                   " enable syntax highlighting
set autoindent                  " indent on newlines
set smartindent                 " recognise syntax of files
set tabstop=2                   " 2 spaces per tab
set softtabstop=2               " 2 spaces per tab
set shiftwidth=2                " 2 spaces per tab
set expandtab                   " Pressing tab inserts spaces
set nocompatible                " Necesary  for lots of cool vim things.
set showcmd                     " Show (partial) command in status line.
set showmatch                   " Show matching brackets.
set mat=2                       " ...but only blink the match for 200 ms
set ignorecase                  " Do case insensitive matching.
set smartcase                   " Do smart case matching.
set incsearch                   " Incremental search.
set autowrite                   " Automatically save before commands like :next and :make.
set hlsearch                    " Highlight my searches :)
set wildmenu                    " Cool tab completion stuff
set wildmode=list:longest,full  " Cool tab completion stuff
set backspace=2                 " Got backspace?
set nohidden                    " CLOSE THE BUFFER when you close the tab.
set autoread                    " When someone modifies a file externally, autoread it back in
set magic                       " Allows pattern matching with special characters
set pastetoggle=<F9>            " Paste Mode! Dang!

" turn off EX mode (it annoys me, I don't use it)
" reuse it for shuffling paragraphs
" - http://alols.github.io/2012/11/07/writing-prose-with-vim/
":map Q <Nop>
:map Q gqap

" I like screen realestate
set guifont=monospace\ 9

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Fold configuration, manual and toggle with space
set foldmethod=manual
nnoremap <space> za
vnoremap <space> zf

" allow plugins by file type
filetype plugin on
filetype indent on

" save as sudo
ca w!! w !sudo tee "%"

" Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" simple recursive grep
command! -nargs=1 RecurGrep lvimgrep /<args>/gj ./**/*.* | lopen | set nowrap
command! -nargs=1 RecurGrepFast silent exec 'lgrep! <q-args> ./**/*.*' | lopen
nmap ,R :RecurGrep
nmap ,r :RecurGrepFast
nmap ,wR :RecurGrep <cword><CR>
nmap ,wr :RecurGrepFast <cword><CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Autocomplete fu
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete

" tablength exceptions
" setup rules to switch from 2, 4 and 8 spaces per filetype
"autocmd FileType html setlocal shiftwidth=2 tabstop=2
"autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
"autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" Filetype switcher
"use ,t to change filetype
:map ,tm :set filetype=mason<CR>
:map ,th :set filetype=html<CR>
:map ,tp :set filetype=perl<CR>
:map ,tr :set filetype=ruby<CR>
:map ,ts :set filetype=sql<CR>
:map ,tj :set filetype=javascript<CR>
:map ,ts :set filetype=sass<CR>
:map ,tl :set filetype=less<CR>
:map ,tv :set filetype=vim<CR>

" Spellcheck fu
if version >= 700
    " Use english for spellchecking,
    set spl=en spell
    " don't spellcheck by default
    set nospell
    " bind \s to spellcheck
    map <Leader>s <Esc>:!aspell -c --dont-backup "%"<CR>:e! "%"<CR><CR>
endif

" load my registers
if filereadable($HOME . '/.vimregisters')
    rviminfo! $HOME/.vimregisters
endif

" Source local configuration files if available
if filereadable($HOME . '/.vimrc.local')
    source $HOME/.vimrc.local
endif

" Fost level vim sessions on this host
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" Autojump to last position VIM was at when opening a file.
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"----------------------------------------
" Setting up Vundle, vim plugin manager
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let iCanHazVundle=0
endif

" required for vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"----------------------------------------
" Vundle plugins
Bundle 'vundle'

" Productivity
Plugin 'matchit.zip'
Plugin 'fisadev/FixedTaskList.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'tpope/vim-surround'
Plugin 'roman/golden-ratio'
Plugin 'vim-scripts/Align'
Plugin 'Shougo/neocomplcache'
let g:neocomplcache_enable_smart_case = 1
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
" Yank history navigation
Plugin 'YankRing.vim'
Plugin 'szw/vim-ctrlspace'

" Tidy code
Plugin 'michalliu/sourcebeautify.vim'
Plugin 'vim-scripts/jshint.vim'
Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['jshint']
Plugin 'maksimr/vim-jsbeautify'

" Vim syntax
Plugin 'altercation/vim-colors-solarized'
Plugin 'claco/jasmine.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'
Plugin 'michalliu/jsruntime.vim'
Plugin 'michalliu/jsoncodecs.vim'

"if ( has('gui_running'))
  Plugin 'takac/vim-fontmanager'
"endif

if filereadable("/usr/bin/ctags-exuberant")
  " Also worth looking into this...
  "    https://valloric.github.io/YouCompleteMe/
  "    has fuzzy matching

  " exuberant ctags fu
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-easytags'
  Plugin 'majutsushi/tagbar'

  " Checking out... requires jsctags ???
  " npm install jsctags
  Plugin 'int3/vim-taglist-plus'

  " toggle Tagbar display
  map <F4> :TagbarToggle<CR>
  " autofocus on Tagbar open
  let g:tagbar_autofocus = 1
endif

if filereadable("/usr/bin/git")
  Plugin 'tpope/vim-fugitive'
  Plugin 'mattn/gist-vim'
endif

if filereadable("/usr/bin/npm")
  " If we've got npm, I'm going to assume there's node
  " node means fuzzy completion in node
  echom system('cd $HOME/.vim/bundle/tern_for_vim && npm install')
  Plugin 'marijnh/tern_for_vim'
endif

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"----------------------------------------
" plugin configuration

" Don't change working directory
let g:ctrlp_working_path_mode = 0
" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$|\.class$|\.min\..*\.js',
  \ }

" CtrlP (new fuzzy finder)
let g:ctrlp_map = ',e'
nmap ,g :CtrlPBufTag<CR>
nmap ,G :CtrlPBufTagAll<CR>
nmap ,f :CtrlPLine<CR>
nmap ,m :CtrlPMRUFiles<CR>

" Fuzzy command finder (vim internals)
nmap ,c :CtrlPCmdPalette<CR>

" roman/golden-ratio // Golden Ratio config
let g:golden_ratio_autocommand = 0
nmap <silent> <C-w>- :GoldenRatioResize<CR>

" mattn/emmet-vim // zen codin config
let g:user_emmet_mode='a'         " enable all function in all mode.
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall

" elzr/vim-json // json config
let g:vim_json_syntax_conceal = 0  " Don't hide quotes in json files

" altercation/vim-colors-solarized // Colours in vim
"if filereadable(expand("~/.vim/bundle/vim-colors-solarized/README.mkd")
  if ( has('gui_running'))
    set nu " <-- line numbers
    syntax enable
    set background=dark
    colorscheme solarized
  else
    syntax enable
    let g:solarized_termcolors=256
    colorscheme solarized
    set background=dark
  endif
"endif

"----------------------------------------
" Swap splits around
" TODO try Bundle 'wesQ3/vim-windowswap'
" ctrl + w, m to mark a split
" ctrl + w, p to swap a split with the one selected
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction
nmap <silent> <C-w>m :call MarkWindowSwap()<CR>
nmap <silent> <C-w>p :call DoWindowSwap()<CR>
