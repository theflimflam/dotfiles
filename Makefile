# Copyright (c) 2020 Matthew B. Gray
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

DOTFILES="$(HOME)/dotfiles/etc"

default: updates

install: preflight env brew zsh-workaround softlinks updates
	# Remember to..."
	#
	# Colours git@github.com:deepsweet/Monokai-Soda-iTerm.git"
	# Setup font 'hack' in iterm"
	# Remove prompt Prefs > General > Confirm quit iterm 2"
	# Set scrollback to 100,000 lines"
	# Key repeat, Settings > Keyboard"
	# Remap Super-W, Settings > Keyboard > Shortcuts > App Shortcuts, +iterm, 'Close' Shift C-W"

# neovim:
# 	rm -rf ~/.config/nvim
# 	curl -fLo $(HOME)/.config/nvim/autoload/plug.vim --create-dirs \
# 	     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

softlinks:
	stow zsh
	stow task
	# stow nvim
	stow vim
	stow xmodmap
	stow ranger
	stow urxvt
	stow git
	stow i3
	stow home

env:
	rm -rf ~/.config/local
	cp -rv templates/.config/local ~/.config/local
	vim ~/.config/local/git_author
	vim ~/.config/local/env

updates: preflight
	vim -c 'call UpdateEverything() | qa' || true
	nvim -c 'call UpdateEverything() | qa' || true
	brew upgrade
	brew upgrade --cask
	brew cleanup || true
	brew doctor || true
	npm update -g
	sudo softwareupdate --install --all --restart

preflight:
	sudo echo "pre-prompting so you don't get bugged later"
	ssh-add -l && echo "reusing unlocked key" || ssh-add

brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle

# From https://stackoverflow.com/a/13785716
zsh-workaround:
	sudo chmod -R 755 /usr/local/share/zsh
	sudo chown -R root:staff /usr/local/share/zsh

unfuck-osx:
	# Turn off mouse acceleration http://osxdaily.com/2010/08/25/mouse-acceleration
	defaults write .GlobalPreferences com.apple.mouse.scaling -1

syncthing:
	# stable chan from https://apt.syncthing.net/
	curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
	echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
	sudo apt-get update
	sudo apt-get install syncthing
