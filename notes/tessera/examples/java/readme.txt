To run this example, use the following commands:

hdfs dfs -put ../data words
hadoop jar target/WordCount-0.0.1-SNAPSHOT.jar WordCount words words-output 
hdfs dfs -get words-output

The output should now be in the output directory.
