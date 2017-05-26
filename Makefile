DOTFILES="$(HOME)/dotfiles/etc"

default: run-updates

install: reset-vim-plugins softlink-dotfiles run-updates

reset-vim-plugins:
	rm -rf ~/.config/nvim
	curl -fLo $(HOME)/.config/nvim/autoload/plug.vim --create-dirs \
	     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

softlink-dotfiles:
	stow zsh
	stow task
	stow nvim
	stow xmodmap
	stow ranger

run-updates:
	sudo softwareupdate --install --all
	brew upgrade
	brew cleanup
	brew prune
	brew doctor

brew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew install git tig neovim aspell gnupg go rbenv task
	brew install md5sha1sum mtr ncdu zsh tor htop iftop
	brew install stow ranger tree unrar watch rename
	brew install mplayer syncthing wget
	brew cask install caffeine docker firefox flux
	brew cask install gimp google-chrome hyper iterm2
	brew cask install keepassx libreoffice skype
	brew cask install vlc spotify transmission tunnelblick

unfuck-osx:
	# Turn off mouse acceleration http://osxdaily.com/2010/08/25/mouse-acceleration
	defaults write .GlobalPreferences com.apple.mouse.scaling -1

syncthing:
	# stable chan from https://apt.syncthing.net/
	curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
	echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
	sudo apt-get update
	sudo apt-get install syncthing
