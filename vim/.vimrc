" .config/nvim/init.vim configuration file
" Copyright (C) 2018 Matthew B. Gray
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

syntax enable       " enable syntax highlighting
set nocompatible    " be iMproved, required for vundle
filetype off        " required for vundle

"----------------------------------------
" Setting up Vundle, vim plugin manager
let plug_executable=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_executable)
    echo "Installing plug"
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'git@github.com:heymatthew/vim-unclutter.git'
Plug 'git@github.com:heymatthew/vim-visible-whitespace.git'
Plug 'git@github.com:heymatthew/vim-prose.git'
Plug 'antoyo/vim-licenses'               " Help with open source licences
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " Golang tools
Plug 'jalvesaq/Nvim-R'                   " R lang
Plug 'rhysd/vim-textobj-ruby'            " Ruby text objects
Plug 'tpope/vim-rails'                   " Rails tools
Plug 'ecomba/vim-ruby-refactoring'       " TODO make some habits around this
Plug 'vim-ruby/vim-ruby'                 " Make ruby files FAST
Plug 'airblade/vim-gitgutter'            " Figure out what's changed in Git
Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'godlygeek/tabular'                 " Align stuff
Plug 'michaeljsmith/vim-indent-object'   " Select indents as an object
Plug 'roman/golden-ratio'                " Layout splits with golden ratio
let g:golden_ratio_autocommand = 1
nnoremap <silent> <C-w>- :GoldenRatioResize<CR>:GoldenRatioResize<CR>
Plug 'pangloss/vim-javascript'           " Better Javascript highlighting
Plug 'posva/vim-vue'                     " Vue syntax highlighting
" Plug 'vim-syntastic/syntastic'           " Generic linter
Plug 'w0rp/ale'                          " more linting
let g:ale_set_highlights = 0             " remove highlights
let g:ale_set_loclist = 0                " prefer quickfix list to location list
let g:ale_set_quickfix = 0
Plug 'vim-scripts/LargeFile'             " turn off slow stuff in files > 20mb
Plug 'scrooloose/nerdtree'               " File browser
let NERDTreeShowLineNumbers = 1          " Make nerdtree honor numbers
let NERDTreeShowHidden = 1               " Show dotfiles
autocmd FileType nerdtree setlocal number relativenumber
Plug 'tpope/vim-fugitive'                " Git integration, TODO adjust habits
Plug 'mattn/gist-vim'                    " Create gists
Plug 'tpope/vim-surround'                " Delete, or insert around text objects
Plug 'altercation/vim-colors-solarized'  " n.b. you need to change terminal colours too
" Plug 'rakr/vim-one'                      " Like Atom
" Plug 'sickirl/vim-monokai'               " Like Sublime
Plug 't9md/vim-textmanip'                " Move highlighted text around with arrow keys
let g:textmanip_startup_mode = "insert"
xmap <up>    <Plug>(textmanip-move-up)
xmap <down>  <Plug>(textmanip-move-down)
xmap <left>  <Plug>(textmanip-move-left)
xmap <right> <Plug>(textmanip-move-right)
Plug 'elzr/vim-json'                     " JSON
Plug 'kchmck/vim-coffee-script'          " Syntax for coffeescript
Plug 'keith/swift.vim'                   " Syntax for swift
let g:vim_json_syntax_conceal = 0        " Don't hide quotes in JSON files
Plug 'junegunn/fzf', { 'dir': '~/code/fzf', 'do': 'yes \| ./install' }
Plug 'ctrlpvim/ctrlp.vim'                " Fuzzy search files, recent files, and buffers
Plug 'reedes/vim-lexical'                " Spell-check and thesaurus/dictionary completion
Plug 'reedes/vim-wordy'                  " Identify phrases for history of misuse, abuse, and overuse
Plug 'reedes/vim-textobj-sentence'       " Sophisticated sentence text object
Plug 'tpope/vim-commentary'              " Toggle comments on lines
Plug 'tpope/vim-unimpaired'              " <3 pairings that marry ] and ['s REALLY GOOD, 5 stars
Plug 'reedes/vim-pencil'
Plug 'haya14busa/incsearch.vim'          " incremental search tool
let g:incsearch#auto_nohlsearch = 1
Plug 'bronson/vim-visual-star-search'    " Vim multiline search
Plug 'hashivim/vim-terraform'            " Terraform integration and support
let g:terraform_align=1
let g:terraform_fmt_on_save=1
Plug 'othree/eregex.vim'                 " PCRE engine for VIM
Plug 'vim-scripts/buffet.vim'            " Interacive buffer navigation
Plug 'plasticboy/vim-markdown'           " Better markdown support
let g:vim_markdown_folding_disabled = 1
nnoremap / :M/
nnoremap <leader>/ /
let g:pencil#textwidth = 120
"autocmd FileType markdown,mkd call pencil#init()
"                          \ | call lexical#init()
"                          \ | call textobj#sentence#init()

Plug 'Asheq/close-buffers.vim'           " :CloseHiddenBuffers clears things you're not using

call plug#end()

" Look and Feel
try
  " don't explode if colour scheme doesn't exist
  syntax on
  colorscheme solarized
  set background=light
  " from system_profiler SPFontsDataType
  set guifont=mplus-1m-regular:h12
  set colorcolumn=120    " Show 120th char visually (looks ugly without colours)

  if filereadable($HOME . "/.config/iterm_theme")
      let iterm_theme = readfile($HOME . "/.config/iterm_theme")
      if len(iterm_theme) > 0
        exe "set background=" . iterm_theme[0]
      endif
  endif
catch
  " If colors and fonts fail, this isn't a big deal
endtry

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

" Source local configuration files if available
if filereadable($HOME . '/.vimrc.local')
    source $HOME/.vimrc.local
endif

" Per repo custom commands
let git_vimrc = getcwd() . '/.git/vimrc'
if filereadable(git_vimrc)
    exe 'source ' . git_vimrc
endif

" For vim stuff local to the host you're on
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif

" Create backup and history folders outside of the working dir
silent !mkdir -p ~/.vim/bak     > /dev/null 2>&1
silent !mkdir -p ~/.vim/swap    > /dev/null 2>&1
set directory=~/.vim/swap       " Put swap files here
set backupdir=~/.vim/bak        " Put backup files here

set relativenumber        " better navigation
set number                " give line number that you're on
set scrolloff=5           " when scrolling, keep cursor 5 lines away from border
set foldmethod=manual     " Fold by indent level
set autoread              " When someone modifies a file externally, autoread it back in
" set textwidth=120         " Line length should be ~120 chars #modern
set ruler                 " Show cursor x,y and % of document viewed
set mouse=a               " Lets you scroll and interact with the mouse

""""""""""""""""""""""""""""""""""""""""
" Searching and cursor position
set hlsearch           " Highlight my searches :)
set ignorecase         " Do case insensitive matching.
set smartcase          " Do smart case matching.
set incsearch          " Incremental search.
set magic              " Allows pattern matching with special characters
nnoremap N Nzz
nnoremap n nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

""""""""""""""""""""""""""""""""""""""""
" Spelling and autocorrect
set spl=en spell       " Use English for spellchecking,
set nojoinspaces       " Single space after period when using J
iabbrev waht what
iabbrev tehn then
iabbrev teh the
iabbrev hte the
iabbrev functino function
iabbrev iamge image
iabbrev wehn when
" spell checker automatically there for git commit messages
autocmd BufReadPost COMMIT_EDITMSG exe "set spell"
nnoremap <leader>s :set spell!<CR>
set nospell
nnoremap <leader>s :setlocal spell!<cr>

""""""""""""""""""""""""""""""""""""""""
" Code
set expandtab          " Pressing tab inserts spaces
set autoindent         " indent on newlines
set smartindent        " recognise syntax of files

" turn off matching brackets
set noshowmatch
let g:loaded_matchparen=1


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
nnoremap <leader>ii :e $HOME/.config/local/env<CR>

nnoremap H <C-o> " Browse code like you're using vimium back button
nnoremap L <C-i> " Browse code like you're using vimium forward button

" Quickfix window when shelling out to grep
" Also works for Git grep
"   e.g. :Ggrep FIXME
"   see https://github.com/tpope/vim-fugitive
" autocmd QuickFixCmdPost *grep* cwindow
"
" Also http://stackoverflow.com/a/39010855/81271
" automatically open the location/quickfix window after :make, :grep, :lvimgrep and friends if there are valid locations/errors
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" Quickfix horizontal
" https://stackoverflow.com/a/16743676
autocmd FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

" Select and hitting * does a serach for the full string
vnoremap * y/<C-R>"<CR>

" Search [f]iles, [l]ines, [r]ecent files
nnoremap <leader>f :FZF<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|tmp)$',
  \ 'file': '\.pyc$\|\.pyo$|\.class$|\.min\..*\.js',
  \ }

" TODO file a bug for this, double escape repeats this command over and over
" nnoremap <C-[> :hello

" " find/search, save current
" vmap <C-f> y:cclose<CR>:vsplit<CR>:GoldenRatioResize<CR>:silent Ggrep -I "<C-r>0"<CR>zz
" nmap <C-f> yiw:cclose<CR>:vsplit<CR>:GoldenRatioResize<CR>:silent Ggrep -I "<C-r>0"<CR>zz

" find/search, save current
" vmap <C-f> y:cclose<CR>:vsplit<CR>:silent Ggrep -I "<C-r>0"<CR>zz
" nmap <C-f> yiw:cclose<CR>:vsplit<CR>:silent Ggrep -I "<C-r>0"<CR>zz

" TODO make this a plugin
" find/search, save current
function! Find()
  " Copy thing we're searching for to variable
  normal yiw
  let thing = '"' . @0 . '"'

  " Close all windows to the right
  try
    while 1
      exe("+q")
    endwhile
  catch
    " bail on fail baby
  endtry

  " Search and open results in location list
  exe('silent Ggrep -I '.thing)

  " Center
  normal zz
  " exe("GoldenRatioResize")
endfunction

" Open window in new tab, split and search
" TODO Detect :Ggrep, fall back on :grep
vmap <C-f> y:silent Ggrep -I "<C-r>0"<CR>zz
nmap <C-f> :call Find()<CR>

" Shared data across nvim sessions
" '500  : save last 500 files local marks [a-z]
" f1    : also store global marks [A-Z0-9]
" <500  : store only 500 lines of registers
" set shada='500,f1

" Vim autojump to last position VIM was at when opening a file.
" See --> http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"
" Tell vim to remember certain things when we exit
" '10  :  marks will be remembered for up to 10 previously edited files
" "100 :  will save up to 100 lines for each register
" :20  :  up to 20 lines of command-line history will be remembered
" %    :  saves and restores the buffer list
" n... :  where to save the viminfo files
"set viminfo='10,\"100,:20,%,n~/.vim/info
set viminfo='10,\"100,:20,n~/.vim/info

" EXCEPTION, cursor placement at top on git commit
autocmd BufReadPost COMMIT_EDITMSG exe "normal! gg"

" Quickly open, reload and edit rc files
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>vrr :source $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>:PlugUpdate<CR>:source $MYVIMRC<CR>:GoInstallBinaries<CR>
nnoremap <leader>zz :e $HOME/.zshrc<CR>

function! UpdateEverything()
  exe('source ' . $MYVIMRC)
  rxe('PlugUpdate')
  exe('source ' . $MYVIMRC)
  exe('GoInstallBinaries')
endfunction

" Change syntax highlighting in the current file
nnoremap <leader>t :set filetype=

" turn off EX mode (it annoys me, I don't use it)
":map Q <Nop>
" More usefully, reformat paragraphs with vim rules
" - http://alols.github.io/2012/11/07/writing-prose-with-vim
" - https://github.com/reedes/vim-pencil
map Q gqap
nnoremap <silent> <C-q> :CloseBuffersMenu<CR>

" Display line numbers in help
autocmd FileType help setlocal number relativenumber

" Insert current branch name and put cursor to the end of the line
" Uses upper case motion found here https://stackoverflow.com/a/2285278/81271
autocmd FileType gitcommit nnoremap T O<ESC>:.!git rev-parse --abbrev-ref HEAD<CR>0g~iwf-;C 

" Vertical split for help files
" autocmd FileType help wincmd L

" Split things to the right (makes sense to my brain, I read right to left)
set splitright
" set splitbelow

" Copy current file to clipboard
nnoremap <leader>cf :let @*=expand("%")<CR>

" Open current focused file in new tab
nnoremap <leader><leader> :tab split<CR>

" Close current splits, drop back to previous tab
nnoremap <backspace><backspace> :tabclose<CR>

" from https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" Open file browser in the directory of the current file
nnoremap <space><space> :edit %:p:h<CR>

" Open git status
nnoremap <leader>g :Gstatus<CR>

" Quickly split current view along x or y, or close the split with q
nmap <leader>y :lclose<CR>:cclose<cr>:split<cr>
nmap <leader>x :lclose<CR>:cclose<cr>:vsplit<cr>
nmap <leader>n :lclose<CR>:cclose<cr><C-w>n
nmap <leader>q <C-w>q

" Search [f]iles, [l]ines, [r]ecent files
nnoremap <leader>f :FZF<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|tmp)$',
  \ 'file': '\.pyc$\|\.pyo$|\.class$|\.min\..*\.js',
  \ }

" Ctrl + w actions in terminal windows
" tnoremap <C-w> <C-\><C-N><C-w>

" Terminal double Escape and jj leave insert mode
" tnoremap <ESC><ESC> <C-\><C-N>

" autocmd TermOpen,BufWinEnter,WinEnter term://* startinsert
" autocmd BufLeave                      term://* stopinsert
" autocmd TermOpen * setlocal statusline=%{b:term_title}

""""""""""""""""""""""""""""""""""""""""
" Golang workflow
autocmd Filetype go nnoremap <buffer> R  :GoRun %<CR>
autocmd Filetype go nnoremap <buffer> TT :w<CR>:GoAlternate<CR>
autocmd Filetype go nnoremap <buffer> T  :GoTest<CR>
let g:go_template_autocreate = 0
let g:go_fmt_command = "goimports"

""""""""""""""""""""""""""""""""""""""""
" Ruby workflow
autocmd FileType ruby compiler rspec
autocmd FileType ruby nnoremap <buffer> T :call RSpec()<CR>
function! RSpec()
  let specfile = expand("%")

  " Correct for non spec files
  if specfile !~ "_spec.rb$"
    let specfile = substitute(specfile,'.*/','**/','g')
    let specfile = substitute(specfile,'.rb$','_spec.rb','g')
  endif

  " Return spec file matcher
  exec("silent make " . specfile)
endfunction

" Set title on terminal to focused buffer filename
auto BufEnter * :set title | let &titlestring = 'v:' . expand('%')

" w!! saves as sudo
cmap w!! w !sudo tee > /dev/null %

" Modfiy licence copyright to be author based
let git_user = systemlist("git config user.name")

if $EMPLOYER != ""
  let g:licenses_copyright_holders_name = $EMPLOYER
elseif len(git_user) > 0
  let g:licenses_copyright_holders_name = git_user[0]
else
  let g:licenses_copyright_holders_name = "Matthew B. Gray"
endif
