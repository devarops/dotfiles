.PHONY: install

install:
	cp $$(ls -lap | grep " \." | grep -v / | rev | cut -d" " -f1 | rev) $${HOME}
	echo "\n\nPor favor actualiza la línea 'bitbucket.password = <CONTRASEÑA>' en '~/.hgrc'\n"

