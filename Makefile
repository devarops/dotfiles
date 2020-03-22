.PHONY: install

install:
	cp $$(ls -lap | grep " \." | grep -v / | rev | cut -d" " -f1 | rev) $${HOME}
