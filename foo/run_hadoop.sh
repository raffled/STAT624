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

#### clear the output both locally and in hdfs so hadoop doesn't
#### complain
echo -e "\nCleaning up old output..."
if [ -N hw2-output ] ; then
    rm -r hw2-output
fi
hdfs dfs -rm -r hw2-output

#### refresh the source files to make sure we're working with the most
#### up-to-date versions.
if [ -N newmsnbc.txt ] ; then
    echo -e "\nUpdating data file..."
    hdfs dfs -rm newmsnbc.txt
    hdfs dfs -put newmsnbc.txt
fi
if [ -N mapper_msnbc.R ] ; then
    echo -e "\nUpdating mapper file..."
    hdfs dfs -rm mapper_msnbc.R
    hdfs dfs -put mapper_msnbc.R

fi
if [ -N reducer_msnbc.R ] ; then
    echo -e "\nUpdating reducer file..."
    hdfs dfs -rm reducer_msnbc.R
    hdfs dfs -put reducer_msnbc.R
fi


#### run the hadoop job.
echo -e "\nStarting the hadoop job..."
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming-2.5.0-cdh5.3.2.jar \
  -files mapper_msnbc.R,reducer_msnbc.R \
  -input newmsnbc.txt \
  -output hw2-output \
  -mapper mapper_msnbc.R \
  -reducer reducer_msnbc.R \
  -numReduceTasks 1

#### create a local copy of hadoop output.
echo -e "\nCreating local copy of output..."
hdfs dfs -get hw2-output

#### postprocess & get dendros.
echo -e "\nPostprocessing..."
Rscript postmsnbc.R

echo -e "\nAll tasks complete."




