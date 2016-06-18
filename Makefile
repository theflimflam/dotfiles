DOTFILES="$(HOME)/dotfiles/etc"

zshrc:
	ln -sf $(DOTFILES)/zshrc $(HOME)/.zshrc

taskrc:
	ln -sf $(DOTFILES)/taskrc $(HOME)/.taskrc

nvim:
	mkdir -p $(HOME)/.config/nvim
	ln -sf $(DOTFILES)/nvim.vim $(HOME)/.config/nvim/init.vim
	curl -fLo $(HOME)/.config/nvim/autoload/plug.vim --create-dirs \
	     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim -c "PlugInstall | qa"

