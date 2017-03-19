DOTFILES="$(HOME)/dotfiles/etc"

all: clean prep link

clean:
	rm -rf ~/.config/nvim

prep:
	curl -fLo $(HOME)/.config/nvim/autoload/plug.vim --create-dirs \
	     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

link:
	stow zsh
	stow task
	stow nvim
	stow xmodmap

mac-updates:
	sudo softwareupdate --install --all
	brew upgrade
	brew cleanup
	brew prune
	brew doctor
