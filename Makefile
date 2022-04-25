SHELL := /bin/bash
SUBDIRS := $(wildcard */.)

.PHONY: all $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS): venv/bin/activate
	source $< && $(MAKE) -C $@

input/garbage-related-complaints.csv: hand/query.sql
	wget --no-check-certificate --quiet \
		--method GET \
		--timeout=0 \
		--header 'Host: data.cityofchicago.org' \
		-O $@ \
		'https://data.cityofchicago.org/resource/v6vf-nfxy.csv?$$query=$(shell cat $<)'

frozen/distinct_311_sr_types.txt:
	wget --no-check-certificate --quiet \
		--method GET \
		--timeout=0 \
		--header 'Host: data.cityofchicago.org' \
		-O $@ \
		'https://data.cityofchicago.org/resource/v6vf-nfxy.csv?$$select=DISTINCT SR_TYPE'

venv/bin/activate: requirements.txt
	if [ ! -f $@ ]; then virtualenv venv; fi
	source $@ && pip install -r $<
	touch $@

cleanup:
	for d in $(SUBDIRS) ; do \
		cd "$(shell pwd)/$$d" && make cleanup  ; \
	done