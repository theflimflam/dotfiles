" .vimrc configuration file
" Copyright (C) 2013 Matthew B. Gray
"
" Permission is granted to copy, distribute and/or modify this document
" under the terms of the GNU Free Documentation License, Version 1.3
" or any later version published by the Free Software Foundation;
" with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
" A copy of the license is included in the section entitled "GNU
" Free Documentation License".

syntax enable       " enable syntax highlighting
set nocompatible    " be iMproved, required for vundle
filetype off        " required for vundle

"----------------------------------------
" Setting up Vundle, vim plugin manager
let iCanHazVundle=0
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let iCanHazVundle=1
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" General
Plugin 'jsflimflam/vim-unclutter'
Plugin 'jsflimflam/vim-common'
Plugin 'jsflimflam/vim-visible-whitespace'

" Productivity
Plugin 'matchit.zip'
Plugin 'fisadev/FixedTaskList.vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'tpope/vim-surround'
Plugin 'roman/golden-ratio'
let g:golden_ratio_autocommand = 0
nmap <silent> <C-w>- :GoldenRatioResize<CR>
Plugin 'vim-scripts/Align'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'YankRing.vim'

" Code
Plugin 'vim-scripts/jshint.vim'
Plugin 'scrooloose/syntastic'
let g:syntastic_javascript_checkers = ['jshint']
Plugin 'fatih/vim-go'

Plugin 'altercation/vim-colors-solarized'
Plugin 'claco/jasmine.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0 " Don't hide quotes in json files

if filereadable("/usr/bin/ctags-exuberant")
  " exuberant ctags fu
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-easytags'
  Plugin 'majutsushi/tagbar'

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

" Fuzzy finder
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = ',e'
nmap ,g :CtrlPBufTag<CR>
nmap ,G :CtrlPBufTagAll<CR>
nmap ,f :CtrlPLine<CR>
nmap ,m :CtrlPMRUFiles<CR>
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn)$',
  \ 'file': '\.pyc$\|\.pyo$|\.class$|\.min\..*\.js',
  \ }

call vundle#end()            " required
filetype plugin indent on    " required

" Assumes solarized is ready after vundle#end()
if ( has('gui_running'))
    colorscheme solarized
    set background=light
endif

" load my registers
if filereadable($HOME . '/.vimregisters')
    rviminfo! $HOME/.vimregisters
endif

" Source local configuration files if available
if filereadable($HOME . '/.vimrc.local')
    source $HOME/.vimrc.local
endif

" For vim stuff local to the host you're on
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

if iCanHazVundle == 1
    echo "Install plugins, reload vim"
    :BundleInstall
    :source $HOME/.vimrc
endif
