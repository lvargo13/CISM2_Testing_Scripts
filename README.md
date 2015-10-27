# CISM2_Testing_Scripts
Scripts to set up CISM tests
README for CISM2 testing 

Lauren Vargo (lvargo13@gmail.com) and Jeremy Fyke

--- Scripts to set up the testing
- IG_CISM2_run_script_default.sh - default file that runs each test

- generate_cism_input_matrix.sh - generates the test run config combinations

- master.sh - the file that runs multiple tests to run (by changing the #s in the for loop, those are the tests that will run)

- reset_RESUBMIT.sh - sets the number of years that each test will run? 



--- Scripts to analyze test output
- find_CISMTest_files.sh - main script that outputs whether run was successfull or failed, when the run failed, and outputs color-coded (green for successful and red for failed) test numbers to the terminal. The script works by looking for the presence or absence of certain files to determine if the test was successful or if it failed, and if it failed to determine when (build, initialization, or run) the test failed

- test_error.sh - extention of find_CISMTest_files.sh, in addition to outputing whether files ran or failed, it searches for several common errors 
