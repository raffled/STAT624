A Primer on MapReduce and Hadoop
--------------------------------

### Hadoop at Cruising Altitude

Hadoop is a framework for parallel processing: decompose a problem into independent units of work. Use for extract-transform-load (ETL), image processing, data analysis, etc. It is useful for big data and compute intensive tasks.

### A MapReduce Primer

Two phases: Map and Reduce

Map Phase:
1. Each cluster node runs a part of the initial big data and runs a Map task on each record.
2. The Map tasks run in parallel and creates a key/value pair for each record. The key identifies the items pile for the reduce operation. The value is often the record itself.

The Shuffle:
Each key/value pair is assigned a pile based on the key.

Reduce Phase:
1. The cluster nodes then run the Reduce task on each pile.
2. The Reduce task typically emits output for each pile.






