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
cdpath=(~ ~/code ~/Desktop ~/code/go/src/github.com/wohyah ~/.config/nvim/plugged)

setopt CORRECT MULTIOS NO_HUP NO_CHECK_JOBS EXTENDED_GLOB

# History
export HISTSIZE=2000
export HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups # when running a command again, removes previous refs to it
setopt hist_save_no_dups    # kill duplicates on save
setopt hist_ignore_space    # prefixed with space doesn't store command

setopt hist_no_store      # don't store the command history in history
setopt hist_verify        # when using history expansion, reload history
setopt inc_append_history # write after exec rather than waiting till shell exit
setopt no_hist_beep       # no terminal bell please
# setopt share_history      # all open shells see history


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
  git branch --no-color 2>/dev/null|awk '/^\* ([^ ]*)/ {b=$2} END {if (b) {print "[" b "]"}}'
}

setopt PROMPT_SUBST
case $TERM in
  xterm*|rxvt*|screen|Apple_Terminal)
    # PROMPT=$(echo '%{\e]0;%n@%m: %~\a\e[%(?.32.31)m%}%# %{\e[m%}')
    PROMPT=$(echo '%{\e]0;%n@%m: %~\a\e[%(?.32.31)m%}λ %{\e[m%}')
    RPROMPT=$(echo '$(cur_git_branch) %{\e[32m%}%3~ %{\e[m%}%U%T%u')

    # Echo current process name in the xterm title bar
    preexec () {
      print -Pn "\e]0;$1\a"
    }
    ;;
  *)
    PROMPT="[%n@%m] %# "
    ;;
esac

export LS_COLORS="exfxcxdxbxegedabagacad"
ZLS_COLORS=$LS_COLORS

# Aliases
alias :q=exit                               # habbits ;-)
alias ls='ls -G'                            # technicolour list
alias cdg='cd $(git rev-parse --show-cdup)' # cd to root of repo

export LESS='-R'

export GREP_OPTIONS="--colour=auto --directories=skip"
export GREP_COLOR='1;33'


# https://gist.github.com/piscisaureus/3342247
function pullify() {
  git config --add remote.origin.fetch '+refs/pull/*/head:refs/remotes/origin/pr/*'
}

function randommac() {
  ruby -e 'puts ("%02x"%((rand 64)*4|2))+(0..4).inject(""){|s,x|s+":%02x"%(rand 256)}'
}

# TODO move this out into a condiontally loaded folder
# Pin, save a dir for later
alias pin="pwd > ~/.pindir"

# Quick nav to pin dir with cdd
function cdd() {
  if [ -e ~/.pindir ]; then
    export pind=$(cat ~/.pindir)
    cd "$pind"
  fi
}

# Start terminal in pinned directory
cdd

# Conditionally load files
[ -e ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.fzf.zsh ]     && source ~/.fzf.zsh


function rehash() {
  source ~/.zshrc
}

# If rbenv exists, init shims autocompletion
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi

# Ruby environment overrides system ruby
export PATH="~/.rbenv/bin:$PATH"

# Make the delete key do the right thing (OSX)
bindkey "^[[3~"  delete-char
bindkey "^[3;5~" delete-char

# Sometimes I do this, but it's _not_ the best for an interactive shell
# bindkey -v # Terminal vim mode
# bindkey '^R' history-incremental-search-backward

# Personal programs
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/script"
export PATH="$PATH:$HOME/code/go/bin"

export GOPATH="$HOME/code/go"

# Habits
if which nvim > /dev/null; then
  alias vim="echo 'nvim?'";
fi

# Taken from https://github.com/Julian/dotfiles/blob/master/.config/zsh/keybindings.zsh
# Make ^Z toggle between ^Z and fg
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

# Vi mode, god help me
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
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"