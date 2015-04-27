#######################################################################
############################ run_hadoop.sh ############################
#######################################################################
####   Shell Script to automagically run the homework 2 analysis   ####
#######################################################################
####                           Notes                               ####
#######################################################################
## Run script from within assign2 directory as 'bash run_hadoop.sh'  ##
## See the documentation inside of individual scripts for their      ##
## input/output requirements and behavior.                           ##
#######################################################################

#### perform preprocessing.  
echo "Preprocessing..."
Rscript premsnbc.R

#### clear the output both locally and in hdfs so hadoop doesn't
#### complain
echo -e "\nCleaning up old output..."
if [ -N hw2-output ] ; then
    rm -r hw2-output
fi
hdfs dfs -rm -r hw2-output

#### refresh the source files to make sure we're working with the most
#### up-to-date versions.
if [ -N msnbc_preprocessed.seq ] ; then
    echo -e "\nUpdating data file..."
    hdfs dfs -rm msnbc_preprocessed.seq
    hdfs dfs -put msnbc_preprocessed.seq
fi
if [ -N mapper.R ] ; then
    echo -e "\nUpdating mapper file..."
    hdfs dfs -rm mapper.R
    hdfs dfs -put mapper.R

fi
if [ -N reducer.R ] ; then
    echo -e "\nUpdating reducer file..."
    hdfs dfs -rm reducer.R
    hdfs dfs -put reducer.R
fi


#### run the hadoop job.
echo -e "\nStarting the hadoop job..."
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming-2.5.0-cdh5.3.2.jar \
  -files mapper.R,reducer.R \
  -input msnbc_preprocessed.seq \
  -output hw2-output \
  -mapper mapper.R \
  -reducer reducer.R \
  -numReduceTasks 1

#### create a local copy of hadoop output.
echo -e "\nCreating local copy of output..."
hdfs dfs -get hw2-output

#### postprocess & get dendros.
echo -e "\nPostprocessing..."
Rscript postmsnbc.R

echo -e "\nAll tasks complete."




