all: pde install

.PHONY: install pde

install:
	git clone --bare . /home/devarops/dotfiles.git
	git --git-dir=/home/devarops/dotfiles.git --work-tree=/home/devarops/ checkout
	git --git-dir=/home/devarops/dotfiles.git --work-tree=/home/devarops/ config --local status.showUntrackedFiles no

pde:
	mkdir --parent /home/devarops/repositorios
	cd /home/devarops/repositorios && \
	git clone https://github.com/devarops/pde.git && \
	cd pde && \
	make install
