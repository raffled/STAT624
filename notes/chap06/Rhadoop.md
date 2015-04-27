R + Hadoop
----------

### Quick Look

Motivation: Run R code over different parameters or inputs.
Solution: Use a Hadoop cluster.
Good because: Hadoop distributes work ovre a cluster of machines.

### How It Works

Submitting work to a Hadoop cluster: *streaming* and *the Java API*.

**Streaming:** write the Map and Reduce operations as R scripts. The Hadoop framework launches the R scripts at appropriate times and communicates by standard input and standard output.

**The Java API:** the Map and Reduce operations are written in Java. The Java code runs Runtime.exec() to invoke the R scripts.

