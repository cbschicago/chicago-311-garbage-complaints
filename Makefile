SHELL := /bin/bash

.PHONY: all

all: output/garbage_related_requests_by_police_beat.csv

output/garbage_related_requests_by_police_beat.csv: \
		src/aggregate_data_by_column.py \
		input/garbage-related-complaints.csv
	python $^ police_beat > $@

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
	rm input/*
	rm output/*