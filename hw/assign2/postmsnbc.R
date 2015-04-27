###################################################################
########              STAT 624 - Spring 2015              #########
########               Assignment 2 - Hadoop              #########
########        Doug Raffle (dcraffle@mix.wvu.edu)        #########
###################################################################

###################################################################
########                    postmsnbc.R                   #########
###################################################################
#### This script takes the distance vectors produced by hadoop and
#### performs agglomerative hierarchical clustering within each
#### subset.

#### read in the data, split into a list of key-val pairs, and sort by
#### time of day
dist.lines <- readLines("./hw2-output/part-00000")
dist.split <- strsplit(dist.lines, ";")
keys <- sapply(dist.split, function(k) k[1])
dist.list <- lapply(1:length(keys), function(k) dist.split[[k]][2])
names(dist.list) <- keys
dist.list <- dist.list[c(2:10, 1)]

#### now we need to convert the list elements from vectors to distance
#### matrices and cluster them.
cluster.list <- lapply(dist.list, function(l){
    dist.mat <- matrix(0, nrow=17, ncol=17)
    dist.mat[lower.tri(diag(17))] <- as.numeric(unlist(
        strsplit(l, ",")))
    colnames(dist.mat) <- rownames(dist.mat) <- c(
        "frontpage", "news","tech", "local","opinion",
        "on-air","misc", "weather","health", "living", "business",
        "sports", "summary", "bbs", "travel", "msn-news",
        "msn-sports")  
    hclust(as.dist(dist.mat), "ave")
})

## create dendros.
svg("dendros.svg", width=20, height=10)
par(mfrow = c(2, 5))
invisible(sapply(1:length(cluster.list), function(i){
    plot(cluster.list[[i]], main=names(cluster.list)[i], xlab="",
         ylim=c(0.75, 1))
}))
dev.off()
    
                                          
