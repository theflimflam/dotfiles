# .zshrc configuration file
# Copyright (C) 2016 Matthew B. Gray
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Locale
export LANG=en_US
export LC_CTYPE=$LANG.UTF-8

# CD from anywhere
cdpath=(~ ~/Desktop ~/code/web ~/code ~/code/go/src ~/.config/nvim)

setopt CORRECT MULTIOS NO_HUP NO_CHECK_JOBS EXTENDED_GLOB

# History
export HISTSIZE=100000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE

# man zshoptions
setopt hist_ignore_all_dups # when running a command again, removes previous refs to it
setopt hist_save_no_dups    # kill duplicates on save
setopt hist_ignore_space    # prefixed with space doesn't store command
setopt hist_no_store        # don't store the command history in history
setopt hist_verify          # when using history expansion, reload history
setopt hist_reduce_blanks   # blanks from each command line added to the history list

setopt extended_history     # save timestamp and runtime information
setopt inc_append_history   # write after exec rather than waiting till shell exit
setopt no_hist_beep         # no terminal bell please
# setopt share_history      # all open shells see history

setopt interactivecomments # Dont execute comments in interactive shell

## Completion
setopt NO_BEEP AUTO_LIST AUTO_MENU
autoload -U compinit
compinit

# Bash-like navigation, http://stackoverflow.com/questions/10847255
autoload -U select-word-style
select-word-style bash

##############################################################################
# Misc tricks from
# http://chneukirchen.org/blog/archive/2013/03/10-fresh-zsh-tricks-you-may-not-know.html
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

function _recover_line_or_else() {
  if [[ -z $BUFFER && $CONTEXT = start && $zsh_eval_context = shfunc
      && -n $ZLE_LINE_ABORTED
      && $ZLE_LINE_ABORTED != $history[$((HISTCMD-1))] ]]; then
    LBUFFER+=$ZLE_LINE_ABORTED
    unset ZLE_LINE_ABORTED
  else
    zle .$WIDGET
  fi
}
zle -N up-line-or-history _recover_line_or_else
function _zle_line_finish() {
  ZLE_LINE_ABORTED=$BUFFER
}
zle -N zle-line-finish _zle_line_finish

# End tricks
##############################################################################

## Prompt
cur_git_branch() {
  # TODO maybe something like... git rev-parse --abbrev-ref HEAD 
  git branch --no-color 2>/dev/null|awk '/^\* ([^ ]*)/ {b=$2} END {if (b) {print "[" b "]"}}'
}

setopt PROMPT_SUBST

case $TERM in
  xterm*|rxvt*|screen|Apple_Terminal)
    # Remotes look different
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
      PROMPT=$(echo "%{\e]0;%n@%m: %~\a\e[%(?.32.31)m%}β %{\e[m%}")
    else
      PROMPT=$(echo "%{\e]0;%n@%m: %~\a\e[%(?.32.31)m%}λ %{\e[m%}")
    fi

    # Echo current process name in the xterm title bar
    preexec () {
      print -Pn "\e]0;$1\a"
    }
    ;;
  *)
    PROMPT="[%n@%m] %# "
    ;;
esac

RPROMPT=$(echo '$(cur_git_branch) %{\e[32m%}%3~ %{\e[m%}%U%T%u')

# Echo current process name in the xterm title bar
preexec () {
  print -Pn "\e]0;$1\a"
}

export LS_COLORS="exfxcxdxbxegedabagacad"
ZLS_COLORS=$LS_COLORS

# Aliases
alias ls='ls -G'                            # technicolour list
alias cdg='cd $(git rev-parse --show-cdup)' # cd to root of repo

export LESS='-R'

export GREP_COLOR='1;33'


# Checkout github pull requests locally
# https://gist.github.com/piscisaureus/3342247
function pullify() {
  git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/*'
}

function randommac() {
  ruby -e 'puts ("%02x"%((rand 64)*4|2))+(0..4).inject(""){|s,x|s+":%02x"%(rand 256)}'
}

# Default working directories per-box
alias pin="pwd > ~/.pindir"                   # pin cwd as pin dir
alias cdd='cd $(cat ~/.pindir 2&> /dev/null)' # cdd nav to pin dir
if [[ $(pwd) == $HOME ]]; then                # open pin dir on term open
  cdd
fi

# Conditionally load files
[ -e ~/.config/local/env ] && source ~/.config/local/env
[ -e ~/.zshrc_local ]      && source ~/.zshrc_local
[ -f ~/.fzf.zsh ]          && source ~/.fzf.zsh

function rehash() {
  source ~/.zshrc && stty sane
}

# Personal programs
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/code/go/bin:$PATH"
export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin/:$PATH"

export GOPATH="$HOME/code/go"

# Make ^Z toggle between ^Z and fg
# https://github.com/Julian/dotfiles/blob/master/.config/zsh/keybindings.zsh
function ctrlz() {
  if [[ $#BUFFER == 0 ]]; then
    fg >/dev/null 2>&1 && zle redisplay
  else
    zle push-input
  fi
}
zle -N ctrlz
bindkey '^Z' ctrlz

# Solarized cucumber workaround
export CUCUMBER_COLORS=comment=cyan

# Vim mode, god help me
# https://dougblack.io/words/zsh-vi-mode.html
bindkey -v
export KEYTIMEOUT=1
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

if which fzf-history-widget > /dev/null; then
  bindkey '^r' fzf-history-widget
else
  bindkey '^r' history-incremental-search-backward
fi

 # zle -N zle-line-init
 # zle -N zle-keymap-select
export KEYTIMEOUT=1

# Homebrew flub
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/*/bin:$PATH"

# Setting default editor
# if which nvim > /dev/null; then
#   export EDITOR=nvim
#   alias vim=nvim
# elif which vim > /dev/null; then
if which vim > /dev/null; then
  export EDITOR=vim
else
  export EDITOR=vi
fi

function friday() {
  cd ~/dotfiles
  make updates
}

function first() {
  git init
  git add .
  git commit -m "First!"
}

# OSX Cludges
if [[ `uname` == "Darwin" ]]; then
  # Fix GPG agent detection
  # see https://github.com/pstadler/keybase-gpg-github/issues/11
  GPG_TTY=$(tty)
  export GPG_TTY

  # Delete key fixup
  bindkey "^[[3~"  delete-char
  bindkey "^[3;5~" delete-char
fi

function backup() {
  restic backup . -r sftp:matthew.nz:restic-backup
}

# https://coderwall.com/p/s-2_nw/change-iterm2-color-profile-from-the-cli
it2prof() { echo -e "\033]50;SetProfile=$1\a" }

# hose things that match string
# e.g. fuck ruby
alias fuck='pkill -if'

# Set and remember iterm profile
alias dark='echo dark > ~/.config/iterm_theme && echo -e "\033]50;SetProfile=dark\a"'
alias light='echo light > ~/.config/iterm_theme && echo -e "\033]50;SetProfile=light\a"'
[ -e ~/.config/iterm_theme ] && echo -e "\033]50;SetProfile=$(cat ~/.config/iterm_theme)\a"

# Quickly put your work on top of master
alias rebase="git rebase origin/master --interactive"

# .envrc files contain secrets, if direnv exists export them on directory traversal
if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# If rbenv exists, init shims autocompletion
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
  export PATH="~/.rbenv/bin:$PATH"
fi

# # If chruby exists, init shims and hook cd
# if [ -f /usr/local/share/chruby/chruby.sh ]; then
#   source /usr/local/share/chruby/chruby.sh
#   source /usr/local/share/chruby/auto.sh
# fi

# If pyenv exists, init shims autocompletion
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
  pyenv rehash
fi

# Advice from
# brew cask install google-cloud-sdk
if which gcloud > /dev/null; then
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
fi

export LOCAL_IP=$(ipconfig getifaddr en0)
export HOSTNAME=$LOCAL_IP:3000
