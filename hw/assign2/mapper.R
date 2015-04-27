#! /usr/bin/env Rscript

###################################################################
########              STAT 624 - Spring 2015              #########
########               Assignment 2 - Hadoop              #########
########        Doug Raffle (dcraffle@mix.wvu.edu)        #########
###################################################################

###################################################################
########                      mapper.R                    #########
###################################################################
#### This script reads from standard input (with the assumption
#### that is lines from the pre-processed msnbc data),
#### extracts the key, and creates a 1x17 vector with the counts for
#### each category.  This vector, along with the key, is then sent to
#### standard output. 


## get the input
input <- file("stdin", "r")

## loop indefinitely since R lacks an EOF flag
while(TRUE){
    ## grab the current line
    current.line <- readLines(input, n=1)

    ## test to break loop.
    if(length(current.line) == 0) break

    ## split row into its label and counts
    tuple <- unlist(strsplit(current.line, ";"))

    ## grab the key
    key <- tuple[1]

    ## create an object to store counts for each category.  Add names
    ## so we can match categories and counts from the data
    count.vec <- numeric(17)
    names(count.vec) <- 1:17

    ## get counts by category
    current.counts <- table(strsplit(tuple[2], " "))

    ## match the names of the table values to the column names we
    ## set up and assign values accordingly.
    count.vec[names(current.counts)] <- current.counts

    ## Send the key and rows to the standard out.  Use semi-colon to
    ## delimit key and value,  commas to delimit counts.
    cat(paste(key, paste(count.vec, collapse=","), sep=";"), "\n")
}
close(input)
