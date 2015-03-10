# ~/.bashrc: executed by bash(1) for non-login shells.

# .bashrc configuration file
# Copyright (C) 2015 Matthew B. Gray
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

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend

# Make terminal vi mode
#set -o vi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTCONTROL=ignoredups
HISTTIMEFORMAT='%Y-%m-%d, %H:%M: '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls -h --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias vim='vim -p'
alias svim='sudo vim -p -u ~mbgray/.vimrc'

alias n='echo YES!'
alias y='echo NO!'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Some stuff I use a little bit
alias rehash='source /etc/profile && source ~/.bashrc'
alias h='history'

COLOR_RESET="\[\033[00m\]"
COLOR_BRI_GREEN="\[\033[01;32m\]"
COLOR_BLUE="\[\033[0;34m\]"
COLOR_BRI_BLUE="\[\033[1;34m\]"
COLOR_BRI_CYAN="\[\033[0;32m\]"
COLOR_RED="\[\033[0;31m\]"
COLOR_BRI_RED="\[\033[1;31m\]"
COLOR_YELLOW="\[\033[1;33m\]"
COLOR_BRI_GRAY="\[\033[0;37m\]"
COLOR_WHITE="\[\033[1;37m\]"
COLOR_NO_COLOUR="\[\033[0m\]"
COLOR_PURPLE="\[\033[0;535m\]"
COLOR_BRI_PURPLE="\[\033[1;35m\]"

BASHRC_OLD_PWD=
export PROMPT_COMMAND=__bashrc_promptcommand

__bashrc_promptcommand() {
    __bashrc_autoreload
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"

    if [ "${BASHRC_OLD_PWD}" != "${PWD}" ];then
        BASHRC_OLD_GIT_DIR=$BASHRC_GIT_DIR
        BASHRC_OLD_GIT_BRANCH=
        __bashrc_detect_git

        if [ -n "$BASHRC_GIT_DIR" ]; then
            BASHRC_GIT_DIR_BASENAME=`basename $BASHRC_GIT_DIR`
            CDPATH=".:$BASHRC_GIT_DIR"
        else
            BASHRC_GIT_DIR_BASENAME=
            CDPATH=
            PS1='\[\033[01;32m\]\u@\h($SHLVL)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
            #PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[00m\]\$'
        fi

        BASHRC_OLD_PWD=$PWD
    fi

    if [ -n "$BASHRC_GIT_DIR" ]; then
        # set prompt to branch
        BASHRC_GIT_BRANCH=`cat ${BASHRC_GIT_DIR}.git/HEAD`

        if [ "${BASHRC_GIT_BRANCH:0:4}" == "ref:" ];then
            # Grab named git branch
            BASHRC_GIT_BRANCH=${BASHRC_GIT_BRANCH:16}
        else
            # Otherwise, get the first 8 chars in this checked out hash
            BASHRC_GIT_BRANCH=${BASHRC_GIT_BRANCH:0:8}
        fi


        if [ "$BASHRC_GIT_BRANCH" != "$BASHRC_OLD_GIT_BRANCH" ];then
            PS1="${COLOR_BRI_GREEN}\u@\h(${COLOR_BRI_RED}${BASHRC_GIT_BRANCH}${COLOR_BRI_GREEN})${COLOR_RESET}:${COLOR_BRI_BLUE}\w${COLOR_RESET}\$ "
            BASHRC_OLD_GIT_BRANCH=$BASHRC_GIT_BRANCH
        fi
    fi
}

__bashrc_detect_git() {
    BASHRC_GIT_DIR=$(git rev-parse --show-cdup 2>/dev/null || echo ////);

    if [ "$BASHRC_GIT_DIR" = "////" ];then
        BASHRC_GIT_DIR=
    else
        if [ -n "$BASHRC_GIT_DIR" ];then
            BASHRC_GIT_DIR=$(cd $BASHRC_GIT_DIR; echo "$PWD/")
            if [ -d "$BASHRC_GIT_DIR" ]; then
                return
            fi
            #echo "BASHRC_GIT_DIR set to $BASHRC_GIT_DIR"

            BASHRC_GIT_DIR=
        else
            BASHRC_GIT_DIR="$PWD/"
        fi
    fi
}

__bashrc_autoreload() {
    for rcfile in .bashrc .bashrc.local; do
        if [ ! -f ${HOME}/${rcfile}.timestamp ]; then
            touch ${HOME}/${rcfile}.timestamp
            source ${HOME}/${rcfile}
        fi
        if [ ${HOME}/${rcfile}.timestamp -ot ${HOME}/${rcfile} ]; then
            touch ${HOME}/${rcfile}.timestamp
            source ${HOME}/${rcfile}
        fi
    done
}

## Set default directory to open when you open a shell on this machine
#pin() {
#    PROJ=$(pwd)
#    grep 'cd' ~
#    echo "# Updated at" $(date)       > ~/.bashrc.project
#    echo "cd '${PROJ}'"              >> ~/.bashrc.project
#    echo "alias ch=\"cd '${PROJ}'\"" >> ~/.bashrc.project
#
#    echo "I've setup ~/.bashrc.project for you.";
#    echo "--------------------------------------------------------------------------------";
#    cat ~/.bashrc.project
#    echo "--------------------------------------------------------------------------------";
#
#    echo "\" WARNING, managed by pin"  > ~/.vimrc.local
#    echo "\" Updated at" $(date)      >> ~/.vimrc.local
#    echo "chdir ${PROJ}"              >> ~/.vimrc.local
#
#    echo "I've setup ~/.vimrc.local for you.";
#    echo "--------------------------------------------------------------------------------";
#    cat ~/.vimrc.local
#    echo "--------------------------------------------------------------------------------";
#}

rebaseall() {
    currentBranch=$(git branch --no-color | grep '*' | sed 's/\*//g');

    for branch in $(git branch --no-color | sed 's/\*//g'); do
        git checkout $branch;
        git rebase origin/master --interactive;
    done

    git checkout ${currentBranch};
}

# This is for machines where there are local environment variables
if [ -f ${HOME}/.bashrc.local ];
    then source ${HOME}/.bashrc.local
fi
# Open pinned directories if there are any
if [ -f ${HOME}/.bashrc.project ];
    then source ${HOME}/.bashrc.project
fi

# My Crap
export LC_ALL=en_NZ.utf-8
export LANG="$LC_ALL"

export EDITOR="vim"

# This stuff used for installing CPAN modules
export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
export PERL_MB_OPT="--install_base $HOME/perl5";
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
export PERL5LIB="$HOME/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:$HOME/perl5/lib/perl5:$PERL5LIB";
export PATH="$HOME/bin:$PATH";

# Git environment variables
export GIT_AUTHOR_NAME="Matthew B. Gray"
export GIT_COMMITTER_NAME="Matthew B. Gray"
export GIT_AUTHOR_EMAIL="matthew.gray@catalyst.net.nz"
export EMAIL="matthew.gray@catalyst.net.nz"
export DEBEMAIL="matthew.gray@catalyst.net.nz"

# Default browser
export BROWSER=/usr/bin/chromium

# Some werid thing for app.js used when configuring in npm
export PKG_CONFIG_PATH=/usr/bin/pkg-config

# Pin, save a dir for later
if [ -e ${HOME}/.pindir ]; then
  cd $(cat ${HOME}/.pindir)
fi
alias pin="pwd > ${HOME}/.pindir"

