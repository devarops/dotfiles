all: pde install

.PHONY: install pde

install:
	git clone --bare . $${HOME}/dotfiles.git
	git --git-dir=$${HOME}/dotfiles.git --work-tree=$${HOME}/ checkout
	git --git-dir=$${HOME}/dotfiles.git --work-tree=$${HOME}/ config --local status.showUntrackedFiles no

pde:
	mkdir --parent $${HOME}/repositorios
	cd $${HOME}/repositorios && \
	git clone https://github.com/devarops/pde.git && \
	cd pde && \
	make install
