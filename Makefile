SHELL := /bin/bash

GENERATED_FILES: \
		output/garbage_related_requests_by_police_beat.csv \
		output/garbage_related_requests_by_census_tract.csv

.PHONY: all

.INTERMEDIATE: output/garbage-related-complaints.csv

all: $(GENERATED_FILES)

output/garbage_related_requests_by_census_tract.csv: \
		src/aggregate_data_by_column.py \
		output/garbage-related-complaints.csv
	python $^ census_tract > $@

output/garbage_related_requests_by_police_beat.csv: \
		src/aggregate_data_by_column.py \
		output/garbage-related-complaints.csv
	python $^ police_beat > $@

output/garbage-related-complaints.csv: \
		hand/query.sql \
		src/cleanup_police_beats.py \
		src/sjoin_census_tracts.py \
		input/boundaries_census_tracts.geojson
	wget --no-check-certificate --quiet \
		--method GET \
		--timeout=0 \
		--header 'Host: data.cityofchicago.org' \
		-O /dev/stdout \
		'https://data.cityofchicago.org/resource/v6vf-nfxy.csv?$$query=$(shell cat $<)' | \
		python $(word 2, $^) | \
		python $(wordlist 3, 4, $^) > $@

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
	rm -f output/*