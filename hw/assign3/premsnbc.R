###################################################################
########              STAT 624 - Spring 2015              #########
########               Assignment 3 - Rhipe               #########
########        Doug Raffle (dcraffle@mix.wvu.edu)        #########
###################################################################

###################################################################
########                     premsnbc.R                   #########
###################################################################
#### This script reads in the msnbc sequence file and prepends and
#### integer key to each line.  This key is i for the first 1,000
#### of ith set of 100,000 observations.  The lines which receive a
#### key are written to an output file; all other lines are
#### discarded. 

#### read in the data, skip the header info
msnbc.lines <- readLines("msnbc.txt")

#### loop through the data, compute keys, write relevant rows to
#### output file
outfile <- file("msnbc_preprocessed.seq", "w")
invisible(sapply(seq_len(length(msnbc.lines)), function(i){
    mod <- (i %% 100000) - 1001
    if(mod < 0 & mod > -1001){
        key <- (i %/% 100000) + 1
        cat(key, ";", msnbc.lines[i], "\n", sep="", file=outfile)
    }
}))
#### finished up.  close the connection to the output file.
close(outfile)

    
