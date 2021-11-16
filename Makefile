.PHONY: install

install:
	ln --force --symbolic ${PWD}/.bash_aliases ~
	ln --force --symbolic ${PWD}/.tmux.conf ~
	ln --force --symbolic ${PWD}/.vimrc ~
	mkdir --parents ~/.config/nvim/
	ln --force --symbolic ${PWD}/.config/nvim/gruvbox.vim ~/.config/nvim/
	ln --force --symbolic ${PWD}/.config/nvim/init.vim ~/.config/nvim/
	ln --force --symbolic ${PWD}/.config/nvim/lightline-bufferline.vim ~/.config/nvim/
	ln --force --symbolic ${PWD}/.config/nvim/telescope.vim ~/.config/nvim/
	ln --force --symbolic ${PWD}/.config/nvim/vim-floaterm.vim ~/.config/nvim/
	mkdir --parents ~/.config/powerline-shell/
	ln --force --symbolic ${PWD}/.config/powerline-shell/config.json ~/.config/powerline-shell/
