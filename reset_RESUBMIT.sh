#!/bin/bash

D=$PWD

for dir in `find . -type d -name "IG_CISM2_test_0*"`; do

  cd $D/$dir
  
  echo 'Resetting RESUBMIT IN ' $dir
  
  ./xmlchange RESUBMIT=100

  grep '"RESUBMIT"' env_run.xml

done
