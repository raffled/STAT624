###################################################################
########              STAT 624 - Spring 2015              #########
########               Assignment 3 - Rhipe               #########
########        Doug Raffle (dcraffle@mix.wvu.edu)        #########
###################################################################

###################################################################
########                      msnbc.R                     #########
###################################################################
#### This script contains the code needed to run cluster analysis on
#### the categories in the msnbc sequence files using Rhipe to
#### interface with Hadoop.

#### Load required packages, create a temporary directory, and upload
#### the file into it.
library(datadr); library(Rhipe)
rhinit()
h.tmp.dir <- "/user/vagrant/tmp/msnbc"
local.msnbc <- "~/624/hw/assign3/msnbc_preprocessed.seq"
h.msnbc <- paste(h.tmp.dir, "msnbc_preprocessed.seq", sep="/")
h.conn <- hdfsConn(h.tmp.dir, autoYes = TRUE)
rhput(local.msnbc, h.tmp.dir)

#### Create the mapper expression.
map <- expression({
  lapply(seq_along(map.keys), function(r){
    tuple <- unlist(strsplit(map.values[[r]], ";"))
    current.key <- tuple[1]
    current.counts <- table(strsplit(tuple[2], " "))
    current.val <- integer(17)
    current.val[as.integer(names(current.counts))] <- current.counts
    rhcollect(current.key, current.val)
  })
})

#### Create the reducer expression.
reduce <- expression(
  pre = {
    dat <- data.frame()
  }, 
  reduce = {
    dat <- rbind(dat, do.call(rbind, reduce.values))
  },
  post = {
    dist.key <- reduce.key[1]
    dat <- ifelse(as.matrix(dat) == 0, 0, 1)
    xtx <- t(dat) %*% dat
    n.vec <- diag(xtx)
    dist.mat <- sapply(1:ncol(dat), function(i){
      sapply(1:ncol(dat), function(j){
          1 - xtx[i,j]/sum(n.vec[c(i,j)], -xtx[i,j])
      })
    })
    dist.vec <- dist.mat[lower.tri(dist.mat)]
    rhcollect(dist.key, dist.vec)
  }
)

#### Run the map-reducer and get the output.
h.out <- paste(h.tmp.dir, "distances", sep="/")
foo <- rhwatch(
  map = map,
  reduce = reduce,
  input = rhfmt(h.msnbc, type="text"),
  output = rhfmt(h.out, type="sequence"),
  readback = TRUE
)
byBatch <- rhread(h.out, type="sequence")

#### Save the output as an R binary file so we can post-processes it.
save(byBatch, file="msnbc_distances_bin")
