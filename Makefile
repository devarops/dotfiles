.PHONY: install

install:
	git --git-dir=${HOME}/repos/dotfiles.git --work-tree=${HOME} checkout develop
	git --git-dir=${HOME}/repos/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
