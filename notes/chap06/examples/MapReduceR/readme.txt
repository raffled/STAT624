To run this example, use the following commands:

hdfs dfs -put cdata.csv
hadoop jar ${HADOOP_STREAMING_JAR} -inputformat ${HADOOP_INPUTFORMAT} -input cdata.csv -output output -numReduceTasks 1 -mapper mapper.R -reducer reducer.R
hdfs dfs -get output output

The output should now be in the output directory.
