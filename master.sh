#!/bin/bash

for run in {401..864}; do
    runlong=`seq -f "%03g" $run $run`
	./runscript_CISM_config_test_"$runlong".sh

done 

