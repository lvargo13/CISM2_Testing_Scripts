#!/bin/bash

#Idea: make PreText.txt and PostText.txt files
#Run this script.
#Call all scripts sequentially by Yellowstone head node

#Remove all existing custom config files.

BaseName=runscript_CISM_config_test_
rm "$BaseName"*.sh

#Set file counter to zero
n=0

#Loop through all config combinations
for which_ho_babc in 4 5; do
  for which_ho_approx in 2 3 4; do
    for which_ho_gradient in 0 1; do
      for which_ho_gradient_margin in 0 1 2; do 
        #for glissade_maxiter in 100 200; do
	  for which_ho_precond in 1 2; do
	    for cisminputfile in '/glade/p/cesm/cseg/inputdata/glc/cism/Greenland/glissade/init/greenland_4km.glissade.10kyr.beta6.SSacab_c140919.nc' \
			         '/glade/u/home/sprice/greenland_4km_ICs/nosliding/greenland_4km_2015_03_12.mcb.nofloat.nc'\
			         '/glade/u/home/sprice/greenland_4km_ICs/sliding/greenland_4km_2015_03_12.mcb.nofloat.4310a.beta7.nc'; do
	      for evolution in 3 4; do		 
		for which_ho_assemble_beta in 0 1; do		 
		  #Increment config file counter, set file name.
        	  let n+=1
		  nlong=`seq -f "%03g" $n $n`
        	  fname="$BaseName""$nlong".sh

		  #Counter create new file as a cat'ed copy of PreFile.txt contents
		  cat PreText.txt                                                                   > $fname

		  #Add custom config settings based on loop indices
        	  echo "echo 'which_ho_babc=$which_ho_babc' > user_nl_cism"                       >> $fname
		  echo "echo 'which_ho_approx=$which_ho_approx' >> user_nl_cism"                   >> $fname
		  echo "echo 'which_ho_gradient=$which_ho_gradient' >> user_nl_cism"               >> $fname
		  echo "echo 'which_ho_gradient_margin=$which_ho_gradient_margin' >> user_nl_cism" >> $fname
#		  echo "echo 'glissade_maxiter=$glissade_maxiter' >> user_nl_cism"                 >> $fname
		  echo "echo 'which_ho_precond=$which_ho_precond' >> user_nl_cism"                 >> $fname
		  echo "echo \"cisminputfile='$cisminputfile'\" >> user_nl_cism"  	           >> $fname
		  echo "echo 'evolution=$evolution' >> user_nl_cism"  	                           >> $fname	    
		  echo "echo 'which_ho_assemble_beta=$which_ho_assemble_beta' >> user_nl_cism"     >> $fname

		  #Append PostFile.txt contents after custom configurations
		  cat PostText.txt                                                                 >> $fname

		  sed -i  "s/IG_CISM2_test_XXX/IG_CISM2_test_$nlong/g" $fname

		  chmod +x $fname
		done
	      done
	    done
	  done
#	done
      done
    done
  done
done
