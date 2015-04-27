#### clear the output both locally and in hdfs
rm -r mrr-output
hdfs dfs -rm -r mrr-output

#### refresh the source files to make sure we're working with the most
#### up-to-date versions.

hdfs dfs -put cdata.csv
hdfs dfs -put mapper.R
hdfs dfs -put reducer.R

hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming-2.5.0-cdh5.3.1.jar \
-files mapper.R,reducer.R \
-inputformat org.apache.hadoop.mapred.lib.NLineInputFormat \
-input cdata.csv \
-output mrr-output \
-numReduceTasks 1 \
-mapper mapper.R \
-reducer reducer.R

hdfs dfs -get mrr-output

hdfs dfs -rm mapper.R
hdfs dfs -rm reducer.R
hdfs dfs -rm cdata.csv


