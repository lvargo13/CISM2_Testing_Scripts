#!/bin/bash

D=$PWD

#Set name of your simulation
CaseName=IG_CISM2_default

#Set the source code from which to build model
CCSMRoot=/glade/u/home/jfyke/work/CESM_model_versions/cesm1_4_beta04_CISM2_testing

#Call interactive prompt to ask whether to remove existing experiment
#remove_runs.sh $CaseName

#Create new experiment setup
$CCSMRoot/cime/scripts/create_newcase -case $D/$CaseName -compset IGCLM45IS2 -res f09_g16 -mach yellowstone -project P93300601

#Change directories into the new experiment case directory
cd $D/$CaseName

#Change default CISM grid to 4km.
xmlchange CISM_GRID='gland4'

./cesm_setup

#Set model to run for 'RESUBMIT' years, with restarts every 1 year.
xmlchange STOP_OPTION='nyears'
xmlchange STOP_N=1
xmlchange RESUBMIT=50

#Custom-set coupler history output frequency
xmlchange HIST_OPTION='nyears'
xmlchange HIST_N=1

#Custom-set some parameters 
echo 'glcmec_downscale_rain_snow_convert = .true.' > user_nl_clm #downscale rain/snow decision
echo 'ice_limit=10.' >> user_nl_cism #set limit below which ice not considered dynamic (m)

#Build model
$CaseName.build

## Edit run script submission requirements
sed -i 's/BSUB -q .*/BSUB -q regular/g' $CaseName.run
sed -i 's/BSUB -P .*/BSUB -P P93300601/g' $CaseName.run #Development queue=P93300601, Production queue=P93300301
sed -i 's/BSUB -W .*/BSUB -W 00:40/g' $CaseName.run #Set 
#Create shell variable pointing to run/archive directories, and make soft link here for convenience.

RUNDIR=/glade/scratch/lvargo/$CaseName/run
ARCHIVEDIR=/glade/scratch/lvargo/archive/$CaseName
ln -sfn $RUNDIR $D/"$CaseName"_RunDir
ln -sfn $ARCHIVEDIR $D/"$CaseName"_ArchiveDir

$CaseName.submit

