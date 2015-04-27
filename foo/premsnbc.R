
msnbc <- readLines("msnbc990928.seq")[-(1:6)]
keys <- rep(1:10, each = 1000)

values <- msnbc[c(1:1000, 100001:101000, 200001:201000, 300001:301000, 400001:401000, 500001:501000,
600001:601000, 700001:701000, 800001:801000, 900001:901000)]

new.msnbc <- paste (keys, values, sep="\t")

cat(new.msnbc, file="newmsnbc.txt",sep="\n" )