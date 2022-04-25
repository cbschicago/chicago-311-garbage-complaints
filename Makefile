SHELL := /bin/bash
SUBDIRS := $(wildcard */.)

.PHONY: all $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS): venv/bin/activate
	source $< && $(MAKE) -C $@

venv/bin/activate: requirements.txt
	if [ ! -f $@ ]; then virtualenv venv; fi
	source $@ && pip install -r $<
	touch $@

cleanup:
	for d in $(SUBDIRS) ; do \
		cd "$(shell pwd)/$$d" && make cleanup  ; \
	done