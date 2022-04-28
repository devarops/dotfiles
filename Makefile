all: pde install

.PHONY: install pde

install:
	git clone --bare git@github.com:$USER/dotfiles.git ${HOME}/repositorios/dotfiles.git
	git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} checkout
	git --git-dir=${HOME}/repositorios/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no

pde:
