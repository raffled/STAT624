#! /usr/bin/env Rscript

std.in <- file("stdin", "r")
prev.key <- ""
tmp <- tempfile(pattern = "msnbc_tmp", fileext = "csv")
tmp.handle <- file(tmp, "w")

## loop indefinitely (again, no EOF flag built in).
while(TRUE){
    ## get current line and test for zero-length
    current.line <- readLines(std.in, n=1)
    if(length(current.line) == 0) break

    ## split the observation up in to key and value
    tuple <- unlist(strsplit(current.line, ";"))
    current.key <- as.integer(tuple[1])
    current.val <- tuple[2]

    ## check if we've moved on to a new subset.
    ## Need the extra check for first key.
    if(!isTRUE(all.equal(current.key, prev.key))){
        if(prev.key != ""){
            ## we've finished writing to the key's temp file, so can it.
            close(tmp.handle)

            ## Note that for current.key = i, this code operates on i-1
            ## grab the written data set
            dat <- read.csv(tmp, header=FALSE)

            ## Process it.
            dat <- sapply(dat, function(r) ifelse(r == 0, 0, 1))
            xtx <- t(dat) %*% dat
            n.vec <- diag(xtx)
            dist.mat <- sapply(1:ncol(dat), function(i){
                sapply(1:ncol(dat), function(j){
                    1 - xtx[i,j]/sum(n.vec[c(i,j)], -xtx[i,j])
                })
            })
            result <- paste(dist.mat[lower.tri(dist.mat)], collapse=",")
            ## output results
            cat(prev.key, ";", result, "\n", sep="")
            ## prime the next go-round
            tmp.handle <- file(tmp, "w")
        }
        prev.key <- current.key
    }
    cat(current.val, "\n", file=tmp.handle, append=TRUE)
}

## process the final key.
close(tmp.handle)
dat <- read.csv(tmp, header=FALSE)
dat <- sapply(dat, function(r) ifelse(r == 0, 0, 1))
xtx <- t(dat) %*% dat
n.vec <- diag(xtx)
dist.mat <- sapply(1:ncol(dat), function(i){
    sapply(1:ncol(dat), function(j){
        1 - xtx[i,j]/sum(n.vec[c(i,j)], -xtx[i,j])
    })
})
result <- paste(dist.mat[lower.tri(dist.mat)], collapse=",")
## output results
cat(current.key, ";", result, "\n", sep="")

## clean up
unlink(tmp)
close(std.in)

