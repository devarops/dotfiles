.PHONY: install

install:
	cp $$(ls -lap | grep " \." | grep -v / | rev | cut -d" " -f1 | rev) $${HOME}
	mkdir --parents ~/.config/nvim && ln --symbolic ~/.vimrc ~/.config/nvim/init.vim
