###################################################################
########              STAT 624 - Spring 2015              #########
########               Assignment 3 - Rhipe               #########
########        Doug Raffle (dcraffle@mix.wvu.edu)        #########
###################################################################

###################################################################
########                    postmsnbc.R                   #########
###################################################################
#### This script takes the distance vectors produced by hadoop and
#### performs agglomerative hierarchical clustering within each
#### subset.

#### Read in byBatch from the binary file.
load("msnbc_distances_bin")


#### now we need to convert the list elements from vectors to distance
#### matrices and cluster them.
cluster.list <- lapply(byBatch, function(l){
    dist.mat <- matrix(0, nrow=17, ncol=17)
    dist.mat[lower.tri(diag(17))] <- l[[2]]
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
    plot(cluster.list[[i]], main=byBatch[[i]][[1]], xlab="",
         ylim=c(0.75, 1))
}))
dev.off()
    
                                          
